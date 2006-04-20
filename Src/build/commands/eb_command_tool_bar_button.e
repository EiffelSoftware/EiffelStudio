indexing
	description	: "Toolbar button for a toolbarable toolbar_command"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_COMMAND_TOOL_BAR_BUTTON 

inherit
	EV_TOOL_BAR_BUTTON

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

creation
	make

feature {NONE} -- Initialization

	make (a_command: GB_TOOLBARABLE_COMMAND) is
		do
			default_create
			command := a_command
			command.managed_toolbar_items.extend (Current)
		end

feature -- Cleaning

	recycle is
			-- To be called when the button has became useless.
		do
			command.managed_toolbar_items.prune_all (Current)
			drop_actions.wipe_out
			select_actions.wipe_out
			pick_actions.wipe_out
		end
	
feature {NONE} -- Implementation

	command: GB_TOOLBARABLE_COMMAND;
			-- command associated with Current.

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


end -- class GB_COMMAND_TOOL_BAR_BUTTON
