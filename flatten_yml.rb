require 'yaml'

yml = %Q{
en:
  questions:
    new: 'New Question'
    other:
      recent: 'Recent'
      old: 'Old'
}

yml = YAML.load(yml)
translations = {}

def process_hash(translations, current_key, hash)
  hash.each do |new_key, value|
    combined_key = [current_key, new_key].delete_if { |k| k.empty? }.join('.')
    if value.is_a?(Hash)
      process_hash(translations, combined_key, value)
    else
      translations[combined_key] = value
    end
  end
end

process_hash(translations, '', yml['en'])
p translations
