indexing
	description: "Object dumper viewer  ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_DUMPER_VIEWER_BOX

inherit

	EB_OBJECT_VIEWER
		redefine
			build_mini_tool_bar, build_tool_bar
		end

	EV_SHARED_APPLICATION

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	build_widget is
		local
			vb: EV_VERTICAL_BOX
			f: EV_FRAME
		do
			create vb
			widget := vb
			vb.set_border_width (layout_constants.small_border_size)
			vb.set_padding_width (layout_constants.tiny_padding_size)

				--| Viewer
			create editor.make (eb_debugger_manager.debugging_window)
			editor.disable_line_numbers
			editor.disable_has_breakable_slots
			editor.disable_editable
			editor.set_read_only (True)
			editor.drop_actions.extend (agent on_stone_dropped)
			editor.drop_actions.set_veto_pebble_function (agent is_valid_stone)

			create f
			f.extend (editor.widget)
			vb.extend (f)

 			set_title (name)
		end

	build_tool_bar is
		local
			but: SD_TOOL_BAR_BUTTON
		do
			if tool_bar = Void then
				create tool_bar.make
				create but.make
				but.set_pixmap (pixmaps.icon_pixmaps.general_copy_icon)
				but.set_pixel_buffer (pixmaps.icon_pixmaps.general_copy_icon_buffer)
				but.select_actions.extend (agent copy_button_selected)
				but.set_tooltip (Interface_names.l_copy_text_to_clipboard)
				tool_bar.extend (but)
				tool_bar.compute_minimum_size
			end
		end

	build_mini_tool_bar is
		local
			but: SD_TOOL_BAR_BUTTON
		do
			if mini_tool_bar = Void then
				create mini_tool_bar.make
				create but.make
				but.set_pixmap (pixmaps.mini_pixmaps.general_copy_icon)
				but.set_pixel_buffer (pixmaps.mini_pixmaps.general_copy_icon_buffer)
				but.select_actions.extend (agent copy_button_selected)
				but.set_tooltip (Interface_names.l_copy_text_to_clipboard)
				mini_tool_bar.extend (but)

				mini_tool_bar.compute_minimum_size
			end
		end

feature -- Access

	name: STRING_GENERAL is
		do
			Result := Interface_names.t_viewer_object_dumper_title
		end

	widget: EV_WIDGET
	editor: EB_CLICKABLE_EDITOR

feature -- Access

	is_valid_stone (st: OBJECT_STONE; is_strict: BOOLEAN): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := st /= Void
		end

feature -- Change

	refresh is
			-- Recompute the displayed text.
		local
			dobj: DEBUGGED_OBJECT
		do
			editor.clear_window
			if
				debugger_manager.safe_application_is_stopped
			then
				if has_object then
					dobj := debugger_manager.object_manager.debugged_object (current_object.object_address, debugger_manager.min_slice, debugger_manager.max_slice)
					if dobj /= Void then
						editor.handle_before_processing (False)
						(create {DEBUGGER_TEXT_FORMATTER_OUTPUT}.make).append_object (dobj, "Object", editor.text_displayed)
						editor.handle_after_processing
					else
						prompts.show_warning_prompt (Interface_names.l_dbg_unable_to_get_value_message, parent_window (widget), Void)
					end
				end
			end
		end

	destroy is
			-- Destroy Current
		do
			reset
			if widget /= Void then
				widget.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
		do
			Result := True
		end

	parent_window (w: EV_WIDGET): EV_WINDOW is
		local
			p: EV_WIDGET
		do
			p := w.parent
			if p /= Void then
				Result ?= p
				if Result = Void then
					Result := parent_window (p)
				end
			end
		end

	clear is
			-- Clean current data, useless if dialog closed or destroyed
		do
			editor.clear_window
		end

feature {NONE} -- Event handling

	impl_text_formatter: YANK_STRING_WINDOW is
		once
			create Result.make
		end

	copy_button_selected is
			-- Called by `select_actions' of `copy_button'.
		do
			Ev_application.clipboard.set_text (editor.text)
		end

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action is
			-- Close dialog
		do
			destroy
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
