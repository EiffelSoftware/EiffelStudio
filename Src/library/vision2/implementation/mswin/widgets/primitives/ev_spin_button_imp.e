--| FIXME NOT_REVIEWED this file has not been reviewed
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
			on_scroll,
			interface,
			set_range,
			set_value,
			initialize
		end

	EV_TEXT_FIELD_IMP
		redefine
			make,
			wel_set_parent,
			move_and_resize,
			resize,
			--move,
			destroy,
			on_key_down,
			on_char,
			interface,
			initialize
		end

	WEL_UDS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a spin-button with 1 as minimum,
			-- 100 as maximum and `par' as parent.
		do
			base_make (an_interface)
			--create container.make (default_parent, "EV_SPIN_BUTTON")
			--wel_make (container, "", 0, 0, 0, 0, 0)
			--create up_down.make (container, 0, 0, 20, 0, 0)
			--up_down.set_buddy_window (Current)
			--up_down.set_range (0, 100)
			wel_make (Default_parent, "", 0, 0, 0, 0, 0)
		end

	initialize is
			--|FIXME
		do
			{EV_GAUGE_IMP} Precursor
			{EV_TEXT_FIELD_IMP} Precursor
		end

feature -- Access

	leap: INTEGER

	container: EV_INTERNAL_SILLY_CONTAINER_IMP
			-- A WEL control window to get both children. If we don't use
			-- an intermediate window, when we change the parent, nothing
			-- work anymore.

	up_down: EV_INTERNAL_UP_DOWN_CONTROL
			-- The up_down buttons.

	value: INTEGER is
			-- Current value
		do
			Result := up_down.position
		end

	step: INTEGER is
			-- Step of the scrolling
			-- ie : the user clicks on an arrow
		do
			Result := 1
		end

	minimum: INTEGER is
			-- Minimum value
		do
			Result := up_down.minimum
		end

	maximum: INTEGER is
			-- Maximum value
		do
			Result := up_down.maximum
		end

feature -- Status setting

	wel_set_leap (i :INTEGER) is do end
	wel_set_step (i :INTEGER) is do end
	wel_set_value (i :INTEGER) is do end
	wel_set_range (i, j: INTEGER) is do end


	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.remove_child (Current)
			end
			container.destroy
		end

feature -- Element change

	set_value (val: INTEGER) is
			-- Make `val' the new current value.
		do
			up_down.set_position (val)
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Make `min' the new minimum and `max' the new maximum.
		do
	--		up_down.set_range (min, max)
		end

feature -- Basic operation

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
				if not (val >= up_down.minimum and val <= up_down.maximum) then
					set_text (up_down.minimum.out)
				else
					up_down.set_position (val)
				end
			else
				set_text (up_down.minimum.out)
			end
		end

feature {NONE} -- WEL Implementation

	on_scroll (scroll_code, pos: INTEGER) is
			-- Do nothing here.
		do
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed)
			-- 13 is the number of the return key.
		do
			{EV_GAUGE_IMP} Precursor (virtual_key, key_data)
			if virtual_key = Vk_return then
				set_caret_position (0)
				translate_text

				interface.change_actions.call ([])

				--| This was the old imp.
				--execute_command (Cmd_activate, Void)
				--if exists then
				--	execute_command (Cmd_gauge, Void)
				--end
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

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- We must not resize the height of the tool-bar.
		do
			{EV_TEXT_FIELD_IMP} Precursor (0, 0, a_width - 20, a_height, repaint)
			up_down.move_and_resize (a_width - 20, 0, 20, a_height, repaint)
			container.move_and_resize (a_x, a_y, a_width, a_height, repaint)
		end

	resize (a_width, a_height: INTEGER) is
			-- We must not resize the hight of the tool-bar.
		do
			container.resize (a_width, a_height)
			{EV_TEXT_FIELD_IMP} Precursor (a_width, a_height)
			up_down.move_and_resize (a_width - 20, 0, 20, a_height, True)
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
			-- We resize the up-down control to avoid a display
			-- bug of windows.
		do
			container.move (a_x, a_y)
			up_down.invalidate
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Change the parent of the current window.
		do
			if a_parent /= Void then
				wel_parent := a_parent
				cwin_set_parent (container.item, a_parent.item)
			else
				wel_parent := Void
				cwin_set_parent (container.item, default_pointer)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_IMP

--|----------------------------------------------------------------
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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
