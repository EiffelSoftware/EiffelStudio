indexing
	description:
		" EiffelVision spin button, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		undefine
			set_default_colors
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			set_default_colors,
			set_default_minimum_size,
			destroy
		redefine
			on_key_down,
			interface,
			initialize
		end

	EV_TEXT_FIELD_IMP
		redefine
			make,
			wel_set_parent,
			wel_move_and_resize,
			wel_resize,
			destroy,
			on_key_down,
			on_char,
			interface,
			initialize,
			on_en_change
		end

	WEL_UDS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with `an_interface'.
		do
			base_make (an_interface)
			create container.make (default_parent, "EV_SPIN_BUTTON")
			wel_make (container, "", 0, 0, 0, 0, 0)
		end

	initialize is
			-- Initialize `Current'.
		do
			create internal_arrows_control.make (container, 0, 0, 20, 0, 0)
			internal_arrows_control.set_buddy_window (Current)
			{EV_GAUGE_IMP} Precursor
			{EV_TEXT_FIELD_IMP} Precursor
			last_value := 0
		end

feature {EV_ANY_I} -- Access

	leap: INTEGER
		-- Size of leap. Default: 10.

	container: EV_INTERNAL_SILLY_CONTAINER_IMP
			-- A WEL control window used as a parent for
			-- `Current' and `internal_arrows_control'. 

	internal_arrows_control: EV_INTERNAL_UP_DOWN_CONTROL
			-- The Windows up down control used internally.

	value: INTEGER is 
			-- Current value.
		do
			Result := internal_arrows_control.position
		end

	step: INTEGER
			-- Step of the scrolling

	minimum: INTEGER is
			-- Minimum value.
		do
			Result := internal_arrows_control.minimum
		end

	maximum: INTEGER is
			-- Maximum value.
		do
			Result := internal_arrows_control.maximum
		end

feature {EV_SPIN_BUTTON_I}-- Status setting

	wel_set_leap (i :INTEGER) is
			-- Assign `i' to leap.
		do
			leap := i
		end
		
	wel_set_step (i :INTEGER) is
			-- Assign `i' to step.
		do
			step := i
		end

	wel_set_value (i :INTEGER) is
			-- Assign `i`' to `value'. 
		do
			internal_arrows_control.set_position (i)
				-- We must now store the value
			last_value := i
			manually_updating := True
		end

	wel_set_range (i, j: INTEGER) is
			-- 
		local
			bounds: INTEGER_INTERVAL
		do
			create bounds.make (i, j)
			internal_arrows_control.set_range (bounds.lower, bounds.upper)
		end

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.remove_child (Current)
			end
			container.destroy
		end

feature {NONE} -- WEL Implementation

	translate_text is
			-- Take a string and translate it to the corresponding
			-- integer value. If it is not in the range or if it
			-- not an integer value, it returns the minimum of the
			-- range.
		local
			txt: STRING
			val: INTEGER
		do
			txt := text
			if txt.is_integer then
				val := txt.to_integer
				if val < internal_arrows_control.minimum then
					set_text (internal_arrows_control.minimum.out)
				elseif val > internal_arrows_control.maximum then
					set_text (internal_arrows_control.maximum.out)
				else
					internal_arrows_control.set_position (val)
				end
			else
				set_text (internal_arrows_control.minimum.out)
			end
		end

	on_en_change is	
			-- Contents of `Current' changed.
			--| This is redefined as the step used by windows is always one.
			--| Using `manually_updating', we monitor whether the value
			--| Changed due to cklicking `internal_arrows_control'. If step
			--| is greater than One and not manually updating then adjust
			--| `value' by remaining step.
		do
		if step > 1 then
		if not manually_updating then
			manually_updating := True
			if last_value < value then
				if value + step - 1 <= maximum then
					set_value (value + step - 1)
				else
					set_value (maximum)
				end
			elseif last_value > value then
				if value - step + 1 >= minimum then
					set_value (value - step + 1)
				else
					set_value (minimum)
				end
			end
			last_value := value
		else
			manually_updating := False
		end
		end
		end

	last_value: INTEGER
		-- Holds the last `value'.

	manually_updating: BOOLEAN
		-- Are we updating the control to move the rest of the step?
	

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed
		do
			manually_updating := True
			{EV_GAUGE_IMP} Precursor (virtual_key, key_data)
			if virtual_key = Vk_return then
				manually_updating := False
				set_caret_position (1)
				translate_text
				interface.return_actions.call ([])
				interface.change_actions.call ([])
			end
		end	

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `bip' when the user
			-- tab to another control.
		do
			if not has_focus then
				disable_default_processing
			end
		end

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
	repaint: BOOLEAN) is
			-- Move and resize `Current' and `internal_arrows_control'.
		do
			{EV_TEXT_FIELD_IMP} Precursor (0, 0, a_width - 20, a_height,
			repaint)
			internal_arrows_control.move_and_resize (a_width - 20, 0, 20,
			a_height, repaint)
			container.move_and_resize (a_x, a_y, a_width, a_height, repaint)
		end

	wel_resize (a_width, a_height: INTEGER) is
			-- Resize `Current' and `internal_arrows_control'.
		do
			container.resize (a_width, a_height)
			{EV_TEXT_FIELD_IMP} Precursor (a_width, a_height)
			internal_arrows_control.move_and_resize (a_width - 20, 0, 20,
			a_height, True)
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
			-- We resize the up-down control to avoid a display
			-- bug of windows.
		do
			container.move (a_x, a_y)
			internal_arrows_control.invalidate
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Change the parent of the current window.
		do
			if a_parent /= Void then
				wel_window_parent := a_parent
				cwin_set_parent (container.item, a_parent.item)
			else
				wel_window_parent := Void
				cwin_set_parent (container.item, default_pointer)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2000/04/19 19:06:47  rogers
--| Manually updating is now set to true in wel_set_value. Fixes
--| bug where setting the value would set the value to step - 1
--| higher than required.
--|
--| Revision 1.9  2000/04/19 18:42:03  rogers
--| Improved comments and formatting.Renamed up_down to
--| internal_arrows_control. Altered the export status of some
--| features. Redefined on_enchange from EV_TEXT_FIELD_IMP. Added
--| last_value and manually_updating.
--|
--| Revision 1.8  2000/04/18 17:17:10  rogers
--| Fixed both make and initialize. Implemented wel_Set_leap,
--| wel_set_range and wel_Set value. Changed wel_parent references
--| in wel_Set_parent to wel_window_parent.
--|
--| Revision 1.7  2000/03/23 18:41:33  brendel
--| resize -> wel_resize
--| move_and_resize -> wel_move_and_resize
--|
--| Revision 1.6  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.5  2000/02/19 04:33:56  oconnor
--| added deferred features
--|
--| Revision 1.4  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.3.10.3  2000/02/01 03:37:22  brendel
--| Revised. Still needs implementing.
--|
--| Revision 1.3.10.2  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.1  1999/11/24 17:30:34  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
