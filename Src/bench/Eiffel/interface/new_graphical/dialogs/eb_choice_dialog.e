indexing

	desciption: "Window where the user can make choice."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOICE_DIALOG

inherit

	EV_DIALOG

	EV_COMMAND
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		undefine
			default_create, copy
		end

creation

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
			list.pointer_button_release_actions.extend (~on_select)

			list.key_press_actions.extend (~key_actions)

			create exit_b.make_with_text_and_action (Interface_names.b_Cancel, ~destroy)

			create vb
			vb.set_padding (3)
			vb.set_border_width (2)
			vb.extend (list)
			vb.extend (exit_b)
			vb.disable_item_expand (exit_b)		

			default_create
			set_title ("Choice Window")

			extend (vb)
			set_default_push_button (exit_b)
			set_default_cancel_button (exit_b)

			exit_b.focus_out_actions.extend (~one_lost_focus)
			list.focus_out_actions.extend (~one_lost_focus)
			focus_out_actions.extend (~one_lost_focus)
		end

feature

	selected_name: STRING is
			-- Text of selected item in list of alternatives
		do
			Result := list.selected_item.first
		end

	set_list (name_list: LIST [STRING]) is
			-- Fill the choice window with `name_list'
		require
			valid_args: name_list /= Void
		local
			lr: EV_MULTI_COLUMN_LIST_ROW
			new_width: INTEGER
			char_width: INTEGER
			char_height: INTEGER
		do
				-- Default medium size of characters.
				-- font.maximum_width is too much, so we add 4 to the average width.
			char_width := (create {EV_FONT}).width + 4
			char_height := (create {EV_FONT}).height

			list.wipe_out
			from
				name_list.start
			until
				name_list.after
			loop
				create lr
				lr.extend (name_list.item)
				list.extend (lr)
				new_width := new_width.max (name_list.item.count)
				name_list.forth
			end
			list.resize_column_to_content (1)
--			if list.count >= 15 then
--				list.set_visible_item_count (15)
--			elseif list.count > 0 then
--				list.set_visible_item_count (list.count)
--			else
--				list.set_visible_item_count (1)
--			end

				-- We allow bounds for the list width of 70 and 150 pixels.
			list.set_minimum_width ((List_maximum_width.min (new_width * char_width + 10)).max (List_minimum_width))
				-- We allow bounds for the list height of 50 and 300 pixels.
			list.set_minimum_height (((List_maximum_height).min (name_list.count * char_height + 40)).max (List_minimum_height))
--			display
		end

--	update_position is
--		do
--			if shown then
--				display
--			end
--		end

	execute (it: EV_MULTI_COLUMN_LIST_ROW) is
			-- Recall the caller command.
		local
			p: INTEGER
		do
			p := list.index_of (it, 1)
			destroy
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

feature {NONE} -- Properties

feature {NONE} -- Properties

	list: EV_MULTI_COLUMN_LIST

	exit_b: EV_BUTTON	
			-- Exit button

	callback: PROCEDURE [ANY, TUPLE [INTEGER]]
			-- Command who calls `Current'
			-- Will be sent the position of
			-- the selected item.

feature {NONE} -- Implementation

	Key_csts: EV_KEY_CONSTANTS is
			-- Default key constants.
		once
			create Result
		end

	key_actions (k: EV_KEY) is
			-- Call `execute' if k = Enter, `destroy' if k = Esc.
		do
			if k.code = Key_csts.Key_enter then
				if list.selected_item /= Void then
					execute (list.selected_item)
				end
			elseif k.code = Key_csts.Key_escape then
				destroy
			end
		end

	one_lost_focus is
			-- One the widgets in `Current' lost the focus.
			-- If no widget has the focus, destroy `Current'.
		do
			if
				not exit_b.has_focus and then
				not list.has_focus and then
				not is_destroyed and then
				not has_focus
			then
				destroy
			end
		end

	on_select (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- The user clicked on a list item.
		do
			execute (list.selected_item)
		end

--	display is
--			-- Display the choice window in order to be seen 
--			-- on the screen.
--		local
--			x1, y1: INTEGER
--			a_widget: EV_WIDGET
--		do
--			if map_widget /= Void then
--				x1 := map_widget.real_x
--				y1 := map_widget.real_y
--			else
--				a_widget := parent
--              x1 := a_widget.real_x + (a_widget.width - width) // 2
--		y1 := a_widget.real_y + (height // 2)
--			end
--			set_x_y (x1, y1)
--			fd_popup
--			if real_x + width > screen.width then
--				set_x (screen.width - width)
--			elseif real_x < 0 then
--				set_x (0)
--			end
--			if real_y + height > screen.height then
--				set_y (screen.height - height)
--			elseif real_y < 0 then
--				set_y (0)
--			end
--		end

	List_minimum_width: INTEGER is 70
	List_maximum_width: INTEGER is 200
	List_minimum_height: INTEGER is 50
	List_maximum_height: INTEGER is 300
		-- Bounds for the displayed list.

invariant

--	list_exists: list /= Void

end -- class EB_CHOICE_DIALOG
