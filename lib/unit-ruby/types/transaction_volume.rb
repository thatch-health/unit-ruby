module Unit
  module Types
    class TransactionVolume
      # Business: $0–$10K, $10K–$50K, $50K–$250K, $250K–$1M, $1M–$2M, $2M+
      LESS_THAN_10_K = 'LessThan10K'
      BETWEEN_10_K_AND_50_K = 'Between10KAnd50K'
      BETWEEN_50_K_AND_250_K = 'Between50KAnd250K'
      BETWEEN_250_K_AND_1_M = 'Between250KAnd1M'
      BETWEEN_1_M_AND_2_M = 'Between1MAnd2M'
      GREATER_THAN_2_M = 'GreaterThan2M'

      # Individual
      LESS_THAN_1_K = 'LessThan1K'
      BETWEEN_1_K_AND_5_K = 'Between1KAnd5K'
      BETWEEN_5_K_AND_15_K = 'Between5KAnd15K'
      BETWEEN_15_K_AND_30_K = 'Between15KAnd30K'
      BETWEEN_30_K_AND_60_K = 'Between30KAnd60K'
      GREATER_THAN_60_K = 'GreaterThan60K'

      # Sole Proprietorship
      LESS_THAN_5_K = 'LessThan5K'
      BETWEEN_5_K_AND_20_K = 'Between5KAnd20K'
      BETWEEN_20_K_AND_75_K = 'Between20KAnd75K'
      BETWEEN_75_K_AND_150_K = 'Between75KAnd150K'
      BETWEEN_150_K_AND_300_K = 'Between150KAnd300K'
      GREATER_THAN_300_K = 'GreaterThan300K'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid transaction volume: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
        end

        string_value
      end

      def self.values
        ALLOWED_VALUES
      end
    end
  end
end
