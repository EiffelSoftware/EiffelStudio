note
	description: "[
			RULE #70: Obsolete feature
	
			An obsolete feature sould be removed after awhile.
			
			The periods of error report are:

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_OBSOLETE_FEATURE_RULE

inherit
	CA_OBSOLETE_FEATURE
		redefine
			make
		end

	CA_STANDARD_RULE
	DATE_VALIDITY_CHECKER
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (m: PREFERENCE_MANAGER)
			-- <Precursor>
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			make_with_defaults
			create l_factory
			feature_expiration := l_factory.new_integer_preference_value (m,
				preference_option_name_feature_expiration, default_feature_expiration)
			feature_expiration.set_default_value (default_feature_expiration.out)
			feature_expiration.set_validation_agent (agent is_integer_string_within_bounds (?, 1, {like {DATE_DURATION}.days_count}.max_value))
			Precursor (m)
		end

	register_actions (c: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			c.add_feature_pre_action (agent (f: FEATURE_AS) do
				feature_names := f.feature_names
			end)
			c.add_feature_post_action (agent (f: FEATURE_AS) do
				feature_names := Void
			end)
			c.add_routine_pre_action (agent process_routine)
			checker := c
		end

feature -- Properties

	name: STRING = "obsolete_feature"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.obsolete_feature_title
		end

	id: STRING_32 = "CA070"
		-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.obsolete_feature_description
		end

	format_violation_description (violation: CA_RULE_VIOLATION; formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
		end

feature {NONE} -- State

	feature_names: detachable EIFFEL_LIST [FEATURE_NAME]
			-- Names of features being checkedd or `Void` for invariant.

	checker: CA_ALL_RULES_CHECKER
			-- Code analysis iterator.

feature {NONE} -- Preferences

	preference_option_name_feature_expiration: STRING
			-- A name of a call expiration option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_feature_expiration)
		end

	option_name_feature_expiration: STRING = "expiration"
			-- A name of a feature expiration option.

	default_feature_expiration: INTEGER = 183
			-- The default expiration period necessary to trigger a rule violation.

	feature_expiration: INTEGER_PREFERENCE
			-- The feature expiration necessary tol trigger a rule violation.

feature {NONE} -- Rule Checking

	process_routine (r: ROUTINE_AS)
			-- Process a routine `r`.
		local
			stamp: like {OBSOLETE_MESSAGE_PARSER}.date
			expires_in: INTEGER
		do
			if attached r.obsolete_message as m then
				stamp := {OBSOLETE_MESSAGE_PARSER}.date (m.value)
				expires_in := stamp.date.relative_duration (create {DATE}.make_now_utc).days_count
				if attached feature_names as names then
					if not stamp.is_specified then
						put_formattable_violation
							(ca_messages.obsolete_feature_invalid_date_title (names.count),
							<<element_list (create {ITERABLE_MAP [FEATURE_NAME, PROCEDURE [TEXT_FORMATTER]]}.make
								(agent (feature_name: FEATURE_NAME; feature_class: CLASS_C): PROCEDURE [TEXT_FORMATTER] do
									Result := agent {TEXT_FORMATTER}.add_feature_name (feature_name.visual_name_32, feature_class)
								end (?, current_context.checking_class), names))>>,
							ca_messages.obsolete_feature_invalid_date_violation,
							<<element (agent {TEXT_FORMATTER}.add ({OBSOLETE_MESSAGE_PARSER}.default_date_string))>>,
							Void,
							m.index)
					end
					expires_in := expires_in + feature_call_expiration.value
					if expires_in <= 0 then
						put_formattable_violation
							(ca_messages.obsolete_feature_title (names.count),
							<<element_list (create {ITERABLE_MAP [FEATURE_NAME, PROCEDURE [TEXT_FORMATTER]]}.make
								(agent (feature_name: FEATURE_NAME; feature_class: CLASS_C): PROCEDURE [TEXT_FORMATTER] do
									Result := agent {TEXT_FORMATTER}.add_feature_name (feature_name.visual_name_32, feature_class)
								end (?, current_context.checking_class), names))>>,
							ca_messages.obsolete_feature_violation,
							<<>>,
							if expires_in + feature_expiration.value <= 0 then severity_error else Void end,
							m.index)
					end
				end
			end
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
