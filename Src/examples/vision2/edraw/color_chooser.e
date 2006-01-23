indexing
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
			make_with_text
		end
	
create
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
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
					
					create button_array.make (1, 10)
					
					from
						i := 1
					until
						i > 8
					loop
						create button

							button.set_background_color (get_color (i))
							button.set_minimum_size (button_size, button_size)
							button.select_actions.extend (agent on_button_select (i))
							
						table.add (button, ((i-1) \\ 3) + 1, ((i - 1) // 3)  + 1, 1, 1)
						button_array.put (button, i)
						
						i := i + 1
							
					end
					
					create button
						create pixmap.make_with_size (button_size, button_size)
						pixmap.set_with_named_file ("nocolor.png")
						button.set_pixmap (pixmap)
						button.enable_select
						button.select_actions.extend (agent on_button_select (9))
					table.add (button, 3, 3, 1, 1)
					button_array.put (button, 9)
					
					create button			
						create pixmap.make_with_size (button_size, button_size)
						pixmap.set_with_named_file ("nocolor.png")
						button.set_pixmap (pixmap)
						button.set_minimum_size (button_size, button_size)
						button.select_actions.extend (agent on_button_select (10))
					table.add (button, 1, 4, 1, 1)
					button_array.put (button, 10)
				
				v_box.extend (table)
				
				create choose.make_with_text ("Select...")
				choose.select_actions.extend (agent choose_color)
				
				v_box.extend (choose)
			
			extend (v_box)
			
			create color_change_actions
			
			none_color_selectable := True
		end
		
feature -- Access

	color: EV_COLOR
			-- The selected color
			-- Default: Void (no color)
			
	color_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when a color was selected.
		
feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Set `color' to `a_color'
		do
			color := a_color

			last_choosen_color := a_color
			
			button_array.item (10).remove_pixmap
			button_array.item (10).set_background_color (a_color)
			button_array.item (10).enable_select
		ensure
			set: color = a_color
		end
		
feature -- Status

	none_color_selectable: BOOLEAN
			-- can the user select no color (`color' = Void)
			-- Default: True
			
feature -- Status settings

	disable_none_color_selectable is
			-- Set `none_color_selectable' to `False'.
		do
			none_color_selectable := False
			button_array.item (9).disable_sensitive
		ensure
			set: none_color_selectable = False
		end
		
	enable_none_color_selectable is
			-- Set `none_color_selectable' to `True'.
		do
			none_color_selectable := True
			button_array.item (9).enable_sensitive
		ensure
			set: none_color_selectable
		end
	
feature {NONE} -- Implementation

	choose_color is
			-- choose button was clicked
		local
			dialog: EV_COLOR_DIALOG
		do
			create dialog
			dialog.show_modal_to_window (top_window)
			
			set_color (dialog.color)
		end

	top_window: EV_WINDOW is
			-- The applications window `Current' is part of.
		local
			cur: EV_CONTAINER
		do
			cur := parent
			Result ?= cur
			from
			until
				Result /= Void
			loop
				cur := cur.parent
				Result ?= cur
			end
		end
			
	button_array: ARRAY [EV_TOGGLE_BUTTON]
			-- All the toggle buttons
	
	button_size: INTEGER is 20
			-- The size of the colored pixmaps on the buttons
			
	on_button_select (button_nr: INTEGER) is
			-- Button with `button_nr' in `button_array' was selected.
		local
			i: INTEGER
		do
			if button_array.item (button_nr).is_selected then
				from
					i := button_array.lower
				until
					i > button_array.upper
				loop
					if i /= button_nr then
						button_array.item (i).select_actions.block
						button_array.item (i).disable_select
						button_array.item (i).select_actions.resume
					end
					i := i + 1
				end
				color := get_color (button_nr)
				color_change_actions.call (Void)
			end
		end
		
	get_color (nr: INTEGER): EV_COLOR is
			-- Return color for button with number `nr'.
		require
			nr_valid: nr > 0 and nr <= 10
		do
			if nr = 1 then
				create Result.make_with_8_bit_rgb (255, 0, 0)
			elseif nr = 2 then
				create Result.make_with_8_bit_rgb (0, 255, 0)
			elseif nr = 3 then
				create Result.make_with_8_bit_rgb (0, 0, 255)
			elseif nr = 4 then
				create Result.make_with_8_bit_rgb (255, 255, 0)
			elseif nr = 5 then
				create Result.make_with_8_bit_rgb (255, 0, 255)
			elseif nr = 6 then
				create Result.make_with_8_bit_rgb (0, 255, 255)
			elseif nr = 7 then
				create Result.make_with_8_bit_rgb (255, 255, 255)
			elseif nr = 8 then
				create Result.make_with_8_bit_rgb (0, 0, 0)
			elseif nr = 10 then
				Result := last_choosen_color
			end
		end

	last_choosen_color: EV_COLOR;
			-- Last color selected over color dialog by user.

indexing
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
