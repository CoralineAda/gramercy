module MarkovGrammar
  class Article

    include Mongoid::Document

    validates_uniqueness_of :base_form

    field :base_form
    field :plurality
    field :is_indefinite, type: Boolean, default: false

    def self.indefinite
      where(is_indefinite: true)
    end

    def self.definite
      where(is_indefinite: false)
    end

    def self.matching_plurality(word)
      any_in( plurality: [nil, word.plurality] )
    end

    def self.join_with_matching(article_in_form, noun_in_form)
      return "#{article_in_form} #{noun_in_form}" unless article_in_form == "a" || article_in_form == "an"
      %w{a e i o}.include?(noun_in_form[0]) ? "an #{noun_in_form}" : "a #{noun_in_form}"
    end

  end
end