indexing
	description:
		"A position in a 2 dimensional space as INTEGERs (x, y)"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COORDINATE

inherit
	DEBUG_OUTPUT

create
	default_create,
	set,
	make,
	make_with_position,
	make_precise
	
feature -- Initialization

	make, set, make_with_position, set_position (a_x: like x; a_y: like y) is
			-- Create an EV_COORDINATE at position (`a_x', `a_y').
		do
			x_precise := a_x
			y_precise := a_y
		ensure
			x_set: x = a_x
			y_set: y = a_y
		end
		
	make_precise, set_precise (a_x: like x_precise; a_y: like y_precise) is
			-- Create an EV_COORDINATE at position (`a_x', `a_y')
		do
			x_precise := a_x
			y_precise := a_y
		ensure
			x_set: x_precise = a_x
			y_set: y_precise = a_y			
		end
		

feature -- Access

	x, x_abs: INTEGER is
			-- Horizontal position.
		do
			if x_precise > 0.0 then
				Result := (x_precise + 0.5).truncated_to_integer
			else
				Result := (x_precise - 0.5).truncated_to_integer
			end
		end
			
	y, y_abs: INTEGER is
			-- Vertical position.
		do
			if y_precise > 0.0 then
				Result := (y_precise + 0.5).truncated_to_integer
			else
				Result := (y_precise - 0.5).truncated_to_integer
			end
		end
			
	x_precise: DOUBLE
			-- The precise horizontal position.
	
	y_precise: DOUBLE
			-- The precise vertival position.

feature -- Element change

	set_x (a_x: like x) is
			-- Assign `a_x' to `x'.
		do
			x_precise := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: like y) is
			-- Assign `a_y' to `y'.
		do
			y_precise := a_y
		ensure
			y_set: y = a_y
		end
		
	set_x_precise (a_x: like x_precise) is
			-- Assign `a_x' to `x'.
		do
			x_precise := a_x
		ensure
			x_set: x_precise = a_x
		end

	set_y_precise (a_y: like y_precise) is
			-- Assign `a_y' to `y'.
		do
			y_precise := a_y
		ensure
			y_set: y_precise = a_y
		end
		
feature -- Output

	debug_output: STRING is
			-- Textual representation.
		do
			Result := "(" + x.out + ", " + y.out + ")"
		end

end -- class EV_COORDINATES

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

