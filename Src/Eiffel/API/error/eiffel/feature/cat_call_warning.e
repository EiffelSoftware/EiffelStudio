indexing

	description:
		"Warning for potential cat-calls."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CAT_CALL_WARNING

inherit
	EIFFEL_WARNING
		redefine
			build_explain, help_file_name, trace_primary_context
		end

	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_C; a_feature: FEATURE_I; a_location: LOCATION_AS) is
			-- Initialize warning
		require
			a_class_not_void: a_class /= Void
			a_location_not_void: a_location /= Void
		do
			set_class (a_class)
			set_feature (a_feature)
			set_location (a_location)
			create covariant_argument_violations.make
			create export_status_violations.make
		ensure
			associated_class_set: associated_class = a_class
			line_set: line = a_location.line
			column_set: column = a_location.column
		end

feature -- Access

	associated_feature: E_FEATURE
			-- Feature where cat-call happens

	called_feature: E_FEATURE
			-- Feature which is called and produces the cat-call

	code: STRING is
			-- Error code
		do
			Result := "Catcall";
		end

	help_file_name: STRING is
			-- Error code
		do
			Result := "catcall";
		end

feature -- Element change

	set_class (a_class: CLASS_C) is
			-- Set `associated_class' to `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			associated_class := a_class
		ensure
			associated_class_set: associated_class = a_class
		end

	set_feature (a_feature: FEATURE_I) is
			-- Set `associated_feature' to `a_feature'.
		do
			if a_feature /= Void then
				associated_feature := a_feature.api_feature (a_feature.written_in)
			end
		end

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

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			item: TUPLE [descendant_type: TYPE_A; descendant_feature: E_FEATURE; actual_type: TYPE_A; argument_index: INTEGER]
		do
				-- Print context
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			if associated_feature = Void then
				a_text_formatter.add ("Invariant")
			else
				a_text_formatter.add ("Feature: ")
				associated_feature.append_name (a_text_formatter)
			end
			a_text_formatter.add_new_line
			a_text_formatter.add_new_line

				-- Actual called feature
			a_text_formatter.add ("Called feature: {")
			called_feature.written_class.append_name (a_text_formatter)
			a_text_formatter.add ("}.")
			called_feature.append_signature (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add_new_line

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

			update_statistics
			print_statistics (a_text_formatter)
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if {l_class: !like associated_class} associated_class and then {l_feature: !like associated_feature} associated_feature and then {l_formatter: !TEXT_FORMATTER} a_text_formatter then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {NONE} -- Implementation

	covariant_argument_violations: LINKED_LIST [TUPLE [descendant_type: TYPE_A; descendant_feature: E_FEATURE; actual_type: TYPE_A; argument_index: INTEGER]]
			-- List of descendants which produce a possible cat-call because of a covariant argument redefinition

	export_status_violations: LINKED_LIST [TUPLE [descendant_class: CLASS_C; descendant_feature: E_FEATURE]]
			-- List of descendants which produce a possible cat-call because of an export status violation

	statistics: TUPLE [
		total: INTEGER;
		export_violation: INTEGER;
		covariant_violation: INTEGER;
		any_features: INTEGER;
		generic_features: INTEGER;
		like_current_feature: INTEGER;
		other: INTEGER] is
			-- Statistics of catcalls in system
		once
			Result := [0, 0, 0, 0, 0, 0, 0]
		end

	update_statistics is
			-- Update statistics with catcall of current warning
		local
			l_feature_name: INTEGER
		do
			statistics.total := statistics.total + 1
			if not export_status_violations.is_empty then
				statistics.export_violation := statistics.export_violation + 1
			end
			if not covariant_argument_violations.is_empty then
				statistics.covariant_violation := statistics.covariant_violation + 1
				l_feature_name := called_feature.name_id
				if
					l_feature_name = names_heap.equal_name_id or
					l_feature_name = names_heap.standard_equal_name_id or
					l_feature_name = names_heap.deep_equal_name_id or
					l_feature_name = names_heap.is_equal_name_id or
					l_feature_name = names_heap.standard_is_equal_name_id or
					l_feature_name = names_heap.is_deep_equal_name_id or
					l_feature_name = names_heap.copy_name_id or
					l_feature_name = names_heap.standard_copy_name_id or
					l_feature_name = names_heap.deep_copy_name_id
				then
					statistics.any_features := statistics.any_features + 1
				elseif
					called_feature.arguments /= Void and then
					called_feature.arguments.there_exists (
						agent (a_type: TYPE_A): BOOLEAN
							do
								Result := a_type.is_like_current
							end)
				then
					statistics.like_current_feature := statistics.like_current_feature + 1
				elseif
					called_feature.arguments /= Void and then
					called_feature.arguments.there_exists (
						agent (a_type: TYPE_A): BOOLEAN
							do
								Result := a_type.is_formal or else a_type.actual_type.is_formal
							end)
				then
					statistics.generic_features := statistics.generic_features + 1
				else
					statistics.other := statistics.other + 1
				end
			end
		end

	print_statistics (a_text_formatter: TEXT_FORMATTER) is
			--
		do
			a_text_formatter.add ("STAT (")
			a_text_formatter.add ("total: " + statistics.total.out + "%T")
			a_text_formatter.add ("export-violation: " + statistics.export_violation.out + "%T")
			a_text_formatter.add ("covariant-violation: " + statistics.covariant_violation.out + "%T")
			a_text_formatter.add ("any-features: " + statistics.any_features.out + "%T")
			a_text_formatter.add ("like-current-features: " + statistics.like_current_feature.out + "%T")
			a_text_formatter.add ("generics: " + statistics.generic_features.out + "%T")
			a_text_formatter.add ("other: " + statistics.other.out + "%T")
			a_text_formatter.add (")")
			a_text_formatter.add_new_line
		end

invariant

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
