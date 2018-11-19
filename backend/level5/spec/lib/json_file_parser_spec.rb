# frozen_string_literal: true

describe JsonFileParser do
  describe '#parse' do
    context 'given a file name' do
      context 'no file exists based on specified file name' do
        it 'raises an appropriate error message' do
          file_name = 'random file name'
          file_parser = JsonFileParser.new(file_name)

          expect { file_parser.parse }.to raise_error 'Specified file name does not exist'
        end
      end

      context 'file is empty' do
        it 'raises an appropriate error message' do
          file_name = 'spec/fixtures/empty_input.json'
          file_parser = JsonFileParser.new(file_name)

          expect { file_parser.parse }.to raise_error('Specified file is empty')
        end
      end

      context 'file exists' do
        it 'returns parsed data containing information related to different entities' do
          file_name = 'data/input.json'

          parsed_info = JsonFileParser.new(file_name).parse

          expect(parsed_info.keys).to eq(%w[cars rentals options])
        end
      end
    end
  end
end
