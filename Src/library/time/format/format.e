indexing
	description: "Generic formatter";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	FORMAT [G] 

feature -- Access

	fill_character: CHARACTER;
			-- Padding character.

	width: INTEGER;
			-- Width of the field.

feature -- Status report

	centered: BOOLEAN is
			-- Are strings to be formatted centered?
		do
			Result := justification = Center_justification
		ensure
			center_set: Result = (justification = Center_justification)
		end

	left_justified: BOOLEAN is
			-- Are strings to be formatted with spaces on the right?
		do
			Result := justification = Left_justification
		ensure
			left_set: Result = (justification = Left_justification)
		end

	right_justified: BOOLEAN is
			-- Are strings to be formatted with spaces on the left?
		do
			Result := justification = Right_justification
		ensure
			right_set: Result = (justification = Right_justification)
		end

	not_justified: BOOLEAN is
			-- Are strings to be formatted in smallest string possible
		do
			Result := justification = No_justification
		ensure
			not_set: Result = (justification = No_justification)
		end

feature -- Status setting

	left_justify is
			-- Put padding on right.
		do
			justification := Left_justification
		ensure
			left_justified_set: left_justified
		end

	center_justify is
			-- Put padding on right and left.
		do
			justification := Center_justification
		ensure
			centered_set: centered
		end

	right_justify is
			-- Put padding on left.
		do
			justification := Right_justification
		ensure
			right_justified_set: right_justified
		end

	no_justify is
			-- Always return the smallest string possible.
		do
			justification := No_justification
		ensure
			not_justified_set: not_justified
		end

feature -- Element change

	blank_fill is
			-- Fill numbers with blanks.
		do
			fill_character := ' '
		ensure
			blank_character_set: fill_character = ' '
		end

	set_fill (c: CHARACTER) is
			-- Fill numbers with `c'.
		do
			fill_character := c
		ensure
			fill_character_set: fill_character = c
		end

	set_width (w: INTEGER) is
			-- Set width to `w'.
		require
			wide_enough: w >= 1
		do
			width := w
		ensure
			width_set: width = w
		end

feature -- Conversion

	formatted (g: G): STRING is
			-- Formatted string `g'
		require
			g_exists: g /= Void
		deferred		 
		ensure
			result_exists: Result /= Void
		end

	justify (s: STRING): STRING is
			-- String `s' justified with current parameters
		require
			width_large_enough: width >= s.count
		local
			l, r: STRING;
			i, t: INTEGER
		do
			Result := Clone (s);
			if not centered then
				-- be concerned about filling
				!! l.make (width - s.count);
				from
					i := 1
				until
					i > l.capacity
				loop
					l.extend (fill_character);
					i := i + 1
				end;
				if left_justified then
					Result.append (l)
				else
					Result.prepend (l)
				end
			else
					-- centered
					-- add spaces both sides, more on left than right though
					-- when there is a choice
				t := (width - s.count) // 2;
				if (2 * t + s.count < width) then
					!! l.make (t +1)
				else
					!! l.make (t)
				end;
				!! r.make (t);
				from
					i := 1
				until
					i > r.capacity
				loop
					l.extend (fill_character);
					r.extend (fill_character);
					i := i + 1
				end;
				if i = l.capacity then l.extend (fill_character) end;
				Result.prepend (l);
				Result.append (r)
			end
		end;

feature -- Implementation

	justification: INTEGER;

	No_justification: INTEGER is 0;

	Left_justification: INTEGER is 1;

	Center_justification: INTEGER is 2;

	Right_justification: INTEGER is 3

invariant
	justification_validity: no_justification <= justification and justification <= right_justification

end -- class FORMAT


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
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

