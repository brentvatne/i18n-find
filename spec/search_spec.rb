require 'spec_helper'
require 'yaml'

class TranslationNotInThisFile; end

describe 'testing' do
  let(:key) { "en.storefront.search.product_search_result.publisher" }
  let(:yml_files) { Dir[Dir.pwd + '/spec/translations/**/*.yml'] }

  it 'finds it' do
    puts yml_files.inspect
    keys = key.split(/\./)
    matches = []

    yml_files.each do |yml_file|
      search_keys  = keys.dup
      translations = YAML.load_file(yml_file)
      value = translations[search_keys.shift]

      until search_keys.empty?
        break if value.nil?
        value = value[search_keys.shift]
      end

      matches << {:value => value, :key => keys.last, :file => yml_file} unless value.nil?
      # fetch it
      # does it exist?
      #   record the last key, value, and file to matches
      #   { :key => keys.first, :value => value, :file => yml_file}
    end

    if matches.empty?
      puts "Translation not found!"
    else
      p matches
    end
    # output results
  end
end
