require 'spec_helper'
require 'yaml'

describe 'testing' do
  let(:key) { "en.admin.remote.element_creation.no_access_url" }
  let(:root_path) { "/Users/bvatne/coding/partnerpedia/config/locales" }
  let(:yml_files) { Dir[root_path + '/**/*.yml'] }

  it 'finds it' do
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

      unless value.nil?
        match = {:value => value, :key => keys.last, :file => yml_file, :line_numbers => []}
      end
    end

    if match.nil?
      puts "Translation not found!"
    else
      File.open(match[:file]) do |f|
        line_number = 0
        while line = f.gets
          line_number = line_number + 1
          if line.match(/^\s*#{match[:key]}:\s*["']?#{Regexp.quote(match[:value])}["']?\s*$/)
            match[:line_numbers] << line_number
          end
        end
      end

      p match
    end
  end
end
