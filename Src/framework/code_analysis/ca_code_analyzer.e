note
	description: "The Code Analyzer."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CODE_ANALYZER

inherit
	SHARED_EIFFEL_PROJECT

	CA_SHARED_NAMES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create classes_to_analyze.make
			create rule_violations.make (100)
			create start_actions
			create completed_actions
			create output_actions

			create ignoredby.make (25)
			create checked_only_by.make (25)
			create library_class.make (25)
			create nonlibrary_class.make (25)

			create settings.make
			create rules.make_caseless (100) -- Rule IDs should be case insensitive.

				-- Adding the rules.
				-- CA066: argument_name
			add_rule (create {CA_ARGUMENT_NAMING_CONVENTION_RULE}.make (settings.preference_manager))
				-- CA048: fixed_attribute_value
			add_rule (create {CA_ATTRIBUTE_CAN_BE_CONSTANT_RULE}.make)
				-- CA054: attribute_in_single_feature
			add_rule (create {CA_ATTRIBUTE_TO_LOCAL_RULE}.make)
				-- CA042: comparison_to_boolean_constant
			add_rule (create {CA_BOOLEAN_COMPARISON_RULE}.make)
				-- CA041: conditional_computes_only_boolean
			add_rule (create {CA_BOOLEAN_RESULT_RULE}.make)
				-- CA063: class_name
			add_rule (create {CA_CLASS_NAMING_CONVENTION_RULE}.make)
				-- CA073: comment_style
			add_rule (create {CA_COMMENT_NOT_WELL_PHRASED_RULE}.make)
				-- CA049: reference_comparison
			add_rule (create {CA_COMPARISON_OF_OBJECT_REFS_RULE}.make)
				-- CA052: zero_count_test
			add_rule (create {CA_COUNT_EQUALS_ZERO_RULE}.make) -- Needs type info.
				-- CA004: possible_side_effect
			add_rule (create {CA_CQ_SEPARATION_RULE}.make)
				-- CA013: exported_creation_procedure
			add_rule (create {CA_CREATION_PROC_EXPORTED_RULE}.make)
				-- CA043: deeply_nested_conditionals
			add_rule (create {CA_DEEPLY_NESTED_IF_RULE}.make (settings.preference_manager))
				-- CA015: double_negation
			add_rule (create {CA_DOUBLE_NEGATION_RULE}.make)
				-- CA038: empty_creation_procedure
			add_rule (create {CA_EMPTY_CREATION_PROC_RULE}.make)
				-- CA053: empty_feature_in_deferred
			add_rule (create {CA_EMPTY_EFFECTIVE_ROUTINE_RULE}.make)
				-- CA017: empty_conditional
			add_rule (create {CA_EMPTY_IF_RULE}.make)
				-- CA016: empty_loop
			add_rule (create {CA_EMPTY_LOOP_RULE}.make)
				-- CA059: empty_rescue
			add_rule (create {CA_EMPTY_RESCUE_CLAUSE_RULE}.make)
				-- CA051: empty_feature
			add_rule (create {CA_EMPTY_UNCOMMENTED_ROUTINE_RULE}.make)
				-- CA089: duplicated_parent
			add_rule (create {CA_EXPLICIT_REDUNDANT_INHERITANCE_RULE}.make)
				-- CA075: unused_export
			add_rule (create {CA_EXPORT_CAN_BE_RESTRICTED_RULE}.make)
				-- CA064: feature_name
			add_rule (create {CA_FEATURE_NAMING_CONVENTION_RULE}.make)
				-- CA003: unused_feature
			add_rule (create {CA_FEATURE_NEVER_CALLED_RULE}.make)
				-- CA036: missing_feature_comment
			add_rule (create {CA_FEATURE_NOT_COMMENTED_RULE}.make)
				-- CA035: missing_feature_clause_comment
			add_rule (create {CA_FEATURE_SECTION_COMMENT_RULE}.make)
				-- CA067: long_formal_generic_name
			add_rule (create {CA_GENERIC_PARAMETER_TOO_LONG_RULE}.make_with_defaults)
				-- CA046: inequality_in_conditional
			add_rule (create {CA_IF_ELSE_NOT_EQUAL_RULE}.make)
				-- CA031: inheritance_from_any
			add_rule (create {CA_INHERIT_FROM_ANY_RULE}.make)
				-- CA044: long_multi_branch
			add_rule (create {CA_INSPECT_INSTRUCTIONS_RULE}.make (settings.preference_manager))
				-- CA060: no_when_part
			add_rule (create {CA_INSPECT_NO_WHEN_RULE}.make)
				-- CA024: general_loop_on_iterable
			add_rule (create {CA_ITERABLE_LOOP_RULE}.make) -- Needs type info.
				-- CA065: local_name
			add_rule (create {CA_LOCAL_NAMING_CONVENTION_RULE}.make (settings.preference_manager))
				-- CA050: local_used_as_result
			add_rule (create {CA_LOCAL_USED_FOR_RESULT_RULE}.make)
				-- CA021: invariant_in_loop
			add_rule (create {CA_LOOP_INVARIANT_COMPUTATION_RULE}.make)
				-- CA093: manifest_array_type_mismatch
			add_rule (create {CA_MANIFEST_ARRAY_TYPE_RULE}.make)
				-- CA011: many_arguments
			add_rule (create {CA_MANY_ARGUMENTS_RULE}.make (settings.preference_manager))
				-- CA087: mergeable_conditionals
			add_rule (create {CA_MERGEABLE_CONDITIONALS_RULE}.make)
				-- CA088: duplicate_feature_clause
			add_rule (create {CA_MERGEABLE_FEATURE_CLAUSES_RULE}.make)
				-- CA012: no_default_creation_procedure
			add_rule (create {CA_MISSING_CREATION_PROC_WITHOUT_ARGS_RULE}.make)
				-- CA082: inconsistent_hash_code_redeclaration
			add_rule (create {CA_MISSING_IS_EQUAL_RULE}.make)
				-- CA010: nested_complexity
			add_rule (create {CA_NESTED_COMPLEXITY_RULE}.make (settings.preference_manager))
				-- CA034: npath_complexity
			add_rule (create {CA_NPATH_RULE}.make (settings.preference_manager))
				-- CA068: creation_in_loop
			add_rule (create {CA_OBJECT_CREATION_WITHIN_LOOP_RULE}.make)
				-- CA029: unnecessary_voidness_test
			add_rule (create {CA_OBJECT_TEST_ALWAYS_SUCCEEDS_RULE}.make)
				-- CA007: nonconforming_object_test
			add_rule (create {CA_OBJECT_TEST_FAILING_RULE}.make_with_defaults)
				-- CA069: obsolete_feature_call
			add_rule (create {CA_OBSOLETE_FEATURE_CALL_RULE}.make (settings.preference_manager))
				-- CA070: obsolete_feature
			add_rule (create {CA_OBSOLETE_FEATURE_RULE}.make (settings.preference_manager))
				-- CA045: nan_comparison
			add_rule (create {CA_REAL_NAN_COMPARISON_RULE}.make)
				-- CA001: self_assignment
			add_rule (create {CA_SELF_ASSIGNMENT_RULE}.make)
				-- CA071: self_comparison
			add_rule (create {CA_SELF_COMPARISON_RULE}.make)
				-- CA025: missing_argument_semicolon
			add_rule (create {CA_SEMICOLON_ARGUMENTS_RULE}.make)
				-- CA028: combinable_nested_conditionals
			add_rule (create {CA_SHORT_CIRCUIT_IF_RULE}.make)
				-- CA057: negated_comparison
			add_rule (create {CA_SIMPLIFIABLE_BOOLEAN_RULE}.make)
				-- CA080: todo_comment
			add_rule (create {CA_TODO_RULE}.make)
				-- CA037: comment_content
			add_rule (create {CA_UNDESIRABLE_COMMENT_CONTENT_RULE}.make (settings.preference_manager))
				-- CA030: unnecessary_sign
			add_rule (create {CA_UNNECESSARY_SIGN_OPERATOR_RULE}.make)
				-- CA079: unnecessary_accessor
			add_rule (create {CA_UNNEEDED_ACCESSOR_FUNCTION_RULE}.make)
				-- CA085: single_use_variable
			add_rule (create {CA_UNNEEDED_HELPER_VARIABLE_RULE}.make (settings.preference_manager))
				-- CA006: redundant_object_test
			add_rule (create {CA_UNNEEDED_OBJECT_TEST_RULE}.make) -- Needs type info.
				-- CA005: redundant_object_test_local
			add_rule (create {CA_UNNEEDED_OT_LOCAL_RULE}.make)
				-- CA023: redundant_parentheses
			add_rule (create {CA_UNNEEDED_PARENTHESES_RULE}.make)
				-- CA022: unreachable_code
			add_rule (create {CA_UNREACHABLE_CODE_RULE}.make)
				-- CA002: unused_argument
			add_rule (create {CA_UNUSED_ARGUMENT_RULE}.make)
				-- CA009: useless_attachment_check
			add_rule (create {CA_USELESS_CONTRACT_RULE}.make)
				-- CA020: unread_variable
			add_rule (create {CA_VARIABLE_NOT_READ_RULE}.make)
				-- CA033: long_class
			add_rule (create {CA_VERY_BIG_CLASS_RULE}.make (settings.preference_manager))
				-- CA062: long_identifier
			add_rule (create {CA_VERY_LONG_IDENTIFIER_RULE}.make (settings.preference_manager))
				-- CA032: long_feature
			add_rule (create {CA_VERY_LONG_ROUTINE_RULE}.make (settings.preference_manager))
				-- CA061: short_identifier
			add_rule (create {CA_VERY_SHORT_IDENTIFIER_RULE}.make (settings.preference_manager))
				-- CA047: equal_in_void_test
			add_rule (create {CA_VOID_CHECK_USING_IS_EQUAL_RULE}.make)
				-- CA092: suspicious_interation_scheme
			add_rule (create {CA_WRONG_LOOP_ITERATION_RULE}.make)

			settings.initialize_rule_settings (rules)
		end

feature -- Initialization

	install_obsolete_call_processor
			-- Register an obsolete call processor of the code analyzer as the one to be used by the compiler.
		do
			(create {OBSOLETE_CALL_HANDLER}).install
				(agent (create {CA_OBSOLETE_FEATURE_CALL_PROCESSOR [like {OBSOLETE_CALL_HANDLER}.context_type]}.make
					(settings.preference_manager)).process)
		end

feature -- Analysis interface

	add_start_action (a_action: PROCEDURE)
			-- Adds `a_action' to the list of procedures that will be
			-- called when analysis has started.
		do
			start_actions.extend (a_action)
		end

	add_completed_action (a_action: PROCEDURE [ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]]])
			-- Adds `a_action' to the list of procedures that will be
			-- called when analysis has completed.
		do
			completed_actions.extend (a_action)
		end

	add_output_action (a_action: PROCEDURE [READABLE_STRING_GENERAL])
			-- Adds `a_action' to the procedures that are called for outputting status. The final results
			-- (rule violations) are not given to these procedures.
		do
			output_actions.extend (a_action)
		end

	analyze
			-- Analyze all the classes that have been added.
		require
			not is_running
		local
			l_rules_checker: CA_ALL_RULES_CHECKER
			l_task: CA_RULE_CHECKING_TASK
			l_rules_to_check: LINKED_LIST [CA_RULE]
		do
			is_running := True

			start_actions.call

			create l_rules_checker.make
			create l_rules_to_check.make
			across rules as l_rules loop
				l_rules.clear_violations
				if is_rule_checkable (l_rules) then
					l_rules_to_check.extend (l_rules)
						-- Here we only prepare standard rules. The rule checking task will iterate again
						-- through the rules and run the analysis on the enabled rules.
					if attached {CA_STANDARD_RULE} l_rules as l_std_rule then
						l_std_rule.prepare_checking (l_rules_checker)
					end
				end
			end

			create l_task.make (l_rules_checker, l_rules_to_check, classes_to_analyze, agent analysis_completed)
			l_task.set_output_actions (output_actions)
			if attached rota as r then
				r.run_task (l_task)
			else
					-- No ROTA task is available, we execute the task synchronously.
				from

				until
					not l_task.has_next_step
				loop
					l_task.step
				end
			end
		end

	clear_classes_to_analyze
			-- Removes all classes that have been added to the list of classes
			-- to analyze.
		do
			classes_to_analyze.wipe_out
			ignoredby.wipe_out
			checked_only_by.wipe_out
		end

	add_whole_system
			-- Adds all the classes that are part of the current system. Classes of referenced libraries
			-- will not be added.
		do
			across
				eiffel_universe.groups as l_groups
			loop
					-- Only load top-level clusters, as the others will be loaded recursively afterwards.
				if attached {CLUSTER_I} l_groups as l_cluster and then l_cluster.parent_cluster = Void then
					add_cluster (l_cluster)
				end
			end

			system_wide_check := True
		end

	add_cluster (a_cluster: attached CLUSTER_I)
			-- Add all classes of cluster `a_cluster'.
		do
			system_wide_check := False

			if a_cluster.classes /= Void then
				across a_cluster.classes as ic loop
					add_class (ic)
				end
			end

			if a_cluster.sub_clusters /= Void then
				across a_cluster.sub_clusters as ic loop
					add_cluster (ic)
				end
			end
		end

	add_group (a_group: attached CONF_GROUP)
			-- Add all classes of the configuration group `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			if a_group.classes /= Void then
				across a_group.classes as ic loop
					add_class (ic)
				end
			end
		end

	add_classes (a_classes: attached ITERABLE [attached CONF_CLASS])
			-- Add the classes `a_classes'.
		do
			system_wide_check := False

			across a_classes as l_classes loop
				add_class (l_classes)
			end
		end

	add_class (a_class: attached CONF_CLASS)
			-- Adds class `a_class'.
		do
			system_wide_check := False

			if attached {EIFFEL_CLASS_I} a_class as l_eiffel_class
				and then attached l_eiffel_class.compiled_class as l_compiled
			then
				classes_to_analyze.extend (l_compiled)

				extract_indexes (l_compiled)
			else
				output_actions.call ([ca_messages.class_skipped (a_class.name)])
			end
		end

	force_preferences (a_preferences: LIST [TUPLE [rule_id: READABLE_STRING_GENERAL; preference_name: STRING; preference_value: READABLE_STRING_GENERAL]])
			-- Forcefully set the preferences in `a_preferences' to the specified values,
			-- overwriting the current ones.
		local
			l_full_preference_name: STRING
			l_preference: PREFERENCE
		do
				-- Disable all rules.
			across rules as ic loop
				ic.is_enabled.set_value (False)
			end

			across a_preferences as ic loop
				if rules.has_key (ic.rule_id) then
					l_full_preference_name := rules.found_item.full_preference_name (ic.preference_name)
					l_preference := preferences.get_preference (l_full_preference_name)

					if attached l_preference then
						l_preference.set_value_from_string (ic.preference_value)
					else
						output_actions.call ([ca_messages.preference_not_found (l_full_preference_name)])
					end

				else
					output_actions.call ([ca_messages.rule_not_found (ic.rule_id)])
				end
			end
		end

feature {NONE} -- Status report

	is_rule_checkable (a_rule: CA_RULE): BOOLEAN
			-- Will `a_rule' be checked based on the current preferences and based on the current
			-- checking scope?
		do
			Result := a_rule.is_enabled.value
						and then (system_wide_check or else (not a_rule.is_system_wide))
						and then is_severity_enabled (a_rule.severity)
				-- TODO Check if ignoredby or checkonly lists.
		end

feature -- Properties

	is_running: BOOLEAN
			-- Is code analysis running?

	rule_violations: HASH_TABLE [SORTED_TWO_WAY_LIST [CA_RULE_VIOLATION], CLASS_C]
			-- All found violations from the last analysis.

	preferences: PREFERENCES
			-- Code Analysis preferences.
		do Result := settings.preferences end

	class_list: ITERABLE [CLASS_C]
			-- List of classes that have been added.
		do Result := classes_to_analyze end

feature {NONE} -- Access

	rules: STRING_TABLE [CA_RULE]
		-- Table containing the rules that will be used for analysis. Rules are indexed by ID.

	settings: CA_SETTINGS
			-- The settings manager for Code Analysis.

feature {NONE} -- Modification

	add_rule (a_rule: CA_RULE)
			-- Adds `a_rule' to the rules list.
		require
			not_added_yet: not rules.has (a_rule.id)
		do
			rules.extend (a_rule, a_rule.id)
		ensure
			added: rules.has (a_rule.id)
		end

feature {NONE} -- Implementation

	csv_file_name: STRING = "last_analysis_result.csv"
			-- CSV file name used to store results of the analysis.

	analysis_completed (a_exceptions: detachable ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- Will be called when the analysis task has finished. `a_exceptions'
			-- contains a list of exception that occurred during analysis.
		local
			l_csv_writer: CA_CSV_WRITER
		do
			create l_csv_writer.make (eiffel_project.project_location.target_path.extended (csv_file_name))
				-- Write the header.
			l_csv_writer.put_strings (<<
				{STRING_32} "Severity",
				{STRING_32} "Class",
				{STRING_32} "Line",
				{STRING_32} "Column",
				{STRING_32} "Title",
				{STRING_32} "Description",
				{STRING_32} "Rule ID",
				{STRING_32} "Severity Score"
			>>)
			l_csv_writer.put_new_line

			across rules as l_rules loop
				across l_rules.violations as l_v loop
						-- Check the ignore list.
					if is_violation_valid (l_v) then
							-- Make sure a list for this class exists in the hash table:
						rule_violations.put (create {SORTED_TWO_WAY_LIST [CA_RULE_VIOLATION]}.make, l_v.affected_class)
							-- Add the violation.
						rule_violations.at (l_v.affected_class).extend (l_v)
							-- Log it.
						l_v.add_csv_line (l_csv_writer)
					end
				end
			end

			l_csv_writer.close_file

			clear_classes_to_analyze

			is_running := False
			completed_actions.call (a_exceptions)
			completed_actions.wipe_out
		end

	is_violation_valid (a_viol: CA_RULE_VIOLATION): BOOLEAN
			-- Is the violation `a_viol' valid under the current settings
			-- such as the rule ignore list of a class, or the library or
			-- non-library status of a class?
		local
			l_affected_class: CLASS_C
			l_rule: CA_RULE
		do
			Result := True
			if not a_viol.severity.is_critical then
				l_affected_class := a_viol.affected_class
				l_rule := a_viol.rule
				if checked_only_by [l_affected_class].is_empty then
					if ignoredby [l_affected_class].has (l_rule.id) then
						Result := False
					end
				elseif  not checked_only_by [l_affected_class].has (l_rule.id) then
					Result := False
				end
				if not l_rule.checks_library_classes and then library_class [l_affected_class] then
					Result := False
				end
				if not l_rule.checks_nonlibrary_classes and then nonlibrary_class [l_affected_class] then
					Result := False
				end
			end
		end

	classes_to_analyze: LINKED_SET [CLASS_C]
			-- List of classes that shall be analyzed.

	system_wide_check: BOOLEAN
			-- Shall the whole system be analyzed?

	start_actions: ACTION_SEQUENCE
			-- List of procedures to call when analysis has started.

	completed_actions: ACTION_SEQUENCE [TUPLE [ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]]]]
			-- List of procedures to call when analysis has completed.

	frozen rota: detachable ROTA_S
			-- Accesses the rota service.
		local
			l_service_consumer: SERVICE_CONSUMER [ROTA_S]
		do
			create l_service_consumer
			if attached l_service_consumer.service as l_service and then l_service.is_interface_usable then
				Result := l_service
			end
		end

	is_severity_enabled (a_severity: CA_RULE_SEVERITY): BOOLEAN
			-- Is severity `a_severity` enabled?
		do
			Result := (attached {CA_HINT} a_severity and settings.is_hint_enabled.value)
				or else (attached {CA_WARNING} a_severity and settings.is_warning_enabled.value)
				or else (attached {CA_ERROR} a_severity and settings.is_error_enabled.value)
		end

	output_actions: ACTION_SEQUENCE [TUPLE [READABLE_STRING_GENERAL]]
			-- Will be called whenever there is a message to output.

feature {NONE} -- Class-wide Options (From Indexing Clauses)

	extract_indexes (a_class: CLASS_C)
			-- Extracts options from the indexing clause of class `a_class'.
		local
			l_ast: CLASS_AS
			l_ignoredby, l_check_only: LINKED_LIST [STRING_32]
		do
			create l_ignoredby.make
			create l_check_only.make
				-- We want to compare the actual strings.
			l_ignoredby.compare_objects
			l_check_only.compare_objects
				-- Reset the class flags.
			library_class.force (False, a_class)
			nonlibrary_class.force (False, a_class)
			l_ast := a_class.ast

			if attached l_ast.internal_top_indexes as l_top then
				search_indexing_tags (l_top, a_class, l_ignoredby, l_check_only)
			end
			if attached l_ast.internal_bottom_indexes as l_bottom then
				search_indexing_tags (l_bottom, a_class, l_ignoredby, l_check_only)
			end

			ignoredby.force (l_ignoredby, a_class)
			checked_only_by.force (l_check_only, a_class)
		end

	search_indexing_tags (a_clause: attached INDEXING_CLAUSE_AS; a_class: attached CLASS_C; a_ignoredby, a_check_only: attached LINKED_LIST [STRING_32])
			-- Searches `a_clause' for settings relevant to code analysis.
		local
			l_item: STRING_32
		do
			across a_clause as ic loop
				if attached ic.tag as l_tag then
					if l_tag.name_32.same_string_general ("ca_ignore") then
							-- Class wants to ignore certain rules.
						across ic.index_list as l_list loop
							l_item := l_list.string_value_32
							l_item.prune_all ('"')
							l_item.to_upper
							a_ignoredby.extend (l_item)
						end
					elseif l_tag.name_32.is_equal ("ca_only") then
							-- Class wants to check only certain rules.
						across ic.index_list as l_list loop
							l_item := l_list.string_value_32
							l_item.prune_all ('"')
							l_item.to_upper
							a_check_only.extend (l_item)
						end
					elseif l_tag.name_32.is_equal ("ca_library") then
							-- Class has information on whether it is a library class.
						if not ic.index_list.is_empty then
							l_item := ic.index_list.first.string_value_32
							l_item.to_lower
							l_item.prune_all ('"')
							if l_item.is_equal ("true") then
								library_class.force (True, a_class)
							elseif l_item.is_equal ("false") then
								nonlibrary_class.force (True, a_class)
							end
						end
					end
				end
			end
		end

	ignoredby: HASH_TABLE [LINKED_LIST [STRING_32], CLASS_C]
			-- Maps classes to lists of rules (rule IDs) the class wants to be ignored by.

	checked_only_by: HASH_TABLE [LINKED_LIST [STRING_32], CLASS_C]
			-- Maps classes to lists of rules (rule IDs) the class wants to be checked by exclusively.


	library_class, nonlibrary_class: HASH_TABLE [BOOLEAN, CLASS_C]
			-- Stores classes that are marked as library or non-library classes.

invariant
	--	law_of_non_contradiction: one class must not be both a library_class and a nonlibrary_class

note
	copyright:	"Copyright (c) 2014-2023, Eiffel Software"
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
