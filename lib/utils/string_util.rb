class StringUtil
  def self.remove_unnecessary_content(characters)
    characters.gsub(/\s+|[^A-Za-z]/, '')
  end

  def self.remove_whitespace(characters)
    characters.gsub(/\s/, '')
  end
end