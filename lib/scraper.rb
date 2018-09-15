require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".roster-cards-container .student-card").each do |student|
      students << {:name => student.css(".card-text-container .student-name").text,
                   :location => student.css(".card-text-container .student-location").text,
                   :profile_url => student.children.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    doc.css(".main-wrapper .vitals-container .social-icon-container").collect do |link|
      has = {:twitter => link.children.css("a").attribute("href").value
      }
    end

    puts has
    binding.pry
    # => {:twitter=>"http://twitter.com/flatironschool",
  #    :linkedin=>"https://www.linkedin.com/in/flatironschool",
  #    :github=>"https://github.com/learn-co,
  #    :blog=>"http://flatironschool.com",
  #    :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  #    :bio=> "I'm a school"
  #   }
  end

end
