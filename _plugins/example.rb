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

    CMD_REGEX = /^java.*fr.univnantes.termsuite.tools.(\w+)/m
    TT_REGEX = /\s+-t\s+\$TREETAGGER_HOME\s+\\\s*$/

    def docker_body
      str = body.clone
      md = str.match CMD_REGEX
      case md[1]
      when "AlignerCLI" then str.gsub! CMD_REGEX, "termsuite align"
      when "TerminologyExtractorCLI" then str.gsub! CMD_REGEX, "termsuite extract"
      when "PreprocessorCLI"then str.gsub! CMD_REGEX, "termsuite preprocess"
      else raise("Command not recognized: #{md[1]}")
      end
      str.gsub! TT_REGEX, ""
      str
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

    def tsv_path
      @tsv_path ||= begin
        tp = File.join @site.config['source'], "_includes", "generated", "examples", @example_path
        tp.gsub! /\.sh$/, ".tsv"
        File.exists?(tp) || raise("No such TSV file: #{tp}")
        tp
      end
    end

    def tsv_lines
      IO.readlines(tsv_path)
    end

    def tsv_interval(from, to)
      tsv_lines[from..to].join
    end

    def tsv(slices)
      str, index, last_to = "", 0, -1
      slices.map! do |from, to|
        from = tsv_lines.length + from if from < 0
        to = tsv_lines.length + to if to < 0
        raise("Bad slice bounds inf > sup: [#{from}, #{to}]") if from > to
        [from,to]
      end.sort!

      slices.each do |from, to|
        raise("Slices overlap: #{slices}") if last_to >= 0 && from <= last_to
        if index > 0
          str +="--- lines #{last_to + 1} to #{from - 1} ---\n"
        end
        str += tsv_interval(from, to)
        last_to = to
        index += 1
      end
      str+="--- END OF FILE"
      str
    end


  end
end
