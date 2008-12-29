note
	description: "Object that defines a menu item and a toolbar item of Terminate C Compilation function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TERMINATE_C_COMPILATION_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext
		end

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_MANAGERS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Status setting

	execute
			-- Launch `Current'.
			-- Pop up an error wizard relative to the last focused development window.
		do
			internal_execute
		end

	execute_with_stone (st: ERROR_STONE)
			--
		do
			internal_execute
		end

feature -- Status report

	description: STRING_GENERAL
			-- Explanatory text for this command.
		do
			Result := Interface_names.e_Terminate_c_compilation
		end

	tooltip: STRING_GENERAL
			-- Tooltip for `Current's toolbar button.
		do
			Result := Interface_names.b_Terminate_c_compilation
		end

	tooltext: STRING_GENERAL
			-- Text for `Current's toolbar button.
		do
			Result := Interface_names.b_Terminate_c_compilation
		end

	name: STRING = "Terminate C compilation"
			-- Internal textual representation.

	pixmap: EV_PIXMAP
			-- Image used for `Current's toolbar buttons.
		do
			Result := Void
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			-- Currently there is no pixel buffer for this command.
		end

	menu_name: STRING_GENERAL
			-- Text used for menu items for `Current'.
		do
			Result := Interface_names.b_Terminate_c_compilation
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.drop_actions.extend (agent execute_with_stone)
		end

feature {NONE} -- Implementation

	internal_execute
			-- Teminate running c compilation
		do
			if process_manager.is_c_compilation_running then
				process_manager.terminate_c_compilation
			end
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

end -- class EB_TERMINATE_C_COMPILATION_CMD
