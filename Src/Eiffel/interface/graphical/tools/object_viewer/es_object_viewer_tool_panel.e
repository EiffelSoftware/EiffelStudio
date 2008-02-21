indexing
	description: "Tool that displays breakpoints"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECT_VIEWER_TOOL_PANEL

inherit
	EB_TOOL
		redefine
--			on_shown,
			internal_recycle,
			attach_to_docking_manager,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content,
			show, close
		end

	EB_OBJECT_VIEWERS_I
		rename
			close as close_tool
		end

	EB_SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

	DEBUGGING_UPDATE_ON_IDLE

create
	make,
	make_with_command

feature {NONE} -- Initialization

	make_with_command (cmd: EB_OBJECT_VIEWER_COMMAND; a_manager: EB_DEVELOPMENT_WINDOW; a_tool: like tool_descriptor) is
		require
			cmd_attached: cmd /= Void
			a_manager_attached: a_manager /= Void
			not_a_manager_is_recycled: not a_manager.is_recycled
			a_tool_attached: a_tool /= Void
			not_a_tool_is_recycled: not a_tool.is_recycled
		do
			command := cmd
			make (a_manager, a_tool)
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			create viewers_manager.make_for_tool (Current)

			viewers_manager.viewer_changed_actions.extend (agent update_viewers_selector)
			widget := viewers_manager.widget
			create_update_on_idle_agent
		end

	build_mini_toolbar is
			-- Build the associated tool bar
		local
			cl: EV_CELL
		do
			create mini_toolbar
			viewer_selector := new_clickable_label (interface_names.l_select_viewer)
			viewer_selector.set_tooltip (interface_names.l_select_viewer)
			viewer_selector.pointer_button_press_actions.extend (agent open_viewer_selector_menu)
			viewer_selector.drop_actions.extend (agent viewers_manager.set_stone)
			viewer_selector.drop_actions.set_veto_pebble_function (agent is_stone_valid)
			mini_toolbar.extend (viewer_selector)
			create cl
			cl.set_minimum_width (3)
			mini_toolbar.extend (cl)
			create viewer_selector_toolbar_cell
			mini_toolbar.extend (viewer_selector_toolbar_cell)
			update_viewers_selector (Void)
		ensure then
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
		do
			Precursor {EB_TOOL} (a_docking_manager)
			check content_not_void : content /= Void end
			content.drop_actions.extend (agent set_stone)
			content.drop_actions.set_veto_pebble_function (agent is_stone_valid)
		end

feature -- Docking

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Properties

	command: EB_OBJECT_VIEWER_COMMAND

	viewers_manager: EB_OBJECT_VIEWERS_MANAGER

	viewer_selector: EV_LABEL

	viewer_selector_toolbar_cell: EV_CELL

feature -- Access

	mini_toolbar: EV_HORIZONTAL_BOX
			-- Associated mini toolbar.

	widget: EV_WIDGET
			-- Widget representing Current.

feature -- change

	reset_tool is
		do
			reset_update_on_idle
			if viewers_manager /= Void then
				viewers_manager.reset
			end
			if command /= Void then
				command.end_debug
			end
		end

feature -- Events

	open_viewer_selector_menu (ax, ay, abutton: INTEGER; ax_tilt, ay_tilt, apressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
		local
			m: EV_MENU
		do
			if abutton = 1 and viewers_manager /= Void then
				m := viewers_manager.menu
				m.show_at (viewer_selector, ax, ay)
			end
		end

	update_viewers_selector	(viewer: EB_OBJECT_VIEWER) is
		local
			v: EB_OBJECT_VIEWER
		do
			v := viewer
			if v = Void and viewers_manager /= Void then
				v := viewers_manager.current_viewer
			end
			if v /= Void and viewer_selector /= Void then
				viewer_selector.set_text (v.name)
				v.build_mini_tool_bar
				if v.mini_tool_bar /= Void then
					if v.mini_tool_bar.parent /= viewer_selector_toolbar_cell then
						replace_cell_content (viewer_selector_toolbar_cell, v.mini_tool_bar)
					end
				else
					viewer_selector_toolbar_cell.wipe_out
				end
				if content /= Void then
					content.update_mini_tool_bar_size
				end
			end
		end

	replace_cell_content (cl: EV_CELL; w: EV_WIDGET) is
			--
		local
			p: EV_CONTAINER
		do
			p := w.parent
			if p /= Void then
				p.prune_all (w)
			end
			cl.replace (w)
		end

	is_stone_valid (a_stone: STONE): BOOLEAN is
		local
			ost: OBJECT_STONE
		do
			ost ?= a_stone
			if ost /= Void and viewers_manager /= Void then
				Result := viewers_manager.is_stone_valid (ost)
			end
		end

	set_stone (a_stone: STONE) is
			--	Stone dropped
		local
			ost: OBJECT_STONE
		do
			ost ?= a_stone
			if ost /= Void then
				viewers_manager.set_stone (ost)
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
			if viewers_manager /= Void then
				viewers_manager.refresh
			end
		end

	show is
			-- Show tool.
		local
			w: EV_WIDGET
		do
			Precursor {EB_TOOL}
			w := viewers_manager.widget
			if w /= Void and then w.is_displayed and w.is_sensitive then
				w.set_focus
			end
			refresh
		end

	close is
		do
			Precursor {EB_TOOL}
			viewers_manager.reset
		end

	close_tool is
		do
			close
			recycle

				-- Close for real this tool
			if content /= Void then
				content.close
			end
			viewers_manager.destroy
			viewers_manager := Void
			if command /= Void then
				command.remove_entry (Current)
			end
		end

feature {NONE} -- Update

	on_update_when_application_is_executing (dbg_stopped: BOOLEAN) is
			-- Update when debugging
		do
		end

	on_update_when_application_is_not_executing is
			-- Update when not debugging
		do
			viewers_manager.clear
		end

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running
		do
			viewers_manager.refresh
		end

feature -- Label management

	new_clickable_label (a_text: STRING_GENERAL): EV_LABEL is
		local
			default_font, big_font: EV_FONT
		do
			create Result.make_with_text (a_text)
			Result.set_foreground_color ((create {EV_STOCK_COLORS}).blue)
			default_font := Result.font
			big_font := Result.font
			big_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)

			Result.pointer_enter_actions.extend (agent highlight_label (Result, default_font, big_font))
			Result.pointer_leave_actions.extend (agent unhighlight_label (Result, default_font, big_font))
			Result.set_minimum_width (maximum_label_width (Result.text, default_font, big_font))
		end

	highlight_label (lab: EV_LABEL; default_font, big_font: EV_FONT) is
			-- Display `lab' with a bold font.
			-- (export status {NONE})
		local
			a_font: EV_FONT
		do
			a_font := big_font
			lab.set_minimum_width (maximum_label_width (lab.text, default_font, big_font) + 6)
			lab.set_font (a_font)
		end

	unhighlight_label (lab: EV_LABEL; default_font, big_font: EV_FONT) is
			-- Display `lab' with a bold font.
			-- (export status {NONE})
		do
			lab.set_font (default_font)
		end

	maximum_label_width (a_text: STRING_GENERAL; default_font, big_font: EV_FONT): INTEGER is
			-- Maximum width of a label when set with text `a_text'
			-- (export status {NONE})
		require
			a_text_not_void: a_text /= Void
		do
			Result := default_font.string_width (a_text).max (big_font.string_width (a_text))
		end

feature -- Memory management

	is_destroyed: BOOLEAN is
		do
			Result := widget = Void or else widget.is_destroyed
		end

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_TOOL}
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
