require 'open-uri'

class ClassesController < ApplicationController

  def index
    render json: get_classes, status: :ok
  end

  def show
    param = params[:id]

    render json: get_timetable(get_classes[param]), status: :ok
  end

  private
    def get_timetable(link)
      doc = Nokogiri::HTML(URI.open("https://zsmeie.torun.pl/plan/#{link}"))
      # puts link

      list = []
      doc.css('.tabela tr').each do | row |
        rowList = []
        if row.css('th').length > 0
          row.css('th').each do | th |
            rowList.push(th.text)
          end
        else
          # puts "lol"
          rowList.push(row.css('.nr').text)
          rowList.push(row.css('.g').text)
          row.css('.l').each do | timetable_item |
            if timetable_item.css('.p').text == ""
              rowList.push(nil)

              next
            end

            # puts timetable_item.css('.p').length
            itemsList = []
            for i in 0..timetable_item.css('.p').length-1 do
              itemHash = {}
              # puts i

              itemHash['subject'] = timetable_item.css('.p')[i].text

              teacher = timetable_item.css('.n')[i]
              # puts teacher.inspect
              # byebug
              itemHash['teacher'] = {'name' => teacher.try(:text), 'href' => teacher.try(:attr, "href")}

              room = timetable_item.css('.s')[i]
              itemHash['room'] = {'name' => room.try(:text), 'href' => room.try(:attr, "href")}

              # rowList.push(itemHash)
              itemsList.push(itemHash)
            end
            rowList.push(itemsList)


          end
        end
        # puts list
        list.push(rowList)
      end

      list
    end

    def get_classes
      doc = Nokogiri::HTML(URI.open('https://zsmeie.torun.pl/plan/lista.html'))
      # puts doc

      elementList = doc.css('ul').first
      list = {}
      elementList.css('li').each do | element |
        anchor = element.css('a').first;
        list[anchor.text] = anchor['href']
      end

      list
    end
end
