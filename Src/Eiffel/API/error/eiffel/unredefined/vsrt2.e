note

	description:
		"Error if root type does involve classes which are not in the scope of the root cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRT2

inherit

	EIFFEL_ERROR
		redefine
			subcode, build_explain
		end;

feature -- Properties

	code: STRING = "VSRT";
			-- Error code

	subcode: INTEGER = 2;
			-- Sub code of error

	root_type_name: STRING;
			-- Root type involved in the error

	group_name: STRING;
			-- Root type involved in the error

feature	-- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Root type: " + root_type_name)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Group name: " + group_name)
			a_text_formatter.add_new_line

			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_root_type_name (a_root_type_name: like root_type_name)
			-- Assign `a_root_type' to `root_type'.
		require
			a_valid_root_type_name: a_root_type_name /= Void
		do
			root_type_name := a_root_type_name;
		end;

	set_group_name (a_group_name: like group_name)
			-- Assign `a_root_type' to `root_type'.
		require
			a_valid_group_name: a_group_name /= Void
		do
			group_name := a_group_name;
		end;

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

end -- class VSRT1
