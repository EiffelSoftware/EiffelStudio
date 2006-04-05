indexing

	description:
		"Error object sent by the compiler to the workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EIFFEL_ERROR

inherit

	ERROR
		redefine
			trace, is_defined, has_associated_file
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

	trace (a_text_formatter: TEXT_FORMATTER) is
		do
			print_error_message (a_text_formatter);
			a_text_formatter.add ("Class: ");
			class_c.append_signature (a_text_formatter, False);
			a_text_formatter.add_new_line;
			build_explain (a_text_formatter)
		end;

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
		end;

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
