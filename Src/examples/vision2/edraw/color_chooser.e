note
	description: "Objects that lets user select a color."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_CHOOSER

inherit
	EV_FRAME
		redefine
			make_with_text,
			create_interface_objects
		end

create
	make_with_text

feature {NONE} -- Initialization

	create_interface_objects
		do
			create color_change_actions
			create button_list.make (10)
			create last_choosen_color
		end

	make_with_text (a_text: STRING)
			-- create a COLOR_CHOOSER showing `a_text' on the frame.
		local
			v_box: EV_VERTICAL_BOX
			table: EV_TABLE
			button: EV_TOGGLE_BUTTON
			choose: EV_BUTTON
			pixmap: EV_PIXMAP
			i: INTEGER
		do
			Precursor {EV_FRAME} (a_text)

			create v_box

				create table

					table.resize (3, 4)

					from
						i := 1
					until
						i > 8
					loop
						create button

							if attached get_color (i) as l_color then
								button.set_background_color (l_color)
							end
							button.set_minimum_size (button_size, button_size)
							button.select_actions.extend (agent on_button_select (i))

						table.add (button, ((i-1) \\ 3) + 1, ((i - 1) // 3)  + 1, 1, 1)
						button_list.extend (button)

						i := i + 1

					end

					create button
						create pixmap.make_with_size (button_size, button_size)
						pixmap.set_with_named_file ("nocolor.png")
						button.set_pixmap (pixmap)
						button.enable_select
						button.select_actions.extend (agent on_button_select (9))
					table.add (button, 3, 3, 1, 1)
					button_list.extend (button)

					create button
						create pixmap.make_with_size (button_size, button_size)
						pixmap.set_with_named_file ("nocolor.png")
						button.set_pixmap (pixmap)
						button.set_minimum_size (button_size, button_size)
						button.select_actions.extend (agent on_button_select (10))
					table.add (button, 1, 4, 1, 1)
					button_list.extend (button)

				v_box.extend (table)

				create choose.make_with_text ("Select...")
				choose.select_actions.extend (agent choose_color)

				v_box.extend (choose)

			extend (v_box)

			none_color_selectable := True
		end

feature -- Access

	color: detachable EV_COLOR
			-- The selected color
			-- Default: Void (no color)

	color_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when a color was selected.

feature -- Element change

	set_color (a_color: EV_COLOR)
			-- Set `color' to `a_color'
		do
			color := a_color

			last_choosen_color := a_color

			button_list.last.remove_pixmap
			button_list.last.set_background_color (a_color)
			button_list.last.enable_select
		ensure
			set: color = a_color
		end

feature -- Status

	none_color_selectable: BOOLEAN
			-- can the user select no color (`color' = Void)
			-- Default: True

feature -- Status settings

	disable_none_color_selectable
			-- Set `none_color_selectable' to `False'.
		do
			none_color_selectable := False
			button_list.i_th (9).disable_sensitive
		ensure
			set: none_color_selectable = False
		end

	enable_none_color_selectable
			-- Set `none_color_selectable' to `True'.
		do
			none_color_selectable := True
			button_list.i_th (9).enable_sensitive
		ensure
			set: none_color_selectable
		end

feature {NONE} -- Implementation

	choose_color
			-- choose button was clicked
		local
			dialog: EV_COLOR_DIALOG
		do
			create dialog
			dialog.show_modal_to_window (top_window)

			set_color (dialog.color)
		end

	top_window: EV_WINDOW
			-- The applications window `Current' is part of.
		local
			cursor: detachable EV_CONTAINER
			l_result: detachable EV_WINDOW
		do
			from
				cursor := parent
			invariant
				cursor /= Void
			until
				attached {EV_WINDOW} cursor
			loop
				check cursor /= Void end
				cursor := cursor.parent
			end
			l_result ?= cursor
			check l_result /= Void end
			Result := l_result
		end

	button_list: ARRAYED_LIST [EV_TOGGLE_BUTTON]
			-- All the toggle buttons

	button_size: INTEGER = 20
			-- The size of the colored pixmaps on the buttons

	on_button_select (button_nr: INTEGER)
			-- Button with `button_nr' in `button_list' was selected.
		local
			i: INTEGER
		do
			if button_list.i_th (button_nr).is_selected then
				from
					button_list.start
					i := 1
				until
					button_list.after
				loop
					if i /= button_nr then
						button_list.item.select_actions.block
						button_list.item.disable_select
						button_list.item.select_actions.resume
					end
					button_list.forth
					i := i + 1
				end
				color := get_color (button_nr)
				color_change_actions.call (Void)
			end
		end

	get_color (nr: INTEGER): detachable EV_COLOR
			-- Return color for button with number `nr'.
		require
			nr_valid: nr > 0 and nr <= 10
		do
			inspect nr
			when 1 then
				create Result.make_with_8_bit_rgb (255, 0, 0)
			when 2 then
				create Result.make_with_8_bit_rgb (0, 255, 0)
			when 3 then
				create Result.make_with_8_bit_rgb (0, 0, 255)
			when 4 then
				create Result.make_with_8_bit_rgb (255, 255, 0)
			when 5 then
				create Result.make_with_8_bit_rgb (255, 0, 255)
			when 6 then
				create Result.make_with_8_bit_rgb (0, 255, 255)
			when 7 then
				create Result.make_with_8_bit_rgb (255, 255, 255)
			when 8 then
				create Result.make_with_8_bit_rgb (0, 0, 0)
			when 9 then
				check none_color_selectable: none_color_selectable end
				Result := Void
			when 10 then
				Result := last_choosen_color
			end
		end

	last_choosen_color: EV_COLOR;
			-- Last color selected over color dialog by user.

invariant
	button_list_proper_count: button_list.count = 10

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class COLOR_CHOOSER
