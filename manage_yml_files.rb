require 'yaml'

  def get_locales_directories
    Dir.glob("../../**/{*, .*}yml")
  end

  def compare_keys first_file_info, second_file_info
    first_translations = {}
    second_translations = {}
    first_file = Hash.new
    second_file = Hash.new
    deltas_file = Hash.new
    File.open( first_file_info[:file_location] ) { |yf| first_file = YAML.load(yf) }
    process_hash(first_translations, '', first_file[first_file_info[:root]])
    File.open( second_file_info[:file_location] ) { |yf| second_file = YAML.load(yf) }
    process_hash(second_translations, '', second_file[second_file_info[:root]])
    first_keys_sort = first_translations.keys.sort
    second_keys_sort = second_translations.keys.sort
    puts first_keys_sort == second_keys_sort
    puts "first #{first_translations.keys.count}"
    puts "second #{second_translations.keys.count}"
    # Just because the counts are equal doesn't mean the keys are the same
    if first_translations.keys.count >= second_translations.keys.count
      puts "first - second"
      puts "Difference #{(first_keys_sort - second_keys_sort)}"
    else
      puts "second - first"
      puts "Difference #{(second_keys_sort - first_keys_sort)}"
    end
  end

  def process_hash(translations, current_key, hash)
    hash.each do |new_key, value|
      combined_key = [current_key, new_key].delete_if { |k| k.to_s.empty? }.join('.')
      if value.is_a?(Hash)
        process_hash(translations, combined_key, value)
      else
        translations[combined_key] = value
      end
    end
  end
