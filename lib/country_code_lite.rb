require "yaml"
require "country_code_lite/version"

module CountryCodeLite
  # extend self
  class Error < StandardError; end

  DICTIONARY = YAML.load_file(File.expand_path(File.join("..", "country_code_lite", "country_codes.yml"), __FILE__)).freeze

  class Entry < Struct.new(:name, :en_name, :number, :code); end

  class << self
    def find_by_name(name)
      entries = DICTIONARY.sort { |a, b| b["name"] <=> a["name"] }

      entry = entries.select do |e|
        name == e["name"]
      end.first

      if entry
        Entry.new(entry["name"], entry["en_name"], entry["number"], entry["code"])
      else
        nil
      end
    end

    def find_by_code(code)
      entry = DICTIONARY.select do |e|
        code.upcase == e["code"]
      end.first

      if entry
        Entry.new(entry["name"], entry["en_name"], entry["number"], entry["code"])
      else
        nil
      end
    end

    def find_by_number(number)
      entries = DICTIONARY.sort { |a, b| b["number"] <=> a["number"] }

      entry = entries.select do |e|
        number == e["number"]
      end.first

      if entry
        Entry.new(entry["name"], entry["en_name"], entry["number"], entry["code"])
      else
        nil
      end
    end

    def to_number(phone, code, with_plus = true)
      if with_plus
        "+#{code}#{phone}"
      else
        "#{code}#{phone}"
      end
    end

    def countries
      DICTIONARY.sort { |a, b| b["number"] <=> a["number"] }
    end
  end
end
