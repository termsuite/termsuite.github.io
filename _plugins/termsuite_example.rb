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

      @tsv_on = @attributes["tsv_from"] \
                    || @attributes["tsv_to"] \
                    || @attributes["tsv_slices"]
      @tsv_from = (@attributes["tsv_from"] || 1).to_i
      @tsv_to = (@attributes["tsv_to"] || 25).to_i
      @tsv_slices = @attributes["tsv_slices"] ?
                      (eval(@attributes["tsv_slices"])) :
                        [[@tsv_from, @tsv_to]]


    end

    def render(context)

      @example = TermSuite::Example.new context.registers[:site], @path, @branch
      string = %{

#### #{@example.title}

#{@example.excerpt}

**Command Line**

```#{@example.language || @language}
#{@example.body}
```

**Docker**

```#{@example.language || @language}
#{@example.docker_body}
```
}
    if(@tsv_on)
      string+=%{
**Output TSV file (#{@example.tsv_lines.length} lines)**

See [how to interprete terminology TSV output file](/documentation/terminology-tsv-output).

```
#{@example.tsv(@tsv_slices)}
```}
    end
    string
    end
  end
end

Liquid::Template.register_tag('termsuite_example', Jekyll::TermsuiteExample)
