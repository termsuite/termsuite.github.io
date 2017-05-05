module Jekyll
  RESOURCE_PREFIX = "https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/"
  class Resource
    attr_reader :name, :url
    def initialize(name, url)
      @name, @url = name, url
    end
  end

  class TermsuiteModule < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      @attributes = {}
      @markup = markup
      @markup.scan(::Liquid::TagAttributes) do |key, value|
        # Strip quotes from around attribute values
        @attributes[key] = value.gsub(/^['"]|['"]$/, '')
      end
      @title = @attributes["title"] || raise("Missing attribute title to tag #{tag_name}")
      @source = @attributes["source"] || raise("Missing attribute source to tag #{tag_name}")
    end

    def resources
      @resources ||= begin
        @attributes.to_a.select do |res_name, res_path|
          res_name != "title" && res_name != "source"
        end.map do |res_name, res_path|
          Resource.new(res_name, RESOURCE_PREFIX + res_path)
        end
      end
    end

    def render(context)
str = %{
  <table class="table table-bordered">
    <tbody>
        <tr>
          <td>Source code:</td>
          <td><a title="#{@title} source code" href="#{@source}">#{@title}</a></td>
        </tr>
        <tr>
          <td>Resource#{resources.length > 1 ? "s" : ""}:</td>
          <td>}

if(resources.empty?)
  str += "(No TermSuite resource required for this module)"
else
  str += resources.map do |resource|
   %{<a title="#{resource.name}" href="#{resource.url}">#{resource.name}</a>}
 end.join(", ")
end

str+=%{</td>
        </tr>
    </tbody>
  </table>
}

str
    end
  end
end

Liquid::Template.register_tag('termsuite_module', Jekyll::TermsuiteModule)
