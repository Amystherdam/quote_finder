require 'nokogiri'
require 'open-uri'

class Robot
  link_quotes_site = { quotes_to_scrape: 'https://quotes.toscrape.com' }

  link_quotes_site.each do | key, value |
    QUOTES_SITE = link_quotes_site[:quotes_to_scrape]
  end

  def site_html_finder uri
    site_file = URI.open(uri)
    reader_file = Nokogiri::HTML(site_file)
  end

  def quotes_finder site_html_finder
    site_html_finder.css('div.col-md-8').css('div.quote')
  end

  def current_tag_iterator
    internal_tags_iterator = 0
    while @links_tags_box[@tag_block_iterator][internal_tags_iterator] != nil
      print QUOTES_SITE
      puts @links_tags_box[@tag_block_iterator][internal_tags_iterator]
      internal_tags_iterator += 1
    end
  end

  def runner_quote_elements
    @links_tags_box = []
    @tag_block_iterator = 0
    quotes_finder(site_html_finder(QUOTES_SITE)).each do | quote_box |
      puts quote_box.css('span.text').text
      puts quote_box.css('span').css('small').text
      print QUOTES_SITE
      puts quote_box.css('span').css('a').map { | link | link['href']}
      tags_quotes_link = quote_box.css('div.tags').css('a').map { | link | link['href']}

      @links_tags_box.push(tags_quotes_link)
      current_tag_iterator()
      puts '=================================================='

      @tag_block_iterator += 1
    end
  end
end