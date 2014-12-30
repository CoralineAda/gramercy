module Gramercy
  module Meta
    class Root

      include Neo4j::ActiveNode

      property :base_form, index: :exact
      property :created_at, type: DateTime

      validates_presence_of :base_form
      validates_uniqueness_of :base_form

      has_many :both, :contexts, model_class: Meta::Context, rel_class: Meta::Expression

      def positivity_in_context(context)
        query_as(:w).match('s-[EXPRESSED_AS]->n1').where("n1.base_form='#{self.base_form}'").pluck('EXPRESSED_AS.positivity').first
      end

      def antonyms_in_context(context)
        context.antonyms_for(self)
      end

      def synonyms_in_context(context)
        context.words_with_positivity(self.positivity_in_context(context))
      end

    end
  end
end