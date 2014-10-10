note
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

	build_widget
		local
			vb: EV_VERTICAL_BOX
			f: EV_FRAME
		do
			create vb
			widget := vb
			if not is_associated_with_tool then
				vb.set_border_width (layout_constants.small_border_size)
			end
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

	build_tool_bar
		local
			but: SD_TOOL_BAR_BUTTON
		do
			if tool_bar = Void then
				create {SD_TOOL_BAR} tool_bar.make
				create but.make
				but.set_pixmap (pixmaps.icon_pixmaps.general_copy_icon)
				but.set_pixel_buffer (pixmaps.icon_pixmaps.general_copy_icon_buffer)
				but.select_actions.extend (agent copy_button_selected)
				but.set_tooltip (Interface_names.l_copy_text_to_clipboard)
				tool_bar.extend (but)
				tool_bar.compute_minimum_size
			end
		end

	build_mini_tool_bar
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

	name: STRING_GENERAL
			-- <Precursor>
		do
			Result := Interface_names.t_viewer_object_internal_title
		end

	widget: EV_WIDGET
			-- Widget representing Current

	output: ES_GRID
			-- Grid containing information

feature -- Access

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN
			-- Is `st' valid stone for Current?
		do
			Result := attached {OBJECT_STONE} a_stone as st
		end

feature -- Change

	refresh
			-- Recompute the displayed text.
		local
			cdv: DUMP_VALUE
			i,r: INTEGER
			s: STRING_32
			glab: EV_GRID_LABEL_ITEM
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
						if attached debugger_manager.application.object_internal_info (cdv) as infos and then infos.count > 0 then
							from
								i := 0
								r := 1
								grid.insert_new_rows (infos.count, 1)
							until
								i >= infos.count
							loop
								if attached infos[i] as info_item then
									grid.set_item (1, r, create {EV_GRID_LABEL_ITEM}.make_with_text (info_item.name))
									if attached info_item.value as dv then
										create glab.make_with_text (dv)
										grid.set_item (2, r, glab)
										r := r + 1
									else
										create glab
										glab.set_pixmap (pixmaps.mini_pixmaps.debugger_error_icon)
										grid.set_item (2, r, glab)
										r := r + 1
									end
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

	destroy
			-- Destroy Current
		do
			reset
			if attached widget as w then
				w.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

	parent_window (w: EV_WIDGET): EV_WINDOW
		do
			if attached w.parent as p then
				Result ?= p
				if Result = Void then
					Result := parent_window (p)
				end
			end
		end

	clear
			-- Clean current data, useless if dialog closed or destroyed
		do
			output.wipe_out
		end

feature {NONE} -- Event handling

	copy_button_selected
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
						if attached {EV_GRID_LABEL_ITEM} r.item (i) as lab then
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

	on_stone_dropped (st: OBJECT_STONE)
			-- A stone was dropped in the output. Handle it.
		do
			set_stone (st)
		end

	close_action
			-- Close dialog
		do
			destroy
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
