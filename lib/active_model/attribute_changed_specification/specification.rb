module AttributeChangedSpecification
  module ::ActiveModel
    module Dirty

      private

        def attribute_changed_with_specification?(attr, *args)
          if args.empty?
            attribute_changed_without_specification?(attr)
          else
            return false unless self.changes.include?(attr)
            from = args[0][:from]
            to   = args[0][:to]

            if from && to
              [from].flatten.include?(self.changes[attr][0]) && [to].flatten.include?(__send__(attr))
            elsif from
              [from].flatten.include?(self.changes[attr][0])
            elsif to
              [to].flatten.include?(__send__(attr))
            else
              attribute_changed_without_specification?(attr, args)
            end
          end
        end
        alias_method_chain :attribute_changed?, :specification

    end
  end
end
