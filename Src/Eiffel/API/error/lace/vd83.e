indexing
	description: "Warning that a setting could not be changed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD83

inherit
	LACE_WARNING
		redefine
			build_explain
		end;

create
	make

feature {NONE} -- Initialization

	make (a_setting, an_old_value, a_new_value: STRING) is
			-- Create.
		require
			a_setting_not_void: a_setting /= Void
			an_old_value_not_void: an_old_value /= Void
			a_new_value_not_void: a_new_value /= Void
		do
			setting := a_setting
			old_value := an_old_value
			new_value := a_new_value
		end

feature -- Properties

	setting: STRING
			-- Setting name.

	old_value: STRING
			-- Old value (which was preserved).

	new_value: STRING
			-- New value (which was ignored).

feature -- Output

	build_explain (st: TEXT_FORMATTER) is
		do
			st.add_new_line
			st.add ("Value of a setting could not be changed because the system is already compiled or uses a precompile: ");
			st.add (setting);
			st.add_new_line
			st.add ("Old: "+old_value)
			st.add_new_line
			st.add ("New: "+new_value)
			st.add_new_line;
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

end
