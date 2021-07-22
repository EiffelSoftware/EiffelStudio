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
	CA_OBSOLETE_FEATURE_CALL_PROCESSOR [TUPLE [
			obsolete_feature: E_FEATURE;
			obsolete_class: CLASS_C;
			caller_names: detachable ITERABLE [FEATURE_NAME];
			caller_class: CLASS_C;
			location: LOCATION_AS]]
		redefine
			make
		end

	OBSOLETE_CALL_REPORTER [TUPLE [
			obsolete_feature: E_FEATURE;
			obsolete_class: CLASS_C;
			caller_names: detachable ITERABLE [FEATURE_NAME];
			caller_class: CLASS_C;
			location: LOCATION_AS]]

	CA_STANDARD_RULE
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (m: PREFERENCE_MANAGER)
			-- Initialize rule using preferences from `m`.
		do
			make_with_defaults
			Precursor (m)
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
			c.add_converted_expr_pre_action (agent process_converted_expr)
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

feature {NONE} -- Rule Checking

	process_access (a: ACCESS_FEAT_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			if not checker.is_assign and then a.is_feature then
				process_call (a.routine_ids.first, a.class_id, a)
			end
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

	process_converted_expr (a: CONVERTED_EXPR_AS)
			-- Check if `a` is an obsolete call and report violation accordingly.
		do
			if attached {PARENT_CONVERSION_INFO} a.data as i and then not i.is_null_conversion then
				process_call (i.routine_id, i.class_id, a)
			end
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
			-- Process a call to a feature of `routine_id` from class `class_id` at location `call`.
		local
			m: like {FEATURE_I}.obsolete_message
			f: FEATURE_I
		do
				-- If an obsolete feature is called from an obsolete class or an obsolete feature,
				-- there is no reason to report it.
			if
				not is_obsolete_class and then
				not is_obsolete_feature and then
				system.has_class_of_id (class_id) and then
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
					process (m, {CONF_OPTION}.warning_term_index_all, f.e_feature, c, feature_names, current_context.checking_class, call.first_token (current_context.matchlist), Current)
				end
			end
		end

feature {NONE} -- Formatting

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

feature {NONE} -- Reporting

	report_obsolete_call (obsolete_message: READABLE_STRING_32; clean_message: READABLE_STRING_32; expiration: INTEGER_32; issue_severity: NATURAL_32; context: like context_type)
			-- <Precursor>
		local
			violation: CA_RULE_VIOLATION
		do
			create violation.make_formatted
				(agent format_elements (?, ca_messages.obsolete_feature_call_title,
					<<
						agent (context.obsolete_feature).append_name,
						agent add_single_line (obsolete_message, ?)
					>>),
				agent
					(callee: E_FEATURE;
					callee_class: CLASS_C;
					caller_names: detachable ITERABLE [FEATURE_NAME];
					caller_class: CLASS_C;
					callee_message: READABLE_STRING_32;
					days: INTEGER;
					t: TEXT_FORMATTER)
				local
					affected: ITERABLE [PROCEDURE [TEXT_FORMATTER]]
				do
					if attached caller_names then
						affected := create {ITERABLE_MAP [FEATURE_NAME, PROCEDURE [TEXT_FORMATTER]]}.make
							(agent (feature_name: FEATURE_NAME; caller: CLASS_C): PROCEDURE [TEXT_FORMATTER] do
								Result := agent {TEXT_FORMATTER}.add_feature_name (feature_name.visual_name_32, caller)
							end (?, caller_class), caller_names)
					else
						affected :=
							<<agent {TEXT_FORMATTER}.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_invariant_keyword, Void)>>
					end
					format (t, ca_messages.obsolete_feature_call_violation,
					<<
						element (agent callee.append_name),
						element (agent callee_class.append_name),
						element_list (affected),
						element (agent caller_class.append_name),
						element (agent (formatter: TEXT_FORMATTER; msg: READABLE_STRING_32) do
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
						format_elements (t, ca_messages.obsolete_feature_call_expires_in (days),
							<<agent {TEXT_FORMATTER}.add_int (days)>>)
					end
				end (context.obsolete_feature, context.obsolete_class, feature_names, current_context.checking_class, clean_message, expiration, ?),
				Current)
			violation.set_location (context.location)
			inspect issue_severity
			when obsolete_call_error then
				violation.set_severity (severity_error)
			when obsolete_call_warning then
				violation.set_severity (severity_warning)
			when obsolete_call_hint then
				violation.set_severity (severity_hint)
			end
			violations.extend (violation)
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright:	"Copyright (c) 2017-2021, Eiffel Software"
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
