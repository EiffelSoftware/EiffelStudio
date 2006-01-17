indexing
	description: "Resource vategory for the feature tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_CATEGORY

inherit
	EDITOR_RESOURCE_CATEGORY
		export
			{NONE} command_bar, format_bar
		end

create
	make


feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			create users.make;
			create modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("feature_tool_width", rt, 600);
			create tool_height.make ("feature_tool_height", rt, 450);
			create keep_toolbar.make ("show_toolbar", rt, True)
			create double_line_toolbar.make ("two_lines_toolbar", rt, False)
			create show_all_callers.make ("show_all_callers", rt, False)
			create do_flat_in_breakpoints.make ("do_flat_in_breakpoints", rt, True)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	show_all_callers: BOOLEAN_RESOURCE;
	do_flat_in_breakpoints: BOOLEAN_RESOURCE;
	double_line_toolbar, keep_toolbar: BOOLEAN_RESOURCE;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ROUTINE_CATEGORY
