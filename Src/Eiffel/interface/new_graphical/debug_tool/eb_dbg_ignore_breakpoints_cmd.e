indexing

	description: "Command to toggle ignore breakpoints status."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DGB_IGNORE_BREAKPOINTS_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND
		redefine
			tooltext,
			set_select
		end

	EB_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
--				True, False, True)
--			accelerator.actions.extend (agent execute)
			breakpoints_ignored := False
		end

feature -- Execution

	reset is
		do
			set_select (False)
		ensure
			breakpoints_not_ignored: breakpoints_ignored = False
		end

	execute is
			-- Pause the execution.
		do
			if breakpoints_ignored then
				debugger_manager.stop_at_breakpoints
			else
				debugger_manager.do_not_stop_at_breakpoints
			end
		end

	breakpoints_ignored: BOOLEAN
			-- Breakpoints ignored ?

	is_selected: BOOLEAN is
			-- Graphical button selected ? (pushed)
		do
			Result := breakpoints_ignored
		end

feature -- Change text

	set_select (b: BOOLEAN) is
			-- <Precursor>
		do
			breakpoints_ignored := b
			Precursor (b)
			update_graphical
		end

	update_graphical is
		local
			menu_items: like internal_managed_menu_items
			sd_toolbar_items: like internal_managed_sd_toolbar_items
			t: STRING_GENERAL
			tt: like tooltip
			p: like pixmap
			pb: like pixel_buffer
		do
			p := pixmap
			pb := pixel_buffer
			t := menu_name

			menu_items := internal_managed_menu_items
			if menu_items /= Void then
				from
					menu_items.start
				until
					menu_items.after
				loop
					menu_items.item.set_text (t)
					menu_items.item.set_pixmap (p)
					menu_items.forth
				end
			end

			sd_toolbar_items := internal_managed_sd_toolbar_items
			if sd_toolbar_items /= Void then
				t := tooltext
				tt := tooltip

				from
					sd_toolbar_items.start
				until
					sd_toolbar_items.after
				loop
					if {it: !STRING_GENERAL} (sd_toolbar_items.item.text) and then not it.is_empty then
						sd_toolbar_items.item.set_text (t)
					end
					if tt /= Void then
						sd_toolbar_items.item.set_tooltip (tt)
					end
					sd_toolbar_items.item.set_pixel_buffer (pb)
					sd_toolbar_items.forth
				end
			end
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := "Ignore breakpoints" --Interface_names.e_Dbg_assertion_checking
			if breakpoints_ignored then
				Result := Interface_names.e_Dbg_stop_at_breakpoints
			else
				Result := Interface_names.e_Dbg_ignore_breakpoints
			end
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on `Current's buttons.
		do
			if breakpoints_ignored then
				Result := Interface_names.b_Dbg_stop_at_breakpoints
			else
				Result := Interface_names.b_Dbg_ignore_breakpoints
			end
		end

	name: STRING = "Ignore_breakpoints_cmd"
			-- Name of the command.

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			Result := "Ignore breakpoints"
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			if breakpoints_ignored then
				Result := pixmaps.icon_pixmaps.debugger_environment_without_breakpoints_icon
			else
				Result := pixmaps.icon_pixmaps.debugger_environment_with_breakpoints_icon
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			if breakpoints_ignored then
				Result := pixmaps.icon_pixmaps.debugger_environment_without_breakpoints_icon_buffer
			else
				Result := pixmaps.icon_pixmaps.debugger_environment_with_breakpoints_icon_buffer
			end
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

end
