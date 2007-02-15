indexing

	description:
		"Set execution format so that breakable point %
			%will be taken into account."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_DEBUG_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			User_stop_points as execution_mode
		redefine
			make,
			tooltext,
			is_tooltext_important
		end

create
	make

feature -- Initialization

	make (a_manager: like eb_debugger_manager) is
			-- Initialize `Current'.
		do
			tooltext := Interface_names.b_launch
			menu_name := Interface_names.m_Debug_run_new
			internal_tooltip := Interface_names.e_Exec_debug

			Precursor (a_manager)
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
				False, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Access

	set_launched (a_launched: BOOLEAN) is
		do
			if a_launched then
				tooltext := Interface_names.b_Continue
				menu_name := Interface_names.m_Debug_run_continue
				internal_tooltip := Interface_names.e_Exec_debug_continue
			else
				tooltext := Interface_names.b_launch
				menu_name := Interface_names.m_Debug_run_new
				internal_tooltip := Interface_names.e_Exec_debug
			end
			refresh_items
		end

	refresh_items is
		local
			l_toolbar_lst: like internal_managed_toolbar_items
			l_toolbar_item: like new_toolbar_item
			l_sd_lst: like internal_managed_sd_toolbar_items
			l_sd_item: like new_sd_toolbar_item
			l_menu_lst: like internal_managed_menu_items
			l_menu_item: like new_menu_item
		do
			l_toolbar_lst := internal_managed_toolbar_items
			if l_toolbar_lst /= Void then
				from
					l_toolbar_lst.start
				until
					l_toolbar_lst.after
				loop
					l_toolbar_item := l_toolbar_lst.item
					initialize_toolbar_item (l_toolbar_item, not l_toolbar_item.text.is_empty)
					l_toolbar_lst.forth
				end
			end
			l_sd_lst := internal_managed_sd_toolbar_items
			if l_sd_lst /= Void then
				from
					l_sd_lst.start
				until
					l_sd_lst.after
				loop
					l_sd_item := l_sd_lst.item
					initialize_sd_toolbar_item (l_sd_item, not l_sd_item.text.is_empty)
					l_sd_lst.forth
				end
			end
			l_menu_lst := internal_managed_menu_items
			if l_menu_lst /= Void then
				from
					l_menu_lst.start
				until
					l_menu_lst.after
				loop
					l_menu_item := l_menu_lst.item
					initialize_menu_item (l_menu_item)
					l_menu_lst.forth
				end
			end
		end

feature {NONE} -- Attributes

	pixmap: EV_PIXMAP is
			-- Pixmap for the button.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon_buffer
		end

	name: STRING is "Exec_debug"
			-- Name of the command.

	tooltext: STRING_GENERAL
			-- Default text displayed in toolbar button

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	internal_tooltip: STRING_GENERAL
			-- Tooltip displayed on `Current's buttons.

	menu_name: STRING_GENERAL;
			-- Name used in menu entry.

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

end -- class EB_EXEC_NO_STOP_CMD
