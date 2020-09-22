# frozen_string_literal: true

module TrelloFreestyler
  class Utils
    def self.deep_deep_clean(hash)
      # Sometimes removing one layer of empty objects creates another.
      # So loop until cleaning is no longer detecting changes.
      current_state = deep_copy(hash) # Who knew that object mutation was bad
      loop do
        new_state = deep_clean(hash)
        return current_state if current_state == new_state

        current_state = new_state
      end
    end

    def self.deep_clean(hash)
      return hash unless hash.is_a?(Hash)

      scrubed = hash.delete_if { |_, value| value == {} }
      scrubed.transform_values do |val|
        deep_clean(val)
      end
    end

    def self.deep_copy(obj)
      Marshal.load(Marshal.dump(obj))
    end
  end
end
