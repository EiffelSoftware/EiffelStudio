indexing
	description: "EiffelVision straight line."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STRAIGHT_LINE

inherit
	EV_LINE
		redefine
			make,
			recompute
		end

creation
	make


feature {NONE} -- Initialization

	make is
			-- Create current line.
		do
			init_fig (Void)
			{EV_LINE} Precursor 
			!! p1.make
			!! p2.make
			p2.set_x (1)
			surround_box.set_infinite
		end

feature -- Element change	

	set (o1, o2: like p1) is
			-- Set the two end points of the line.
		require else
			not o1.is_superimposable (o2)
		do
			p1 := o1
			p2 := o2
			set_modified
		end

	set_p2 (p: like p2) is
			-- Set the second point.
		require else
			not p1.is_superimposable (p)
		do
			p2 := p
			set_modified
		end

	set_p1 (p: like p1) is
			-- Set the first point.
		require else
			not p2.is_superimposable (p)
		do
			p1 := p
			set_modified
		end

feature -- Output

	draw is
			-- Draw the line.
		local
			lpath: EV_PATH
		do
			if drawing.is_drawable then
				create lpath.make
				lpath.get_drawing_attributes (drawing)
--				drawing.set_cap_style (CapProjecting)
				set_drawing_attributes (drawing)
				drawing.draw_straight_line (p1, p2)
				lpath.set_drawing_attributes (drawing)
			end
		end


feature -- Status report

	is_null: BOOLEAN is
			-- Is the line null ?
		do
			Result := False
		end

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the line superimposable to `other' ?
		do
			Result := 0 = ((p2.y-p1.y)*(other.p2.x-other.p1.x)-(p2.x-p1.x)*(other.p2.y-other.p1.y))
		end


feature {NONE} -- Access

	CapProjecting: INTEGER is 3
		-- Code to define projecting cap

feature {CONFIGURE_NOTIFY} -- Updating

	recompute is
		do
			surround_box.set_infinite
			unset_modified
		end

invariant
	not p1.is_superimposable (p2)

end -- class EV_STRAIGHT_LINE

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

