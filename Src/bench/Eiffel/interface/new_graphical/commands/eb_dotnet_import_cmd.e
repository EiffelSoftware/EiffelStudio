indexing
	description: "Command used to launch ISE Assembly Manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_DOTNET_IMPORT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
	
	EB_CONSTANTS
		export
			{NONE} all
		end
		
	EB_SHARED_WINDOW_MANAGER
	
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create implementation
		end

feature -- Access

	ISE_assembly_manager_filename: STRING is
			-- Filename of `ISE.AssemblyManager.exe'
		once
			Result := clone (Eiffel_delivery_path)
			Result.append (ISE_assembly_manager_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: not Result.is_empty
		end
		
	menu_name: STRING is
			-- Name of `Current' in menus (with `&' symbol).
		do
			Result := Interface_names.m_Dotnet_import
		end

	tooltip: STRING is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.e_Dotnet_import
		end

	description: STRING is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.e_Dotnet_import
		end

	name: STRING is
			-- Text identifier for `Current'.
		do
			Result := "Dotnet_import"
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Icon for `current'.
		do
			Result := Pixmaps.Icon_dotnet_import
		end

feature -- Basic operations

	execute is
			-- Command execution.
			-- Display `ISE.AssemblyManager'
		--local
		--	cursor_pixmap: EV_STOCK_PIXMAPS
		do
			development_window := window_manager.last_focused_development_window.window
		--	create cursor_pixmap
		--	development_window.set_pointer_style (cursor_pixmap.Wait_cursor)
			disable_sensitive 
			implementation.launch_and_refresh (ISE_assembly_manager_filename, "", agent on_refresh)
		--	development_window.set_pointer_style (cursor_pixmap.Standard_cursor)
			enable_sensitive
		end
		
feature {NONE} -- Implementation

	implementation: EB_DOTNET_IMPORT_CMD_IMP
			-- Implementation (platform specific)
			
	development_window: EV_WINDOW
			-- Last focused EiffelStudio development window
			
	Eiffel_delivery_path: STRING is 
			-- Path to Eiffel delivery
		once
			Result := get (Eiffel_key)
		ensure
			non_void_path: Result /= Void
			not_empty_path: not Result.is_empty
		end
	
	Eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable for Eiffel delivery

	ISE_assembly_manager_relative_filename: STRING is "\wizards\dotnet\ISE.AssemblyManager.exe"
			-- Filename of `ISE.AssemblyManager.exe' (relatively to Eiffel delivery path) 

	on_refresh is
			-- Action performed while ISE Assembly Manager is active to refresh EiffelStudio development window
		do
			ev_application.process_events
		end
		
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

end -- class EB_DOTNET_IMPORT_CMD
