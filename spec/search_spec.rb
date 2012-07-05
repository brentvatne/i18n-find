require 'spec_helper'
require 'yaml'

class TranslationNotInThisFile; end

describe 'testing' do
  let(:key) { "en.storefront.search.product_search_result.publisher" }
  let(:yml_files) { Dir[Dir.pwd + '/spec/translations/**/*.yml'] }

  it 'finds it' do
    puts yml_files.inspect
    keys = key.split(/\./)
    match = nil

    yml_files.each do |yml_file|
      search_keys  = keys.dup
      translations = YAML.load_file(yml_file)
      value = translations[search_keys.shift]

      until search_keys.empty?
        break if value.nil?
        value = value[search_keys.shift]
      end

      match = {:value => value, :key => keys.last, :file => yml_file, :line_numbers => []} unless value.nil?
    end

    File.open(match[:file]) do |f|
      line_number = 0
      while line = f.gets
        line_number = line_number + 1
        if line.match(/^\s*#{match[:key]}:\s*["']?#{Regexp.quote(match[:value])}["']?\s*$/)
          match[:line_numbers] << line_number
        end
      end
    end

    if match.nil?
      puts "Translation not found!"
    else
      p match
    end
  end
end
