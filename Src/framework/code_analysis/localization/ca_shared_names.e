note
	description: "Provides shared access to name and message strings for the Code Analyzer."
	author: "Stefan Zurfluh", "Eiffel Software"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SHARED_NAMES

feature -- Names

	ca_names: CA_NAMES
			-- Name strings for the Code Analyzer.
		once
			create Result
		ensure
			valid_result: Result /= Void
		end

	ca_messages: CA_MESSAGES
			-- Message strings for the Code Analyzer.
		once
			create Result
		ensure
			valid_result: Result /= Void
		end

feature {NONE} -- Preferences

	frozen full_rule_preference_name (preference_name: STRING; rule_name: STRING): STRING
			-- A full preference name for `preference_name` associated with a rule `rule_name`.
			-- Every rule has a separate sub namespace so that in the preferences dialog,
			-- the rule will have its own folder.
		require
			not preference_name.is_empty
			not preference_name.has ('.')
			not rule_name.is_empty
			not rule_name.has ('.')
		do
			Result := "rule." + rule_name + "." + preference_name
		ensure
			not Result.is_empty
		end

feature {NONE} -- String validation

	frozen is_integer_string_within_bounds (a_value: attached READABLE_STRING_GENERAL; a_lower, a_upper: INTEGER): BOOLEAN
			-- Is the integer string `a_value' within the interval [`a_lower', `a_upper']?
		require
			is_integer: a_value.is_integer
		local
			int: INTEGER
		do
			int := a_value.to_integer
			if int >= a_lower and int <= a_upper then
				Result := True
			end
		end

end
