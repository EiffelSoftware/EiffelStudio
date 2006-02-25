indexing

	description:
		"Command to save the query and options %
		%currently displayed in a PROFILE_QUERY_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_RESULT_CMD

inherit
	COMMAND_W

create
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_QUERY_WINDOW) is
			-- Create Current and set `tool' to `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature {NONE} -- Command Execution

	work (arg: ANY) is
			-- Execute Current
		local
			nc: NAME_CHOOSER_W
			file_name: STRING
		do
			if arg = Void then
				nc := name_chooser (tool);
				nc.set_save_file;
				nc.call (Current)
			else
				file_name := clone (last_name_chooser.selected_file)
				tool.save_in (file_name)
			end
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW;

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

end -- class SAVE_RESULT_CMD
