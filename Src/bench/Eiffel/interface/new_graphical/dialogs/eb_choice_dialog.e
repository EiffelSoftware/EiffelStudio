indexing

	desciption: "Window where the user can make choice."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOICE_DIALOG

inherit
	EV_POPUP_WINDOW
		redefine
			show
		end

	EV_COMMAND
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		undefine
			default_create, copy
		end

create
	make_default

feature -- Initialization
		
	make_default (ctf: like callback) is
			-- Make a choice window, and set a callback procedure.
		local
			vb: EV_VERTICAL_BOX
		do
			callback := ctf

			create list
			list.hide_title_row
			list.pointer_button_release_actions.extend (agent on_select)
			list.key_press_actions.extend (agent key_actions)

			create vb
			vb.set_padding (3)
			vb.extend (list)

			default_create
			extend (vb)

			show_actions.extend (agent on_shown)
		end

feature --

	show is
		do
			enable_user_resize
			Precursor {EV_POPUP_WINDOW}
		end

feature

	selected_name: STRING is
			-- Text of selected item in list of alternatives
		do
			Result := list.selected_item.first
		end

	set_list (name_list: LIST [STRING]; pixmap_list: LIST [EV_PIXMAP]) is
			-- Fill the choice window with `name_list' using `pixmap_list' if applicable.
		require
			valid_args: name_list /= Void
			pixmap_list_valid: pixmap_list /= Void implies pixmap_list.count = name_list.count
		local
			lr: EV_MULTI_COLUMN_LIST_ROW
			new_width: INTEGER
			char_width: INTEGER
			char_height: INTEGER
		do
				-- Default medium size of characters.
				-- font.maximum_width is too much, so we add 4 to the average width.
			char_width := (create {EV_FONT}).width + 4
				-- + 1 because there may be a space between list items.
			char_height := (create {EV_FONT}).height + 1

			list.wipe_out
			from
				name_list.start
			until
				name_list.after
			loop
				create lr
				if pixmap_list /= Void then
					lr.set_pixmap (pixmap_list @ name_list.index)
				end
				lr.extend (name_list.item)

				list.extend (lr)
				new_width := new_width.max (name_list.item.count)
				name_list.forth
			end
			list.resize_column_to_content (1)

				-- We allow bounds for the list width of 70 and 150 pixels.
			list.set_minimum_width ((List_maximum_width.min (new_width * char_width + 10)).max (List_minimum_width))
				-- We allow bounds for the list height of 50 and 300 pixels.
			list.set_minimum_height (((List_maximum_height).min (name_list.count * char_height + 40)).max (List_minimum_height))
		end

	execute (it: EV_MULTI_COLUMN_LIST_ROW) is
			-- Recall the caller command.
		local
			p: INTEGER
		do
			p := list.index_of (it, 1)
			destroy_dialog
			if callback /= Void then
				callback.call ([p])
			end
		end

	select_item (i: INTEGER) is
			-- Select item at the `i'-th position.
		do
			if i <= list.count and then i > 0 then
				list.i_th (i).enable_select
			end
		end

	on_shown is
			-- The dialog is being displayed.
			-- Give the focus to the list.
		do
			list.set_focus
			if not list.is_empty then
				list.first.enable_select
			end
			list.focus_out_actions.wipe_out
			list.focus_out_actions.extend (agent one_lost_focus)
			focus_out_actions.wipe_out
			focus_out_actions.extend (agent one_lost_focus)
		end

feature {NONE} -- Properties

	list: EV_MULTI_COLUMN_LIST

	callback: PROCEDURE [ANY, TUPLE [INTEGER]]
			-- Command who calls `Current'
			-- Will be sent the position of
			-- the selected item.

feature {NONE} -- Implementation

	destroy_dialog is
			-- Destroy in a safe manner current dialog.
		require
			list_not_void: list /= Void
		do
			if not is_destroyed then
					-- Because call to destroy may cause a call to the focus_out actions
					-- we make sure there are none that could be triggered.
				list.focus_out_actions.wipe_out
				focus_out_actions.wipe_out
				destroy
			end
		end

	Key_csts: EV_KEY_CONSTANTS is
			-- Default key constants.
		once
			create Result
		end

	key_actions (k: EV_KEY) is
			-- Call `execute' if k = Enter, `destroy_dialog' if k = Esc.
		do
			if k.code = Key_csts.Key_enter then
				if list.selected_item /= Void then
					execute (list.selected_item)
				end
			elseif k.code = Key_csts.Key_escape then
				destroy_dialog
			end
		end

	one_lost_focus is
			-- One the widgets in `Current' lost the focus.
			-- If no widget has the focus, destroy `Current'.
		do
			if
				not list.has_focus and then
				not is_destroyed and then
				not has_focus
			then
				destroy_dialog
			end
		end

	on_select (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- The user clicked on a list item.
		do
			if list.selected_item /= Void then
				execute (list.selected_item)
			end
		end

	List_minimum_width: INTEGER is 70
	List_maximum_width: INTEGER is 300
	List_minimum_height: INTEGER is 50
	List_maximum_height: INTEGER is 300
		-- Bounds for the displayed list.

invariant

--	list_exists: list /= Void

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

end -- class EB_CHOICE_DIALOG
