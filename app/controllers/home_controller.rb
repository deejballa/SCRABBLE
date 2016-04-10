class HomeController < ApplicationController
  def index
    possible_match = params['character']
    exact_match = params['character_exact']
    @result_set = Words.find_matches possible_match, false
    @exact_result_set = Words.find_matches exact_match, true
  end
end
