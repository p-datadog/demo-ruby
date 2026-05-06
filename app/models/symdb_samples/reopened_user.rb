# frozen_string_literal: true

# Exercises: class reopened across two files. Pairs with reopened_user_ext.rb,
# which adds another STATIC_FIELD to the same class. Used by manual-test-plan.md
# Test 12 to verify cross-file field merge in source-line completions.
module SymdbSamples
  class ReopenedUser
    MAX_LOGIN_ATTEMPTS = 5

    def authenticate(token)
      token == "secret"
    end
  end
end
