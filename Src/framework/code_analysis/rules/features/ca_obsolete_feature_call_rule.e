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

	DATE_VALIDITY_CHECKER

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (m: PREFERENCE_MANAGER)
			-- Initialize rule using preferences from `m`.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			make_with_defaults
			create l_factory
			feature_call_expiration := l_factory.new_integer_preference_value (m,
				preference_option_name_feature_call_expiration, default_feature_call_expiration)
			feature_call_expiration.set_default_value (default_feature_call_expiration.out)
			feature_call_expiration.set_validation_agent (agent is_integer_string_within_bounds (?, 1, {like {DATE_DURATION}.days_count}.max_value))
		end

	register_actions (c: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			c.add_class_pre_action (agent (a: CLASS_AS) do
				is_obsolete_class := attached a.obsolete_message
			end)
			c.add_class_post_action (agent (a: CLASS_AS) do
				is_obsolete_class := False
			end)
			c.add_feature_pre_action (agent (f: FEATURE_AS) do
				feature_names := f.feature_names
			end)
			c.add_feature_post_action (agent (f: FEATURE_AS) do
				feature_names := Void
			end)
			c.add_routine_pre_action (agent (r: ROUTINE_AS) do
				is_obsolete_feature := attached r.obsolete_message
			end)
			c.add_routine_post_action (agent (r: ROUTINE_AS) do
				is_obsolete_feature := False
			end)
			c.add_access_feat_pre_action (agent process_access)
			c.add_address_pre_action (agent process_address)
			c.add_binary_pre_action (agent process_binary)
			c.add_bracket_pre_action (agent process_bracket)
			c.add_parameter_list_pre_action (agent process_parameters)
			c.add_precursor_pre_action (agent process_precursor)
			c.add_routine_agent_pre_action (agent process_routine_agent)
			c.add_static_access_pre_action (agent process_static)
			c.add_unary_pre_action (agent process_unary)
			checker := c
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
		do
		end

feature {NONE} -- State

	is_obsolete_class: BOOLEAN
			-- Is current class obsolete?

	is_obsolete_feature: BOOLEAN
			-- Is current feature obsolete?

	feature_names: detachable ITERABLE [FEATURE_NAME]
			-- Names of features being checkedd or `Void` for invariant.

	checker: CA_ALL_RULES_CHECKER
			-- Code analysis iterator.

feature {NONE} -- Preferences

	preference_option_name_feature_call_expiration: STRING
			-- A name of a call expiration option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_feature_call_expiration)
		end

	option_name_feature_call_expiration: STRING = "call_expiration"
			-- A name of a call expiration option.

	default_feature_call_expiration: INTEGER = 366
			-- The default call expiration period necessary to trigger a rule violation.

	feature_call_expiration: INTEGER_PREFERENCE
			-- The call expiration necessary tol trigger a rule violation.

feature {NONE} -- Rule Checking

	process_access (a: ACCESS_FEAT_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a)
		end

	process_address (a: ADDRESS_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a.feature_name)
		end

	process_binary (a: BINARY_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a.operator (current_context.matchlist))
		end

	process_bracket (a: BRACKET_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a.lbracket_symbol)
		end

	process_parameters (a: PARAMETER_LIST_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a.lparan_symbol (current_context.matchlist))
		end

	process_precursor (a: PRECURSOR_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a)
		end

	process_routine_agent (a: AGENT_ROUTINE_CREATION_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a.feature_name)
		end

	process_static (a: STATIC_ACCESS_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a.feature_name)
		end

	process_unary (a: UNARY_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			process_call (a.routine_ids.first, a.class_id, a)
		end

	process_call (routine_id: like {ROUT_ID_SET}.first; class_id: like {CLASS_C}.class_id; call: AST_EIFFEL)
			-- Process a call to a feature of `routine_id` from class `class_id` at location `location`.
		local
			violation: CA_RULE_VIOLATION
			u: UTF_CONVERTER
			stamp: TUPLE [message: STRING; date: DATE]
			d: DATE
			expires_in: INTEGER
			obsolete_message: READABLE_STRING_32
			violation_severity: like severity
			m: like {FEATURE_I}.obsolete_message
			f: FEATURE_I
		do
				-- If an obsolete feature is called from an obsolete class or an obsolete feature,
				-- there is no reason to report it.
			if
				not is_obsolete_class and then
				not is_obsolete_feature and then
				class_id /= 0 and then
				attached system.class_of_id (class_id) as c and then
				c.has_feature_table and then
				routine_id > 0 and then
				attached c.feature_of_rout_id (routine_id) as original_feature
			then
				f := original_feature
				m := f.obsolete_message
					-- Check original feature call first.
				if not attached m and then checker.is_assigner_call then
						-- Original feature call is not obsolete, but the associated assigner may be.
					f := f.written_class.feature_of_name_id (f.assigner_name_id)
					if attached f then
						m := f.obsolete_message
					end
				end
				if attached f and attached m then
					stamp := date (m)
					obsolete_message := u.utf_8_string_8_to_string_32 (if attached stamp then stamp.message else m end)
					if attached stamp then
						d := stamp.date
					else
						d := default_date
					end
					expires_in := d.relative_duration (create {DATE}.make_now_utc).days_count
					if expires_in > 0 then
						violation_severity := severity_suggestion
					end
					expires_in := expires_in + feature_call_expiration.value
					if expires_in <= 0 then
						violation_severity := severity_error
					end
					create violation.make_formatted
						(agent message.format (?, ca_messages.obsolete_feature_call_title,
							<<
								message.element (agent (f.e_feature).append_name),
								message.element (agent add_single_line (obsolete_message, ?))
							>>),
						agent
							(callee: E_FEATURE;
							callee_class: CLASS_C;
							caller_names: detachable ITERABLE [FEATURE_NAME];
							caller_class: CLASS_C;
							callee_message: READABLE_STRING_32;
							days: INTEGER;
							has_date: BOOLEAN;
							t: TEXT_FORMATTER)
						local
							affected: ITERABLE [PROCEDURE [TEXT_FORMATTER]]
						do
							if attached caller_names then
								affected := create {ITERABLE_FUNCTION [PROCEDURE [TEXT_FORMATTER], FEATURE_NAME]}.make
									(agent (feature_name: FEATURE_NAME; caller: CLASS_C): PROCEDURE [TEXT_FORMATTER] do
										Result := agent {TEXT_FORMATTER}.add_feature_name (feature_name.visual_name_32, caller)
									end (?, caller_class), caller_names)
							else
								affected := create {ARRAY [PROCEDURE [TEXT_FORMATTER]]}.make_filled
									(agent {TEXT_FORMATTER}.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_invariant_keyword, Void), 1, 1)
							end
							message.format (t, ca_messages.obsolete_feature_call_violation,
							<<
								message.element (agent callee.append_name),
								message.element (agent callee_class.append_name),
								message.list (affected),
								message.element (agent caller_class.append_name),
								message.element (agent (formatter: TEXT_FORMATTER; msg: READABLE_STRING_32) do
									formatter.add_new_line
									if msg.has ({CHARACTER_32} '%N') then
										formatter.add_multiline_string (msg, 1)
									else
										formatter.add_indent
										formatter.add_string (msg)
									end
								end (?, callee_message))
							>>)
							if days > 0 then
								t.add_new_line
								message.format (t, ca_messages.obsolete_feature_call_expires_in (days),
								<<
									message.element (agent {TEXT_FORMATTER}.add_int (days))
								>>)
							end
							if not has_date then
								t.add_new_line
								t.add (ca_messages.obsolete_feature_invalid_date)
							end
						end (f.e_feature, c, feature_names, current_context.checking_class, u.utf_8_string_8_to_string_32 (m), expires_in, attached stamp, ?),
						Current)
					violation.set_location (call.first_token (current_context.matchlist))
					violation.long_description_info.extend (c.lace_class)
					violation.long_description_info.extend (f.e_feature)
					violation.long_description_info.extend (obsolete_message)
					violation.long_description_info.extend (stamp)
					violation.long_description_info.extend (expires_in)
					if attached violation_severity then
						violation.set_severity (violation_severity)
					end
					violations.extend (violation)
				end
			end
		end

	date (m: STRING): detachable TUPLE [message: STRING; date: DATE]
			-- Date specified in the message `m` if any.
			-- If a date is extracted, the message without date information is returned.
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
				Result := [m.substring (1, j), create {DATE}.make_from_string (date_string, date_code)]
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

feature {NONE} -- Formatting

	message: FORMATTED_MESSAGE
			-- A message formatter.
		once
			create Result
		end

	add_single_line (s: READABLE_STRING_32; t: TEXT_FORMATTER)
			-- Add a single line of `s` to `t`.
		local
			i: like {READABLE_STRING_32}.index_of
		do
			i := s.index_of ({CHARACTER_32} '%N', 1)
			if i > 0 then
				t.add_string (s.substring (1, i - 1))
				t.add ({STRING_32} "…")
			else
				t.add_string (s)
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
