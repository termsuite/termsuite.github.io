require 'fileutils'

module TermSuite
  class Example
    def initialize site, path, branch
      @site, @example_path, @branch = site, path, branch
      raise("Firest param must be a Jekyll:Site. Got #{site.class}") unless site.is_a?(Jekyll::Site)
      @example_path = @example_path.gsub /^\/+/, ""
      @example_url = "https://github.com/termsuite/termsuite-core/tree/#{@branch}/examples/#{@example_path}"
      @example_raw_url = "https://raw.githubusercontent.com/termsuite/termsuite-core/#{@branch}/examples/#{@example_path}"
      @example_uri = URI(@example_raw_url)
    end

    def cache_path
      cp = File.join @site.config['source'], "_http_cache", @example_path
      cp = File.expand_path(cp)
      FileUtils.mkdir_p File.dirname(cp)
      cp
    end

    def to_txt
      cached = cache_path
      @txt ||= begin
        if File.exists?(cached)
          IO.read(cached)
        else
          puts "HTTP GET #{@example_uri}"
          res = Net::HTTP.get_response(@example_uri)
          puts "\t\t-->#{res.code}"
          raise("Got HTTP #{res.code} - #{@example_uri}") unless res.is_a?(Net::HTTPSuccess)
          str = res.body
          File.open(cached, "w") {|f| f.puts(str)}
          str
        end
      end
    end

    def lines
      to_txt.split(/\n/).map(&:chomp)
    end

    def header_lines
      hlines = []
      for line in lines
        next if line.strip.empty?
        if line.start_with?("#")
          l = line.gsub /^\s*#\s/, ""
          hlines << l
        else
          break
        end
      end
      hlines
    end

    def front_matter
      @front_matter ||= begin
        startf = header_lines.index "---"
        return {} if startf.nil?
        endf = startf + header_lines[(startf+1)..-1].index("---")
        return {} if endf.nil?
        fmatter = header_lines[startf..endf].join("\n")
        puts "startf: #{startf}\nendf:   #{endf}"
        YAML.load(fmatter)
      end
    end

    def body
      @body ||= begin
        lines
          .select{|line| !line.strip.chomp.start_with?("#") }
          .select{|line| !line.strip.chomp.empty? }
          .join("\n")
      end
    end

    def title
      front_matter["title"] || @example_path
    end

    def excerpt
      front_matter["excerpt"] || ""
    end

    def language
      front_matter["language"] || front_matter["lang"]
    end

    def tsv
      front_matter["tsv"]
    end
  end
end
