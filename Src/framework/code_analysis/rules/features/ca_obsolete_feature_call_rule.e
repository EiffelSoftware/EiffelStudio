note
	description: "[
			RULE #69: Obsolete feature call
	
			An obsolete feature is called from a non-obsolete one.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_OBSOLETE_FEATURE_CALL_RULE

inherit
	CA_STANDARD_RULE
		rename
			make_with_defaults as make
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	register_actions (checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			checker.add_class_pre_action (agent (c: CLASS_AS) do
				is_obsolete_class := attached c.obsolete_message
			end)
			checker.add_routine_pre_action (agent (r: ROUTINE_AS) do
				is_obsolete_feature := attached r.obsolete_message
			end)
			checker.add_access_feat_pre_action (agent process_access)
		end

feature -- Properties

	name: STRING = "obsolete_feature_call"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.obsolete_feature_call_title
		end

	id: STRING_32 = "CA069"
		-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.obsolete_feature_call_description
		end

	format_violation_description (violation: CA_RULE_VIOLATION; formatter: TEXT_FORMATTER)
			-- <Precursor>
		local
			info: like {CA_RULE_VIOLATION}.long_description_info
		do
			info := violation.long_description_info
			if
				info.count >= 3 and then
				attached {CLASS_I} info [1] as c and then
				attached {E_FEATURE} info [2] as f and then
				attached {READABLE_STRING_GENERAL} info [3] as m
			then
				message.format (formatter, ca_messages.obsolete_feature_call_violation,
				<<
					message.element (agent f.append_name),
					message.element (agent c.append_name),
					message.element (agent (violation.affected_class.lace_class).append_name),
					message.element (agent {TEXT_FORMATTER}.add (m))
				>>)
			end
		end

feature {NONE} -- State

	is_obsolete_class: BOOLEAN
			-- Is current class obsolete?

	is_obsolete_feature: BOOLEAN
			-- Is current feature obsolete?

	current_feature: FEATURE_I
			-- Feature being checked.

feature {NONE} -- Rule Checking

	process_access (a: ACCESS_FEAT_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		local
			class_id: like {ACCESS_ID_AS}.class_id
			routine_id: like {ACCESS_ID_AS}.routine_ids.first
			violation: CA_RULE_VIOLATION
		do
				-- If an obsolete feature is called from an obsolete class or an obsolete feature,
				-- there is no reason to report it.
			if not is_obsolete_class and then not is_obsolete_feature then
				class_id := a.class_id
				routine_id := a.routine_ids.first
				if
					class_id /= 0 and then
					attached system.class_of_id (a.class_id) as c and then
					c.has_feature_table and then
					routine_id > 0 and then
					attached c.feature_of_rout_id (routine_id) as f and then
					attached f.obsolete_message as m
				then
					create violation.make_with_rule (Current)
					violation.set_location (a.start_location)
					violation.long_description_info.extend (c.lace_class)
					violation.long_description_info.extend (f.e_feature)
					violation.long_description_info.extend (m)
					violations.extend (violation)
				end
			end
		end

feature {NONE} -- Formatting

	message: FORMATTED_MESSAGE
			-- A message formatter.
		once
			create Result
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
