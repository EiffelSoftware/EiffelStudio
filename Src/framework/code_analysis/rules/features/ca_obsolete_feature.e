note
	description: "Obsolete code detection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_OBSOLETE_FEATURE

inherit
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

;note
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
