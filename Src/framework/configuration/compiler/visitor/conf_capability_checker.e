note
	description: "Checker for capability options violations."
	instruction: "[
			The following violations are detected:
			1. Class void safety level is less than the level of its cluster.
			2. Class cat-call detection level is less than the level of its cluster.
			3. Target capability option is greater than capability option of
				a) a target (if any) it extends (reported as warning because 5 will catch actual issues)
				b) any group it depends on
			4. Target root option is greater than target capability option.
			5. Target root option is greater than any dependent target capability option.
		]"

class CONF_CAPABILITY_CHECKER

inherit
	CONF_ACCESS
	CONF_INTERFACE_CONSTANTS
	CONF_ITERATOR
		redefine
			process_assembly,
			process_cluster,
			process_library,
			process_override,
			process_precompile,
			process_target
		end

create
	make

feature {NONE} -- Creation

	make (t: CONF_TARGET; report_indirect_errors: BOOLEAN; o: CONF_ERROR_OBSERVER)
			-- Check target `t` for validity rules violations and
			-- report errors (if any) to observer `o`.
			-- Force settings on suppliers if `f` is True.
		local
			root_options: CONF_TARGET_OPTION
		do
			observer := o
			are_indirect_errors_reported := report_indirect_errors
			root_target := t
			root_options := root_target.options
			root_catcall_detection_index := root_options.catcall_safety_capability.root_index
			root_concurrency_index := root_options.concurrency_capability.root_index
			root_void_safety_index := root_options.void_safety_capability.root_index
			target := t
			create targets.make_map (1)
			condition := Void
			report_error := agent o.report_error
			process_target (t)
		end

feature {NONE} -- Access

	observer: CONF_ERROR_OBSERVER
			-- Observer to report detected errors.

feature {CONF_VISITABLE} -- Visitor

	process_target (t: CONF_TARGET)
			-- <Precursor>
		local
			old_target: CONF_TARGET
			old_condition: CONF_CONDITION_LIST
		do
				-- Check usage of a parent target or of a library target in the current target.
			if t /= root_target and then not is_precompile then
				check_target (t, target)
			end
			if not targets.has (t) then
					-- Perform checks in the context of supplied target.
				targets.force (t)
				old_target := target
				target := t
				if attached t.extends as parent then
						-- Recurse to parent.
						-- Unless a precompile is checked.
					old_condition := condition
					condition := Void
					process_target (parent)
					condition := old_condition
				end
				if not is_precompile then
						-- Check rule 4.
					if not t.options.catcall_safety_capability.is_custom_root_valid then
						observer.report_error (create {CONF_ERROR_ROOT_OPTION}.make
							(t,
							conf_interface_names.option_catcall_detection_value [t.options.catcall_safety_capability.custom_root_index],
							conf_interface_names.option_catcall_detection_value [t.options.catcall_safety_capability.value.index],
							conf_interface_names.option_catcall_detection_name))
					end
					if not t.options.concurrency_capability.is_custom_root_valid then
						observer.report_error (create {CONF_ERROR_ROOT_OPTION}.make
							(t,
							conf_interface_names.option_concurrency_value [t.options.concurrency_capability.custom_root_index],
							conf_interface_names.option_concurrency_value [t.options.concurrency_capability.value.index],
							conf_interface_names.option_concurrency_name))
					end
					if not t.options.void_safety_capability.is_custom_root_valid then
						observer.report_error (create {CONF_ERROR_ROOT_OPTION}.make
							(t,
							conf_interface_names.option_void_safety_value [t.options.void_safety_capability.custom_root_index],
							conf_interface_names.option_void_safety_value [t.options.void_safety_capability.value.index],
							conf_interface_names.option_void_safety_name))
					end
				end
					-- Check groups and recurse to libraries.
				Precursor (t)
				target := old_target
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			old_condition: like condition
			old_report_error: like report_error
			old_is_precompile: BOOLEAN
		do
			if not is_precompile then
					-- Check usage of the library in the current target.
				check_group (a_library, target)
			end
				-- Check library recursively.
			if attached a_library.library_target as t then
				old_condition := condition
				condition := a_library.internal_conditions
				old_is_precompile := is_precompile
				if not old_is_precompile then
					is_precompile := attached {CONF_PRECOMPILE} a_library
				end
				old_report_error := report_error
				if not are_indirect_errors_reported then
						-- Report warnings instead of errors.
					report_error := agent observer.report_warning
				end
				process_target (t)
				report_error := old_report_error
				is_precompile := old_is_precompile
				condition := old_condition
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- <Precursor>
		do
			process_library (a_precompile)
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- <Precursor>
		do
			if not is_precompile then
					-- Check usage of the assembly in the current target.
	 			check_group (an_assembly, target)
	 		end
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- <Precursor>
		do
			if not is_precompile then
					-- Check usage of the cluster in the current target.
				check_group (a_cluster, target)
					-- Check cluster.
				check_cluster (a_cluster, target)
			end
		end

	process_override (an_override: CONF_OVERRIDE)
			-- <Precursor>
		do
			if not is_precompile then
				process_cluster (an_override)
			end
		end

feature {NONE} -- Traversal

	root_target: CONF_TARGET
			-- A target for which all the checks are performed.

	root_catcall_detection_index: like {CONF_TARGET_OPTION}.catcall_detection_index_none
			-- Catcall setting specified for `root_target'.

	root_concurrency_index: like {CONF_TARGET_OPTION}.concurrency_index_none
			-- Concurrency setting specified for `root_target'.

	root_void_safety_index: like {CONF_TARGET_OPTION}.void_safety_index_none
			-- Void safety setting specified for `root_target'.

	target: CONF_TARGET
			-- A target being processed.

	targets: SEARCH_TABLE [CONF_TARGET]
			-- Already processed targets.

	condition: detachable CONF_CONDITION_LIST
			-- Condition associated with the current target `target` (if any).

	is_precompile: BOOLEAN
			-- Does current target belong to a precompile?

	report_error: PROCEDURE [CONF_ERROR]
			-- An agent to be used for reporting errors.
			-- The actual behavior may be reporting errors or warnings.

	are_indirect_errors_reported: BOOLEAN
			-- Should issues in indirect ECFs be reported as errors?
			-- If not, they are reported as warnings.

	check_cluster (cluster: CONF_CLUSTER; t: CONF_TARGET)
			-- Check that options of classes in `cluster' satisfy validity rules against target `t' and report errors using `o' if not.
		do
			if attached cluster.internal_class_options as os then
				across
					os as option
				loop
						-- Check rule 1.
					if option.void_safety.index < cluster.options.void_safety.index then
						observer.report_error (create {CONF_ERROR_CLASS_CAPABILITY}.make
							(@ option.key,
							cluster,
							conf_interface_names.option_void_safety_value [option.void_safety.index],
							conf_interface_names.option_void_safety_value [cluster.options.void_safety.index],
							conf_interface_names.option_void_safety_name))
					end
						-- Check rule 2.
					if option.catcall_detection.index < cluster.options.catcall_detection.index then
						observer.report_error (create {CONF_ERROR_CLASS_CAPABILITY}.make
							(@ option.key,
							cluster,
							conf_interface_names.option_catcall_detection_value [option.catcall_detection.index],
							conf_interface_names.option_catcall_detection_value [cluster.options.catcall_detection.index],
							conf_interface_names.option_catcall_detection_name))
					end
				end
			end
		end

	check_group (group: CONF_GROUP; t: CONF_TARGET)
			-- Check that options of group `group' satisfy validity rules against target `t' and report errors using `o' if not.
		do
			if attached group.internal_options as option then
					-- Check rule 3b: it applies only to CAT-call detection and void safety.
				if option.catcall_detection.index < t.options.catcall_detection.index then
					observer.report_error (create {CONF_ERROR_GROUP_CAPABILITY}.make
						(group,
						t,
						conf_interface_names.option_catcall_detection_value [option.catcall_detection.index],
						conf_interface_names.option_catcall_detection_value [t.options.catcall_detection.index],
						conf_interface_names.option_catcall_detection_name))
				end
				if option.void_safety.index < t.options.void_safety.index then
					observer.report_error (create {CONF_ERROR_GROUP_CAPABILITY}.make
						(group,
						t,
						conf_interface_names.option_void_safety_value [option.void_safety.index],
						conf_interface_names.option_void_safety_value [t.options.void_safety.index],
						conf_interface_names.option_void_safety_name))
				end
			end
		end

	check_target (parent: CONF_TARGET; t: CONF_TARGET)
			-- Check that options of target `parent' satisfy validity rules against target `t' and report errors using `o' if not.
		do
			if attached parent.internal_options as option then
					-- Check rule 3a.
				if option.catcall_detection.index < t.options.catcall_detection.index then
					observer.report_warning (create {CONF_ERROR_TARGET_CAPABILITY}.make
						(parent,
						t,
						conf_interface_names.option_catcall_detection_value [option.catcall_detection.index],
						conf_interface_names.option_catcall_detection_value [t.options.catcall_detection.index],
						conf_interface_names.option_catcall_detection_name))
				end
				if option.concurrency.index < restricted_concurrency (t.options.concurrency.index) then
					observer.report_warning (create {CONF_ERROR_TARGET_CAPABILITY}.make
						(parent,
						t,
						conf_interface_names.option_concurrency_value [option.concurrency.index],
						conf_interface_names.option_concurrency_value [t.options.concurrency.index],
						conf_interface_names.option_concurrency_name))
				end
				if option.void_safety.index < restricted_void_safety (t.options.void_safety.index) then
					observer.report_warning (create {CONF_ERROR_TARGET_CAPABILITY}.make
						(parent,
						t,
						conf_interface_names.option_void_safety_value [option.void_safety.index],
						conf_interface_names.option_void_safety_value [t.options.void_safety.index],
						conf_interface_names.option_void_safety_name))
				end
					-- Check rule 5.
				if not option.catcall_safety_capability.is_capable (root_catcall_detection_index) then
					observer.report_error (create {CONF_ERROR_ROOT_CAPABILITY}.make
						(parent,
						root_target,
						conf_interface_names.option_catcall_detection_value [option.catcall_safety_capability.value.index],
						conf_interface_names.option_catcall_detection_value [root_catcall_detection_index],
						conf_interface_names.option_catcall_detection_name))
				end
				if not option.concurrency_capability.is_capable (root_concurrency_index) then
					observer.report_error (create {CONF_ERROR_ROOT_CAPABILITY}.make
						(parent,
						root_target,
						conf_interface_names.option_concurrency_value [option.concurrency_capability.value.index],
						conf_interface_names.option_concurrency_value [root_concurrency_index],
						conf_interface_names.option_concurrency_name))
				end
				if not option.void_safety_capability.is_capable (root_void_safety_index) then
					observer.report_error (create {CONF_ERROR_ROOT_CAPABILITY}.make
						(parent,
						root_target,
						conf_interface_names.option_void_safety_value [option.void_safety_capability.value.index],
						conf_interface_names.option_void_safety_value [root_void_safety_index],
						conf_interface_names.option_void_safety_name))
				end
			end
		end

	restricted_concurrency (index: like {CONF_TARGET_OPTION}.concurrency_index_none): like {CONF_TARGET_OPTION}.concurrency_index_none
			-- Concurrency index `index` restricted by current condition `condition`.
		require
			{CONF_TARGET_OPTION}.is_concurrency_index (index)
		local
			value: INTEGER
		do
			Result := index
			if attached condition as cs then
				from
					value := {CONF_TARGET_OPTION}.concurrency_mode_from_index (index)
				until
					Result = {CONF_TARGET_OPTION}.concurrency_index_thread or else
					across cs as ic some attached ic.concurrency as s implies (s.value.has (value) xor s.invert) end
				loop
						-- Move to the smaller capability.
					inspect Result
					when {CONF_TARGET_OPTION}.concurrency_index_none then
						Result := {CONF_TARGET_OPTION}.concurrency_index_thread
						value := {CONF_CONSTANTS}.concurrency_multithreaded
					when {CONF_TARGET_OPTION}.concurrency_index_scoop then
						Result := {CONF_TARGET_OPTION}.concurrency_index_none
						value := {CONF_CONSTANTS}.concurrency_none
					end
				end
			end
		ensure
			{CONF_TARGET_OPTION}.is_concurrency_index (Result)
		end

	restricted_void_safety (index: like {CONF_TARGET_OPTION}.void_safety_index_none): like {CONF_TARGET_OPTION}.void_safety_index_none
			-- Void_safety index `index` restricted by current condition `condition`.
		require
			{CONF_TARGET_OPTION}.is_void_safety_index (index)
		local
			value: INTEGER
		do
			Result := index
			if attached condition as cs then
				from
					value := {CONF_TARGET_OPTION}.void_safety_mode_from_index (index)
				until
					Result = {CONF_TARGET_OPTION}.void_safety_index_none or else
					across cs as ic some attached ic.void_safety as s implies (s.value.has (value) xor s.invert) end
				loop
						-- Move to the smaller capability.
					inspect Result
					when {CONF_TARGET_OPTION}.void_safety_index_all then
						Result := {CONF_TARGET_OPTION}.void_safety_index_transitional
						value := {CONF_CONSTANTS}.void_safety_transitional
					when {CONF_TARGET_OPTION}.void_safety_index_transitional then
						Result := {CONF_TARGET_OPTION}.void_safety_index_initialization
						value := {CONF_CONSTANTS}.void_safety_initialization
					when {CONF_TARGET_OPTION}.void_safety_index_initialization then
						Result := {CONF_TARGET_OPTION}.void_safety_index_conformance
						value := {CONF_CONSTANTS}.void_safety_conformance
					when {CONF_TARGET_OPTION}.void_safety_index_conformance then
						Result := {CONF_TARGET_OPTION}.void_safety_index_none
						value := {CONF_CONSTANTS}.void_safety_none
					end
				end
			end
		ensure
			{CONF_TARGET_OPTION}.is_void_safety_index (Result)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
