module GOVUKDesignSystemFormBuilder
  class Base
    def initialize(builder, object_name, attribute_name)
      @builder = builder
      @object_name = object_name
      @attribute_name = attribute_name
    end

    def html
      fail 'should be overridden'
    end

    def hint_id
      return nil unless @text.present?

      @hint_id || [@object_name, @attribute_name, 'hint'].join('-').parameterize
    end

    def error_id
      return nil unless has_errors?

      [@object_name, @attribute_name, 'error'].join('-').parameterize
    end

    def conditional_id
      [@object_name, @attribute_name, @value, 'conditional'].join('-').parameterize
    end

    def has_errors?
      @builder.object.invalid? &&
        @builder.object.errors.messages.keys.include?(@attribute_name)
    end

    def attribute_descriptor
      [@object_name, @attribute_name, @value].compact.join('_')
    end

    def attribute_identifier
      "%<object_name>s[%<attribute_name>s]" % {
        object_name: @object_name,
        attribute_name: @attribute_name
      }
    end
  end
end
