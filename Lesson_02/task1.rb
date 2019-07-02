# frozen_string_literal: true

months = { Deceber: 31, January: 31, February: 29,\
           March: 31, April: 30, May: 31,\
           June: 30, July: 31, August: 31,\
           September: 30, October: 31, November: 30 }

months.each { |key, value| puts key.to_s if value == 30 }
