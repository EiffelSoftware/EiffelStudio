indexing
	description: "Object internal viewer  ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_INTERNAL_VIEWER_BOX

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
			create output
			output.enable_border
			output.enable_multiple_row_selection
			output.hide_header

			output.drop_actions.extend (agent on_stone_dropped)
			output.drop_actions.set_veto_pebble_function (agent is_valid_stone)

			create f
			f.extend (output)
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
			-- <Precursor>
		do
			Result := Interface_names.t_viewer_object_internal_title
		end

	widget: EV_WIDGET
			-- Widget representing Current

	output: ES_GRID
			-- Grid containing information

feature -- Access

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := {st: !OBJECT_STONE} a_stone
		end

feature -- Change

	refresh is
			-- Recompute the displayed text.
		local
			cdv, dv: DUMP_VALUE
			info: ARRAY [TUPLE [name: STRING; value: DUMP_VALUE]]
			i: INTEGER
			s: STRING_32
			grid: EV_GRID
		do
			clear
			if
				debugger_manager.safe_application_is_stopped
			then
				grid := output
				if has_object then
					cdv := current_dump_value
					if cdv /= Void then
						info := debugger_manager.application.internal_info (cdv)
						if info = Void or else info.is_empty then
							grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text (interface_names.l_no_information_available))
						else
							from
								i := info.lower
								grid.insert_new_rows (info.count, 1)
							until
								i > info.upper
							loop
								grid.set_item (1, i, create {EV_GRID_LABEL_ITEM}.make_with_text (info[i].name))
								dv := info[i].value
								if dv /= Void then
									if dv.has_formatted_output then
										s := dv.string_representation
									else
										s := dv.output_value (True)
									end
									grid.set_item (2, i, create {EV_GRID_LABEL_ITEM}.make_with_text (s))
								else
									grid.set_item (2, i, create {EV_GRID_ITEM})
								end
								i := i + 1
							end
							if grid.column_count > 1 then
								grid.column (1).resize_to_content
								grid.column (2).resize_to_content
							end
						end
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
			output.wipe_out
		end

feature {NONE} -- Event handling

	copy_button_selected is
			-- Called by `select_actions' of `copy_button'.
		local
			l_rows: LIST [EV_GRID_ROW]
			r: EV_GRID_ROW
			i: INTEGER
			s: STRING_32
		do
			l_rows := output.selected_rows
			create s.make_empty
			from
				l_rows.start
			until
				l_rows.after
			loop
				r := l_rows.item
				if r /= Void and then r.count > 0 then
					from
						i := 1
					until
						i > r.count
					loop
						if {lab: !EV_GRID_LABEL_ITEM} r.item (i) then
							s.append (lab.text)
						else
							s.append_character ('%T')
						end
						s.append_character ('%T')
						i := i + 1
					end
					s.append_character ('%N')
				end
				l_rows.forth
			end
			Ev_application.clipboard.set_text (s)
		end

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the output. Handle it.
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
