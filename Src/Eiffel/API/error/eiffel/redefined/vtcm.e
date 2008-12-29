note
	description: "Warning when a class name of an export clause is not found in the surrounding universe."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCM

inherit
	EIFFEL_WARNING
		redefine
			build_explain,
			print_single_line_error_message
		end

feature -- Properties

	class_name: STRING
			-- Class name not found

	code: STRING = "VTCM"
			-- Error code

feature -- Status report

	less_than (other: VTCM): BOOLEAN
			-- Is `Current' less than `other'?
		require
			other_not_void: other /= Void
		do
			Result := associated_class.name < other.associated_class.name
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Unknown class name: ")
			a_text_formatter.add (class_name)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			if class_name /= Void then
				a_text_formatter.add_space
				a_text_formatter.add ("Unknown class ")
				a_text_formatter.add (class_name)
				a_text_formatter.add (".")
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_class (c: like associated_class)
			-- Assign `c' to class_c.
		require
			valid_c: c /= Void
		do
			associated_class := c
		end

	set_class_name (s: STRING)
			-- Assign `s' to `class_name'.
		require
			s_not_void: s /= Void
		do
			class_name := s.as_upper
		ensure
			class_name_set: class_name /= Void
		end

	set_dotnet_class_name (s: STRING)
			-- Assign `s' to `class_name'.
		require
			s_not_void: s /= Void
		do
			class_name := s
		ensure
			class_name_set: class_name = s
		end

note
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

end -- class VTCM
