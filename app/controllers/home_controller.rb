require 'set'

class HomeController < ApplicationController
  def index
    prms = params['character']
    find_all_words prms
  end

  def find_all_words (characters)
    if !characters.blank?
      @result_set = Set.new

      #remove whitespace and special characters. Normally I'd do validation and let the user know they shouldn't input special characters and just strip whitespace
      characters = characters.gsub(/\s+|[^A-Za-z]/, '')

      #Performance is much better when you aren't "slurping" files
      File.foreach('app/assets/docs/wordlist.csv') { |ma|
        ma = ma.gsub(/\s/, '')
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
          @result_set.add(ma)
        end
      }
    end
  end

  # TODO create method to find words that use all characters

end
