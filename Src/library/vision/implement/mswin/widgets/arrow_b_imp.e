indexing
	
	description: "This class represents a MS_IMParrow button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ARROW_B_IMP

inherit
	ARROW_B_I

	OWNER_DRAW_BUTTON_WINDOWS

creation
	make

feature -- Initialization

	make (an_arrow_button: ARROW_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make an arrow button.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			identifier := an_arrow_button.identifier
			managed := man
			an_arrow_button.set_font_imp (Current)
			set_up
		end

feature -- Status report

	center_alignment: BOOLEAN
			-- Is this ARROW_B currently center_aligned?	

	down: BOOLEAN is
			-- Is current direction down?
		do
			Result := (direction = down_direction)
		end

	left: BOOLEAN is
			-- Is current direction left?
		do
			Result := (direction = left_direction)
		end

	right: BOOLEAN is
			-- Is current direction right?
		do
			Result := (direction = right_direction)
		end

	up: BOOLEAN is
			-- Is current direction up?
		do
			Result := (direction = up_direction)
		end

feature -- Status setting

	set_down is
			-- Set current direction to down.
		do
			direction := down_direction
			if exists then
				invalidate
			end
		end

	set_left is
			-- Set current direction to left.
		do
			direction := left_direction
			if exists then
				invalidate
			end
		end

	set_right is
			-- Set current direction to right.
		do
			direction := right_direction
			if exists then
				invalidate
			end
		end

	set_up is
			-- Set current direction to up.
		do
			direction := up_direction
			if exists then
				invalidate
			end
		end

feature {NONE} -- Implementation

	draw_selected (a_dc: WEL_DC) is
			-- Draw current button in a selected mode.
		local
			old_brush, new_brush: WEL_BRUSH
		do
			old_brush := a_dc.brush
			!! new_brush.make_solid (wel_foreground_color)
			a_dc.select_brush (new_brush)			
			a_dc.polygon (triangle (True))
			if old_brush /= Void then
				a_dc.select_brush (old_brush)
			end
		end

	draw_unselected (a_dc: WEL_DC) is
			-- Draw current button in an unselected mode.
		local
			old_brush, new_brush: WEL_BRUSH
		do
			old_brush := a_dc.brush
			!! new_brush.make_solid (wel_foreground_color)
			a_dc.select_brush (new_brush)
			a_dc.polygon (triangle(False))
			if old_brush /= Void then
				a_dc.select_brush (old_brush)
			end
		end

	triangle (button_is_down: BOOLEAN): ARRAY [INTEGER] is
			-- Triangle for current arrow button
		local
			r: WEL_RECT
		do
			r := client_rect
			if button_is_down then
				r.set_left (r.left + 6)
				r.set_top (r.top + 6)
				r.set_right ((r.right - 4).max (r.left))
				r.set_bottom ((r.bottom - 4).max (r.top))
			else
				r.set_left (r.left + 4)
				r.set_top (r.top + 4)
				r.set_right ((r.right - 6).max (r.left))
				r.set_bottom ((r.bottom - 6).max (r.top))
			end
			!! Result.make (1, 8)
			Result.put (r.left ,1)
			Result.put (r.left ,7)
			if down  then
				Result.put (r.top ,2)
				Result.put (r.right ,3)
				Result.put (r.top ,4)
				Result.put ((r.left + r.right) // 2 ,5)
				Result.put (r.bottom ,6)
			elseif left then
				Result.put ((r.top+r.bottom) // 2 ,2)
				Result.put (r.right ,3)
				Result.put (r.top ,4)
				Result.put (r.right ,5)
				Result.put (r.bottom ,6)
			elseif right then
				Result.put (r.top ,2)
				Result.put (r.left ,3)
				Result.put (r.bottom ,4)
				Result.put (r.right ,5)
				Result.put ((r.top + r.bottom) // 2 ,6)
			else
				Result.put (r.bottom ,2)
				Result.put (r.right ,3)
				Result.put (r.bottom ,4)
				Result.put ((r.left + r.right) // 2 ,5)
				Result.put (r.top ,6)
			end
			Result.put (Result @ 2, 8)
		ensure
			result_not_void: Result /= Void
		end

	identifier: STRING
                        -- Identifier of current arrow button

	direction: INTEGER
			-- Direction of current arrow button

	up_direction: INTEGER is unique
			-- Up direction value

	down_direction: INTEGER is unique
			-- Down direction value

	left_direction: INTEGER is unique
			-- Left direction value

	right_direction: INTEGER is unique
			-- Right direction value

invariant

        valid_direction: up xor (down xor (right xor left))

end -- class ARROW_B_IMP
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

