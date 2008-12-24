indexing

	description:
		"Warning for potential cat-calls."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CAT_CALL_WARNING

inherit
	FEATURE_ERROR
		redefine
			build_explain, help_file_name, trace_primary_context
		end

	SHARED_NAMES_HEAP

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (a_location: LOCATION_AS) is
			-- Initialize warning
		do
			if a_location /= Void then
				set_location (a_location)
			end
			create covariant_argument_violations.make
			create export_status_violations.make
		ensure
			line_set: a_location /= Void implies line = a_location.line
			column_set: a_location /= Void implies column = a_location.column
		end

feature -- Access

	called_feature: E_FEATURE
			-- Feature which is called and produces the cat-call

	target_type: TYPE_A;
			-- Target type of the assignment (left part)

	source_type: TYPE_A;
			-- Source type of the assignment (right part)

	code: STRING is
			-- Error code
		do
			if export_status_violations /= Void and then not export_status_violations.is_empty then
				Result := "Catcall Export"
			else
				Result := "Catcall"
			end
		end

	help_file_name: STRING is
			-- Error code
		do
			Result := "catcall";
		end

feature -- Element change

	set_source_type (s: TYPE_A) is
			-- Assign `s' to `source_type'.
		do
			source_type := s;
		end;

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t;
		end;

	set_called_feature (a_feature: FEATURE_I) is
			-- Set `called_feature' to `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			called_feature := a_feature.api_feature (a_feature.written_in)
		ensure
			--called_feature_set: called_feature.associated_feature_i = a_feature
		end

	add_export_status_violation (a_descendant_class: CLASS_C; a_descendant_feature: FEATURE_I) is
			-- Add an export status violation of `a_descendant_feature' in `a_descendant_class'.
		require
			a_descendant_class_not_void: a_descendant_class /= Void
			a_descendant_feature_not_void: a_descendant_feature /= Void
		do
			export_status_violations.extend ([a_descendant_class, a_descendant_feature.api_feature (a_descendant_feature.written_in)])
		end

	add_covariant_argument_violation (a_descendant_type: TYPE_A; a_descendant_feature: FEATURE_I; a_type: TYPE_A; a_index: INTEGER) is
			-- Add a covariant argument violation of `a_descendant_feature' in `a_descendant_class' where
			-- the actual type of the call is `a_type' at the argument position `a_index'.
		require
			a_descendant_type_not_void: a_descendant_type /= Void
			a_descendant_feature_not_void: a_descendant_feature /= Void
			a_type_not_void: a_type /= Void
			a_index_positive: a_index > 0
		do
			covariant_argument_violations.extend ([a_descendant_type, a_descendant_feature.api_feature (a_descendant_feature.written_in), a_type, a_index])
		end

	add_covariant_generic_violation is
			-- Add a covariant call through presence of formals.
		do
			has_covariant_generic := True
		end

	add_compiler_limitation (a_parent_type: TYPE_A) is
		require
			a_parent_type_not_void: a_parent_type /= Void
		do
			compiler_limitation_type := a_parent_type
		ensure
			compiler_limitation_type_set: compiler_limitation_type = a_parent_type
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			item: TUPLE [descendant_type: TYPE_A; descendant_feature: E_FEATURE; actual_type: TYPE_A; argument_index: INTEGER]
			l_target_type: CL_TYPE_A
			l_source_type: CL_TYPE_A
			l_same_class_name: BOOLEAN
		do
			if target_type /= Void and source_type /= Void then
					-- Find out if we should also show the group corresponding to the type
					-- involved when they have the same name (which would be confusion to the user).
					--| Note: The same code is present in VUAR2.
				l_target_type ?= target_type
				l_source_type ?= source_type
				if l_target_type /= Void and then l_source_type /= Void then
					l_same_class_name := l_target_type.associated_class.name.is_equal (l_source_type.associated_class.name)
				end

				a_text_formatter.add ("Target type: ");
				target_type.append_to (a_text_formatter);
				if l_same_class_name then
					a_text_formatter.add (" (from ")
					a_text_formatter.add_group (l_target_type.associated_class.lace_class.group,
						l_target_type.associated_class.lace_class.target.name)
					a_text_formatter.add (")")
				end
				a_text_formatter.add_new_line;
				a_text_formatter.add ("Source type: ");
				source_type.append_to (a_text_formatter);
				if l_same_class_name then
					a_text_formatter.add (" (from ")
					a_text_formatter.add_group (l_source_type.associated_class.lace_class.group,
						l_source_type.associated_class.lace_class.target.name)
					a_text_formatter.add (")")
				end
				a_text_formatter.add_new_line
				a_text_formatter.add_new_line
			else
					-- Actual called feature
				a_text_formatter.add ("Called feature: {")
				called_feature.written_class.append_name (a_text_formatter)
				a_text_formatter.add ("}.")
				called_feature.append_signature (a_text_formatter)
				a_text_formatter.add_new_line
				a_text_formatter.add_new_line

					-- Check if covariant generic problems were reported
				if has_covariant_generic then
					a_text_formatter.add ("Covariant generic violation:")
					a_text_formatter.add_new_line
					a_text_formatter.add ("Feature has a formal argument but target of call is not monomorphic.")
					a_text_formatter.add_new_line
					a_text_formatter.add_new_line
				end

					-- Check if covariant feature redefinition problems were reported
				if not covariant_argument_violations.is_empty then
					a_text_formatter.add ("Covariant argument redefinition violation:")
					a_text_formatter.add_new_line
					a_text_formatter.add_new_line
					from
						covariant_argument_violations.start
					until
							-- Show only first 2 entries
						covariant_argument_violations.after or covariant_argument_violations.index > 2
					loop
						item := covariant_argument_violations.item
							-- Argument type warning
						a_text_formatter.add ("Call has argument of type ")
						covariant_argument_violations.item.actual_type.append_to (a_text_formatter)
						a_text_formatter.add (", but if call is made on a descendant of type ")
						item.descendant_type.append_to (a_text_formatter)
						a_text_formatter.add (" then the argument should be of type ")
						item.descendant_feature.arguments.i_th (item.argument_index).append_to (a_text_formatter)
						a_text_formatter.add (" (feature {")
						item.descendant_type.append_to (a_text_formatter)
						a_text_formatter.add ("}.")
						item.descendant_feature.append_signature (a_text_formatter)
						a_text_formatter.add (")")
						a_text_formatter.add_new_line
						covariant_argument_violations.forth
					end

						-- Display how many violations were found				
					if not covariant_argument_violations.after then
						a_text_formatter.add ("...")
						a_text_formatter.add_new_line
						a_text_formatter.add ("Total count of possible descendants: " + covariant_argument_violations.count.out)
						a_text_formatter.add_new_line
						a_text_formatter.add_new_line
					end
				end

				if not export_status_violations.is_empty then
					a_text_formatter.add ("Export status violation:")
					a_text_formatter.add_new_line
					a_text_formatter.add_new_line
					from
						export_status_violations.start
					until
							-- Show only first 2 entries
						export_status_violations.after or export_status_violations.index > 2
					loop
						a_text_formatter.add ("If descendant is of type ")
						export_status_violations.item.descendant_class.append_name (a_text_formatter)
						a_text_formatter.add (" the export status is violated.")
						a_text_formatter.add_new_line
						export_status_violations.forth
					end

						-- Display how many violations were found				
					if not export_status_violations.after then
						a_text_formatter.add ("...")
						a_text_formatter.add_new_line
						a_text_formatter.add ("Total count of possible descendants: " + export_status_violations.count.out)
						a_text_formatter.add_new_line
						a_text_formatter.add_new_line
					end
				end

				if compiler_limitation_type /= Void then
					a_text_formatter.add ("Could not evaluate all possible types for ")
					compiler_limitation_type.append_to (a_text_formatter)
					a_text_formatter.add_new_line
					a_text_formatter.add_new_line
				end
			end
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if {l_class: CLASS_C} associated_class and then {l_feature: !like called_feature} called_feature and then {l_formatter: TEXT_FORMATTER} a_text_formatter then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {SYSTEM_I} -- Implementation

	has_covariant_generic: BOOLEAN
			-- Does current have a covariant generic call.

	covariant_argument_violations: LINKED_LIST [TUPLE [descendant_type: TYPE_A; descendant_feature: E_FEATURE; actual_type: TYPE_A; argument_index: INTEGER]]
			-- List of descendants which produce a possible cat-call because of a covariant argument redefinition

	export_status_violations: LINKED_LIST [TUPLE [descendant_class: CLASS_C; descendant_feature: E_FEATURE]]
			-- List of descendants which produce a possible cat-call because of an export status violation

	compiler_limitation_type: TYPE_A
			-- Type on which compiler could not solve all descendants

invariant
	export_status_violations_not_void: export_status_violations /= Void
	covariant_argument_violations_not_void: covariant_argument_violations /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
