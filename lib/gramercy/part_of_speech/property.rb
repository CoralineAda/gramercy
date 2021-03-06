module Gramercy
  module PartOfSpeech
    class Property

      include Neo4j::ActiveNode

      property :name, index: :exact
      property :value

      has_one :in, :generic, model_class: PartOfSpeech::Generic

    end
  end
end