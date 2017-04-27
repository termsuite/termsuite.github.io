require_relative "example"

module TermSuite
  class << self
    def config
      @config ||= File.open("_termsuite.yml") { |file| YAML.load(file) }
    end

    def home
      config["home"]
    end

    def version
      Jekyll::Site.config["termsuite"]["version"]
    end

    def jar_path
      File.join config["home"], "termsuite-core-#{version}.jar"
    end
  end
end
