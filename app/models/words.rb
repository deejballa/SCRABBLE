require 'set'
require './lib/utils/string_util'

class Words < ActiveRecord::Base
  def self.find_matches(characters, is_exact)
    result_set = Set.new
    if characters.present?
      #remove whitespace and special characters. Normally I'd do validation and let the user know they shouldn't input special characters and just strip whitespace
      characters = StringUtil.remove_unnecessary_content(characters)

      #Performance is much better when you aren't "slurping" files
      File.foreach('app/assets/docs/wordlist.csv') { |ma|
        ma = StringUtil.remove_whitespace(ma)
        tmp_characters = characters.downcase
        ma = ma.downcase
        is_valid_word = true
        ma.each_char { |m|
          if tmp_characters.include?(m)
            #remove items from tmp_character
            tmp_characters = tmp_characters.sub(/#{m}/, '')
          else
            is_valid_word = false
            break
          end
        }
        if is_valid_word
          if is_exact
            if ma.length == characters.length
              result_set.add(ma)
            end
          else
            result_set.add(ma)
          end
        end
      }
    end
    result_set
  end
end