indexing
	description: "Window manager for class tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_WIN_MGR 

inherit
	EDITOR_MGR
		redefine
			editor_type, make, update_array_resource
		end

	SHARED_FORMAT_TABLES

create
	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Initialize Current.
		do
			Precursor {EDITOR_MGR} (a_screen)
			Class_resources.add_user (Current)
		end

feature -- Access

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			c: CURSOR
		do
			from
				c := active_editors.cursor
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise_shell_popup
				active_editors.forth
			end
			active_editors.go_to (c)
		end

feature -- Update

	update_array_resource (old_res, new_res: ARRAY_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			cr: like Class_resources
		do
			cr := Class_resources
			if old_res = cr.feature_clause_order then
				clear_class_tables
			end
			Precursor {EDITOR_MGR} (old_res, new_res)
		end

feature {NONE} -- Properties

	editor_type: CLASS_W

	create_editor: CLASS_W is
			-- Create a new class tool.
		do
			create Result.make (screen)
		end

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

end -- class CLASS_WIN_MGR
