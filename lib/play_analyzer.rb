class PlayAnalyzer

  def initialize(source_type)
    @source_type = source_type
    @source      = source_type.source
  end

  def words_by_characters(name)
    results = {}

    @source.xpath("//SPEECH").each do |speech|
      speakers = speech.xpath('SPEAKER').map(&:text)
      words_at_speech = speech.xpath('LINE').map { |line| line.text.split(/\W+/)}.flatten
      speakers.each do |speaker|
        results[speaker] ||= Hash.new(0)
        words_at_speech.each do |word|
          results[speaker][word.downcase] += 1
        end
      end
    end

    results[name].sort
  end

  def characters
    @source.xpath("//PERSONA").map { |character| clean_character_name(character.text) }.flatten
  end

  def characters_spoken_lines
    results = Hash.new(0)

    @source.xpath("//SPEECH").each do |speech|
      speakers = speech.xpath('SPEAKER').map(&:text)
      lines_at_speech = speech.xpath('LINE').size
      speakers.each { |speaker| results[speaker] += lines_at_speech }
    end

    results.to_a
  end

  private

  def clean_character_name(character)
    uppercased_character = character.scan(/\b[A-Z]+\b/)

    return character if uppercased_character[0]&.length == 1
    return uppercased_character if uppercased_character.size == 1
    return uppercased_character.join(" ") if uppercased_character.size > 1

    character
  end
end
