indexing
	description: "Eiffel Vision toggle button. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		undefine
			process_notification
		redefine
			interface,
			redraw_current_push_button,
			update_current_push_button,
			on_bn_clicked,
			has_pushed_appearence,
			initialize,
			internal_background_brush
		end
		
create
	make
	
feature {NONE} -- Initialization

	initialize is
			--
		do
			Precursor {EV_BUTTON_IMP}
			is_selected := False
		end
		
	
feature -- Access

	is_selected: BOOLEAN
		-- Is `Current' selected?

feature -- Status setting

	enable_select is
			-- Ensure `is_selected' is True.
		do
			is_selected := True
			select_actions.call ([])
			invalidate
		ensure then
			is_selected = True
		end

	disable_select is
			-- Ensure `is_selected' is False.
		do
			is_selected := False
			select_actions.call ([])
			invalidate
		ensure then
			is_selected = False
		end

feature {NONE} -- Implementation, focus event

	has_pushed_appearence (state: INTEGER): BOOLEAN is
			-- Should `Current' have the appearence of being
			-- pressed?
			-- As `Current' is a toggle, button, it must be displayed as
			-- pushed when `is_selected', or if `state' has `button_in' enabled.
		do
			Result := Precursor {EV_BUTTON_IMP} (state)
			if not Result then
				Result := is_selected
			end
		end

	on_bn_clicked is
			-- Bn_clicked message received from Windows,
			-- so toggle `is_selected', redraw `Current' and
			-- fire `select_actions'.
		do
			is_selected := not is_selected
			invalidate
			select_actions.call ([])
		ensure then
			state_changed: old is_selected = not is_selected
		end
		
	on_bn_double_clicked is
			-- Bn_clicked message received from Windows,
			-- so toggle `is_selected', redraw `Current' and
			-- fire `select_actions'.
		do
			is_selected := not is_selected
			invalidate
			select_actions.call ([])
		ensure
			state_changed: old is_selected = not is_selected
		end
		
	process_notification (notification_code: INTEGER) is
			-- Process any windows notification messages.
			-- In this case, it is redefined to handle
			-- BN_doubleclick.
		do
			if notification_code = Bn_doubleclicked then
				on_bn_double_clicked
			else
				Precursor {EV_BUTTON_IMP} (notification_code)
			end
		end

	update_current_push_button is
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
		local
			top_level_dialog_imp: EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the current push button and
			-- remove any bold border to the other buttons.
		do
		end

 	internal_background_brush: WEL_BRUSH is
 			-- `Result' is brush used for redrawing background of `Current'.
 		do
 			if not is_selected then
 				Result := Precursor {EV_BUTTON_IMP}
 			else
	 			Result := splitter_brush
	 		end
	 	ensure then
	 		Result_not_void: Result /= Void
 		end

 	splitter_brush: WEL_BRUSH is
			-- Create the brush used to draw the invert splitter.
		local
			a_bitmap: WEL_BITMAP
			string_bitmap: STRING
			i: INTEGER
		do
				-- We create a bitmap 8x8 which follows the pattern:
				-- black / white / black... on one line
				-- and white / black / white... on the other.
				-- The hexa number 0xAA correspond to the first line
				-- and the 0x55 to the other line. Since Windows expects
				-- value aligned on DWORD, we have gap in our strings.

				-- Creating data of bitmaps
			create string_bitmap.make (16)
			string_bitmap.fill_blank
			from
				i := 1
			until
				i > 16
			loop	
				string_bitmap.put ((0x000000AA).to_character, i)
				string_bitmap.put ((0x00000055).to_character, i + 2)
				i := i + 4
			end

				-- Then, we create the brush
			create a_bitmap.make_direct (8, 8, 1, 1, string_bitmap)
			create Result.make_by_pattern (a_bitmap)
			
			a_bitmap.delete
		end
 		

feature {EV_ANY_I} -- Implementation

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

