indexing

	description:
		"Error object sent by the compiler to the workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EIFFEL_ERROR

inherit
	COMPILER_ERROR
		redefine
			trace, is_defined, has_associated_file,
			trace_primary_context
		end

feature -- Properties

	class_c: CLASS_C;
			-- Class where the error is encountered

	file_name: STRING is
			-- File where error is encountered
		do
			Result := class_c.file_name
		end

	has_associated_file: BOOLEAN is
			-- Error is relative to a file/class
		do
			Result := True
		end

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined
		ensure then
			yes_implies_class_defined: Result implies is_class_defined
		end;

	is_class_defined: BOOLEAN is
			-- Is `class_c' defined for error?
		do
			Result := class_c /= Void
		ensure
			yes_implies_valid_class: Result implies class_c /= Void
		end;

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
		end

	trace (a_text_formatter: TEXT_FORMATTER) is
		do
			print_error_message (a_text_formatter);
			a_text_formatter.add ("Class: ");
			class_c.append_signature (a_text_formatter, False);
			a_text_formatter.add_new_line;
			build_explain (a_text_formatter)
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if {l_class: !CLASS_C} class_c and then {l_formatter: !TEXT_FORMATTER} a_text_formatter then
				print_context_class (l_class, l_formatter)
			else
				Precursor (a_text_formatter)
			end
		end

feature {NONE} -- Output

	print_context_group (a_group: !CONF_GROUP; a_formatter: !TEXT_FORMATTER) is
			-- Prints a context group URI.
		do
			if {l_cluster: !CONF_CLUSTER} a_group then
				if {l_parent: !CONF_GROUP} l_cluster.parent then
					print_context_group (l_parent, a_formatter)
					a_formatter.add (".")
				end
			end
			a_formatter.add_group (a_group, a_group.name)
		end

	print_context_class (a_class: !CLASS_C; a_formatter: !TEXT_FORMATTER) is
			-- Prints a context class URI, including the group name.
		do
			a_class.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add (" (")
				print_context_group (l_group, a_formatter)
				a_formatter.add (")")
			end
		end

	print_context_feature (a_feature: !E_FEATURE; a_class: !CLASS_C; a_formatter: !TEXT_FORMATTER) is
			-- Prints a context feature URI, including the class and group name.
		do
			a_class.append_name (a_formatter)
			a_formatter.add (".")
			a_feature.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add (" (")
				print_context_group (l_group, a_formatter)
				a_formatter.add (")")
			end
		end

feature {COMPILER_EXPORTER}

	set_class (c: like class_c) is
			-- Assign `c' to `class_c'.
		require
			valid_c: c /= Void
		do
			class_c := c
		end;

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

end -- class EIFFEL_ERROR
