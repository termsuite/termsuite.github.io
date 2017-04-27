require 'net/http'
require_relative "example"

module Jekyll
  class TermsuiteExample < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      @attributes = {}
      @markup = markup
      @markup.scan(::Liquid::TagAttributes) do |key, value|
        # Strip quotes from around attribute values
        @attributes[key] = value.gsub(/^['"]|['"]$/, '')
      end
      @branch = @attributes["branch"] || "master"
      @path =  @attributes["path"] || raise("Missing attribute path to tag #{tag_name}")
      @language = @attributes["language"] || @attributes["lang"] || ""
    end

    def render(context)
      @example = TermSuite::Example.new context.registers[:site], @path, @branch
      %{

#### #{@example.title}

#{@example.excerpt}

```#{@example.language || @language}
#{@example.body}
```

}
    end
  end
end

Liquid::Template.register_tag('termsuite_example', Jekyll::TermsuiteExample)
