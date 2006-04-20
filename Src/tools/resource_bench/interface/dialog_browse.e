indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class 
	DIALOG_BROWSE

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok,
			setup_dialog
		end

	EXECUTION_ENVIRONMENT

	TABLE_OF_SYMBOLS

	INTERFACE_MANAGER

	APPLICATION_IDS
		export
			{NONE} all
		end
creation
	make

feature -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
		do
			make_by_id (a_parent, Idd_dialog_browse)
			!! edit_path.make_by_id (Current, Idc_edit_path)
			activate
		end

	setup_dialog is
		do
			edit_path.set_text (current_working_directory)
			edit_path.select_all
		end

feature -- Behavior

	on_ok is
		local
			folder: DIRECTORY
			directory_name: STRING
		do
			!! folder.make (edit_path.text)

			if not folder.exists then
				interface.display_text (std_error, "The specified directory doesn't exist")
			else
				directory_name := current_working_directory
				change_working_directory (edit_path.text)
				tds.generate_wel_code
				terminate (Idok)
				change_working_directory (directory_name)
			end				
		end

feature -- Access

	edit_path: WEL_SINGLE_LINE_EDIT;

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
END -- class DIALOG_BROWSE

