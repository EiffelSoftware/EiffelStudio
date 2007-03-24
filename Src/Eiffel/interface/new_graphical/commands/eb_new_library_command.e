indexing
	description: "Command to create a new library group."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEW_LIBRARY_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			tooltext
		end

	EB_DEVELOPMENT_WINDOW_COMMAND

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		end

	SHARED_WORKBENCH

create
	make

feature -- Basic operations

	execute is
			-- Pop up cluster wizard.
		local
			dial: CREATE_LIBRARY_DIALOG
			wd: EB_WARNING_DIALOG
			l_factory: CONF_COMP_FACTORY
		do
			if Workbench.is_in_stable_state then
				create l_factory
				create dial.make (universe.target, l_factory)
				dial.show_modal_to_window (target.window)
				if dial.is_ok then
					universe.target.system.store
					lace.reset_date_stamp
					system.force_rebuild
					manager.refresh
				end
			else
				create wd.make_with_text (Warning_messages.w_Unsufficient_compilation (6))
				wd.show_modal_to_window (target.window)
			end
		end

feature -- Access

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_library_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_library_icon_buffer
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Create_new_library
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_library_icon
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Create_new_library
		end

	tooltext: STRING_GENERAL is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Create_new_library
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := Interface_names.f_create_new_library
		end

	name: STRING is "New_library";
			-- Name of the command. Used to store the command in the
			-- preferences.

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
