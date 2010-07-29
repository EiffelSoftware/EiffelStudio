note
	description: "Error if root type does involve classes which are not in the scope of the root cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRT2

inherit
	VSRT
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER = 2
			-- Sub code of error

	root_type_as: CLASS_TYPE_AS
			-- Actual root class description

	group_name: STRING
			-- Root type involved in the error

feature	-- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Root type ")
			a_text_formatter.add (root_type_as.dump)
			a_text_formatter.add (" is based on an unknown class.")
			a_text_formatter.add_new_line
			a_text_formatter.add ("List classes that are reachable from the following group: " + group_name)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_root_type_as (a_root_type_as: like root_type_as)
			-- Assign `a_root_type' to `root_type'.
		require
			a_valid_root_type_as: a_root_type_as /= Void
		do
			root_type_as := a_root_type_as
		ensure
			root_type_as_set: root_type_as = a_root_type_as
		end

	set_group_name (a_group_name: like group_name)
			-- Assign `a_root_type' to `root_type'.
		require
			a_valid_group_name: a_group_name /= Void
		do
			group_name := a_group_name
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class VSRT1
