note
	description: "Obsolete code detection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_OBSOLETE_FEATURE

inherit
	DATE_VALIDITY_CHECKER
	INTERNAL_COMPILER_STRING_EXPORTER
	CA_SHARED_NAMES

feature {NONE} -- Creation

	make (m: PREFERENCE_MANAGER)
			-- Initialize using preferences from `m`.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			feature_call_expiration := l_factory.new_integer_preference_value (m,
				preference_option_name_feature_call_expiration, default_feature_call_expiration)
			feature_call_expiration.set_default_value (default_feature_call_expiration.out)
			feature_call_expiration.set_validation_agent (agent is_integer_string_within_bounds (?, 1, {like {DATE_DURATION}.days_count}.max_value))
			feature_call_expiration.set_restart_required (True)
			feature_call_suppression_period := l_factory.new_integer_preference_value (m,
				preference_option_name_feature_call_suppression_period, default_feature_call_suppression_period)
			feature_call_suppression_period.set_default_value (default_feature_call_suppression_period.out)
			feature_call_suppression_period.set_validation_agent (agent is_integer_string_within_bounds (?, 1, {like {DATE_DURATION}.days_count}.max_value))
			feature_call_suppression_period.set_restart_required (True)
		end

feature {NONE} -- Preferences

	preference_option_name_feature_call_expiration: STRING
			-- A name of a call expiration option within the corresponding preference namespace.
		do
			Result := full_rule_preference_name (option_name_feature_call_expiration, {CA_OBSOLETE_FEATURE_CALL_RULE}.name)
		end

	option_name_feature_call_expiration: STRING = "call_expiration"
			-- A name of a call expiration option.

	default_feature_call_expiration: INTEGER = 366
			-- The default call expiration period necessary to trigger a rule violation.

	feature_call_expiration: INTEGER_PREFERENCE
			-- The call expiration necessary to trigger a rule violation.

	preference_option_name_feature_call_suppression_period: STRING
			-- A name of a call suppression period option within the corresponding preference namespace.
		do
			Result := full_rule_preference_name (option_name_feature_call_suppression_period, {CA_OBSOLETE_FEATURE_CALL_RULE}.name)
		end

	option_name_feature_call_suppression_period: STRING = "suppression_period"
			-- A name of a call suppression period option.

	default_feature_call_suppression_period: INTEGER = 183
			-- The default call suppression period when the rule violation for an obsolete feature call can be disabled.

	feature_call_suppression_period: INTEGER_PREFERENCE
			-- The call supression period after which the rule violation cannot be disabled anymore.

feature {NONE} -- Date evaluation

	date (m: STRING): TUPLE [message: STRING; date: DATE; is_specified: BOOLEAN]
			-- Date specified in the message `m` if any.
			-- If a date is extracted to `Result.date`, the message without date information is returned in `Result.message`, and `Result.is_specified` is set to `True`.
			-- If no date is extracted, the original message is returned in `Result.message`, `Result.date` is set to the default date, and `Result.is_specified` is set to `False`.
		local
			i, j: like {STRING}.count
			c: CHARACTER
			date_string: STRING
		do
				-- Look for a trailing ']'.
			from
				i := m.count
			until
				i <= 0 or else m [i] = ']'
			loop
				c := m [i]
				if c.is_space or else c.is_punctuation or else not c.is_printable then
						-- Advance to the next character.
					i := i - 1
				else
						-- Stop iteration.
					i := 0
				end
			end
			from
				j := i
			until
				j <= 1 or else attached date_string
			loop
				j := j - 1
				if m [j] = '[' then
					date_string := m.substring (j + 1, i - 1)
				end
			end
			if attached date_string and then date_valid (date_string, date_code) then
					-- Remove date string from the message.
				from
					j := j - 1
				until
					j <= 1 or else not m [j].is_space
				loop
					j := j - 1
				end
				Result := [m.substring (1, j), create {DATE}.make_from_string (date_string, date_code), True]
			else
					-- Use default values.
				Result := [m, default_date, False]
			end
		end

	date_code: STRING = "yyyy-mm-dd"
			-- Expected string code.

	default_date: DATE
			-- Date to be used when none is specified explicitly.
		once
				-- A safe default corresponds to the release of the compiler with checks for obsolete messages.
			create Result.make (2017, 7, 1)
		end

note
	copyright:	"Copyright (c) 2017, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
