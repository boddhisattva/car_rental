# frozen_string_literal: true

class InvalidRecordError < StandardError; end

class DataValidator
  def initialize(required_attributes)
    @required_attributes = required_attributes
  end

  def validate(record, entity_name)
    error_messages = []

    if required_attributes_are_not_present?(record, entity_name)
      error_messages = collect_error_messages_for_missing_attributes(record, entity_name)
    end

    record_attributes_without_a_value = filter_record_attributes_without_a_value(record, entity_name)
    if record_attributes_without_a_value.any?
      value_error_messages = collect_error_messages_for_attributes_without_a_value(record_attributes_without_a_value, entity_name)
      error_messages.concat(value_error_messages)
    end

    raise InvalidRecordError, error_messages.join(', ') if error_messages.any?
  end

  private

    attr_reader :required_attributes

    def required_attributes_are_not_present?(record, entity_name)
      !record.keys.eql?(required_attributes.fetch(entity_name))
    end

    def collect_error_messages_for_missing_attributes(record, entity_name)
      missing_keys = collect_missing_attributes(record, entity_name)

      missing_keys.map do |key|
        "#{key} attribute related key value pair is missing for #{entity_name} entity in the given input file"
      end
    end

    def collect_missing_attributes(record, entity_name)
      @missing_keys ||= required_attributes.fetch(entity_name) - record.keys
    end

    def filter_record_attributes_without_a_value(record, entity_name)
      valid_attributes = required_attributes.fetch(entity_name) - collect_missing_attributes(record, entity_name)

      valid_attributes.select { |key| record[key].to_s.empty? }
    end

    def collect_error_messages_for_attributes_without_a_value(keys, entity_name)
      keys.map do |key|
        "The value is not present for the '#{key}' key in the given input file with regard to the #{entity_name} entity"
      end
    end
end
