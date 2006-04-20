indexing
	description: "Objects that represent the special debug menu for eStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_MENU

inherit
	EV_MENU
	
	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end		
	
	EB_SHARED_GRAPHICAL_COMMANDS 
		undefine
			default_create, is_equal, copy
		end
	EB_SHARED_PREFERENCES
		undefine
			default_create, is_equal, copy
		end
create
	make_with_window
	
feature {NONE} -- Initialization
	
	make_with_window (w: EV_WINDOW) is
		local
			menu_item: EV_MENU_ITEM
		do
			window := w
			default_create
			set_text (Major_version_number.out + "." + Minor_version_number.out + "." +Build_version_number)
			
				--| Memory tool
			create menu_item.make_with_text ("Memory Analyzer")
			menu_item.select_actions.extend (agent launch_memory_tool)
			extend (menu_item)
		
		end
		
feature {NONE} -- Actions

	launch_memory_tool is
			-- Launch Memory Analyzer.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_path: STRING
			l_dir: DIRECTORY_NAME
			l_dlg: EV_INFORMATION_DIALOG
		do
			if ma_window = Void or ma_window.is_destroyed then
				create l_env
				l_path := l_env.get ("EIFFEL_SRC")
				if l_path = Void then
					create l_dlg.make_with_text ("EIFFEL_SRC not defined.")
					l_dlg.show
				else
					create l_dir.make_from_string (l_path)
					l_dir.extend_from_array (<<"library", "memory_analyzer" >>)
					create ma_window.make (l_dir)
					ma_window.close_request_actions.extend (agent handle_close_window)
				end
			end
			ma_window.show
		end
		
feature {NONE} -- Implementation

	handle_close_window is
			-- Handle user press window action.
		do
			ma_window.destroy
		end
		
	window: EV_WINDOW
			-- Main development window.
	
	ma_window: MA_WINDOW;
			-- Memory analyzer window.

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
