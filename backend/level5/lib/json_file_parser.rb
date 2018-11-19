# frozen_string_literal: true

class JsonFileParser
  def initialize(file_name)
    @file_name = file_name
  end

  def parse
    raise 'Specified file name does not exist' unless File.exist?(file_name)
    raise 'Specified file is empty' if File.zero?(file_name)

    parse_data(file_name)
  end

  private
    attr_reader :file_name

    def parse_data(file_name)
      input = ''

      File.foreach(file_name) do |line|
        input += line
      end

      JSON.parse(input)
    end
end
