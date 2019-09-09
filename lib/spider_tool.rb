require 'restclient'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require 'json'
require 'yaml'
require 'fileutils'
require 'base64'

class SpiderTool
  MAX_RETRY_TIMES = 5

  def initialize
    spider_dir = File.join(Rails.root, "public", "spider")
    Dir::mkdir(spider_dir) unless File.directory?(spider_dir)

    @root_dir = spider_dir
    @download_error = Logger.new( @root_dir + '/download_error.log')
    @no_doc = Logger.new( @root_dir + '/nodoc_error.log')
    @parse_error = Logger.new( @root_dir + '/parse_error.log')
  end

  def process(spider)
    @spider = spider
    @cookie = @spider.cookie
    @result = []
    @file_result = []
    spider_link = @spider.link
    
    unless @spider.page.blank?
      page_arr = @spider.page.split("-").map do |i|
        i.to_i
      end
      pages = Array(page_arr[0]..page_arr[1])
      pages.each_with_index do |i, index|
        link = spider_link + i.to_s

        doc = get_doc(link)
        if doc.nil?
          @no_doc.error link
          next
        end
  
        parse(doc)

        sleep rand(4..10) 
      end
    else
      doc = get_doc(spider_link)
      if doc.nil?
        @no_doc.error spider_link
      else
        parse(doc)
      end
    end
  end

  def parse(doc)
    @selectors = @spider.selectors
    @selectors.each do |s|
      nodes = doc.css(s.name)

      if nodes.blank?
        next
      end

      unless s.file
        nodes.each do |node|
          @result << node.text
        end
      else
        if nodes[0].name == "img" 
          nodes.each do |node|
            file_name = download_file(node['src'])
            @result << file_name
          end
        else
        end
      end
      @target = File.join(Rails.root, "public", "spider", s.title) 
      File.open(@target + ".yml",'a+'){|f| YAML.dump(@result, f)}
      @result = []
    end
  end
  
  def get_doc(search_link)
    retry_times = 0
    doc = nil
  
    begin
      doc = Nokogiri::HTML(open(search_link))
    rescue Exception => e
      puts "get doc error " + e.message
      retry_times += 1
      @download_error.error "get doc error: #{search_link}"
      retry if retry_times < MAX_RETRY_TIMES
    end
    return doc
  end
  
  def download_file(image)
    begin
      name = Time.now.to_i.to_s + "%04d" % [rand(10000)]
      suffix = image.sub(/.+\./, '')
      img = name + "." + suffix
      File.open("#{@root_dir}/#{img}", "w") do |f|
        f.write(open("#{image}").read.force_encoding('utf-8'))
      end
    rescue Exception => e   
      img = image 
      @download_error.error "download file error: #{image}"
      puts "download file  " + e.message
    end
    return img
  end
  
  def img_base64(image_src)
    file = open(image_src).read
    image = Base64.encode64(file)
  end

end

#COOKIE = {:VerificationCodeNum => '1', :QZ_KSUser => 'UserID=15357507&UserName=ppkao1520606811&UserToken=cw05IVsvRbyxuPoQeQIU4%252bZNshdiFE%252fN6LGCVScB%252bnQLBUYAu7SA7A%253d%253d'}
#doc = Nokogiri::HTML(open(search_link, 
#      "Cookie" => @cookie,
#      "User-Agent" => @agent,
#      "Referer" => "https://study.chinaedu.com/megrez/synchronous/list.do?gradeCode=0201&specialtyCode=02",
#      "Host" => "study.chinaedu.com",
#      :allow_redirections => :all
#      ))


#RestClient.get(search_link, {:cookies => @cookie} ) do |response|
#  puts response
#  doc = Nokogiri::HTML(response.follow_redirection) 
#end

#RestClient.post(url, {access_token: access_token, image: image}, {content_type: @content_type}) do |response|
#  body = JSON.parse(response.body)
#  return body["words_result"][0]["words"]
#end

