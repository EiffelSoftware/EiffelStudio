note
	legal: "See notice at end of class."
	status: "See notice at end of class."

	desciption: "Window where the user can choose from a list of options."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOICE_DIALOG

inherit
	EV_POPUP_WINDOW

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

	make_default (a_parent_window: EV_WINDOW; ctf: like callback)
			-- Make a choice window, and set a callback procedure.
		local
			vb: EV_VERTICAL_BOX
		do
			parent_window := a_parent_window
				-- Parent window may be Void.
			callback := ctf

			create list
			list.pointer_double_press_actions.extend (agent on_select)
			list.key_press_actions.extend (agent key_actions)

			create vb
			vb.set_padding (3)
			vb.extend (list)

			default_create
			extend (vb)

			enable_user_resize
			show_actions.extend (agent on_shown)
			list.hide_header

			create destroy_actions
		end

feature

	set_list (name_list: LIST [STRING_32]; pixmap_list: LIST [EV_PIXMAP])
			-- Fill the choice window with `name_list' using `pixmap_list' if applicable.
		require
			valid_args: name_list /= Void
			pixmap_list_valid: pixmap_list /= Void implies pixmap_list.count = name_list.count
		local
			lr: EV_GRID_LABEL_ITEM
			char_height: INTEGER
			l_width, l_height: INTEGER
		do
			list.wipe_out
			from
				name_list.start
			until
				name_list.after
			loop
				create lr
				if pixmap_list /= Void then
					lr.set_pixmap (pixmap_list [name_list.index])
				end
				lr.set_text (name_list.item)

				list.set_item (1, list.row_count + 1, lr)
				name_list.forth
			end
			list.column (1).resize_to_content
			char_height := (create {EV_FONT}).height + 1

			l_width := (list.column (1).width + list.vertical_scroll_bar.width).min (List_maximum_width)
			l_height := ((List_maximum_height).min (name_list.count * char_height + 40)).max (List_minimum_height)

			required_width := l_width + (width - client_width)
			required_height := l_height + (height - client_height)
		end

	execute (it: EV_GRID_ITEM)
			-- Recall the caller command.
		local
			p: INTEGER
		do
			p := it.row.index
			destroy_dialog
			if callback /= Void then
				callback.call ([p])
			end
		end

	select_item (i: INTEGER)
			-- Select item at the `i'-th position.
		do
			if i <= list.row_count and then i > 0 then
				list.row (i).enable_select
			end
		end

	on_shown
			-- The dialog is being displayed.
			-- Give the focus to the list.
		do
			list.set_focus
			list.enable_always_selected
			if list.row_count > 0 then
				list.row (1).enable_select
			end
			list.focus_out_actions.wipe_out
			list.focus_out_actions.extend (agent one_lost_focus)
			focus_out_actions.wipe_out
			focus_out_actions.extend (agent one_lost_focus)

			if not {PLATFORM}.is_windows then
					--| FIXME This is a workaround for gtk to make sure that the viewport holding the drawable
					--| is always resized as this is not the case in some scenarios.
					--| When the problem is resolved in EV_GRID/EV_VIEWPORT then this code should be removed.
				list.show_header
				list.hide_header
			end
		end

	destroy_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed after destroyed.

feature -- Access

	required_width: INTEGER

	required_height: INTEGER

feature {NONE} -- Properties

	list: ES_GRID

	callback: PROCEDURE [INTEGER]
			-- Command who calls `Current'
			-- Will be sent the position of
			-- the selected item.

feature {NONE} -- Implementation

	destroy_dialog
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
				if parent_window /= Void and then not parent_window.is_destroyed and then parent_window.is_displayed then
						-- This forces the window manager to refocus to the window that popped up `Current'.
					parent_window.show
				end
				parent_window := Void
			end
		end

	key_actions (k: EV_KEY)
			-- Call `execute' if k = Enter, `destroy_dialog' if k = Esc.
		do
			if k.code = {EV_KEY_CONSTANTS}.Key_enter then
				if list.selected_items /= Void then
					execute (list.selected_items.first)
				end
			elseif k.code = {EV_KEY_CONSTANTS}.Key_escape then
				destroy_dialog
			end
		end

	one_lost_focus
			-- One the widgets in `Current' lost the focus.
			-- If no widget has the focus, destroy `Current'.
		do
			if
				not list.has_focus and then
				not is_destroyed and then
				not has_focus
			then
				destroy_dialog
				destroy_actions.call ([])
			end
		end

	on_select (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- The user clicked on a list item.
		do
			if a_button = 1 and then list.selected_items /= Void then
				execute (list.selected_items.first)
			end
		end

	List_minimum_width: INTEGER = 70
	List_maximum_width: INTEGER = 400
	List_minimum_height: INTEGER = 50
	List_maximum_height: INTEGER = 400;
		-- Bounds for the displayed list.

feature {NONE} -- Implementation

	parent_window: EV_WINDOW;
		-- Window that `Current' is shown from.

invariant

	destroy_actions_not_void: destroy_actions /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class EB_CHOICE_DIALOG
