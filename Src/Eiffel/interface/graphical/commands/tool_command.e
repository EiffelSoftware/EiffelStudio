indexing

	description:	
		"Command associated with a tool. All of these commands %
		%should be in menu."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOOL_COMMAND

inherit

	ISE_COMMAND;
	EB_CONSTANTS;
	WINDOWS

feature {NONE} -- Initialization

	init (a_tool: like tool) is
			-- Initialize a command with the `symbol' icon,
			-- `a_tool' is passed as argument to the activation action.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool = a_tool
		end;

feature -- Access

	tool: TOOL_W;
			-- Tool associated with command

	text_window: TEXT_WINDOW is
			-- Text window which status tells if we want to execute 
			-- or not, and usually the target of the command
		do
			Result := tool.text_window
		end;

	popup_parent: COMPOSITE is
			-- Parent used for popup creation
		do
			Result := tool.popup_parent
		end;

invariant

	tool_not_void: tool /= Void

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

end -- class TOOL_COMMAND
