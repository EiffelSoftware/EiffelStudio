indexing

	description: "Description of infinited lines (implementation for X)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	INF_LINE 

inherit

	LINE
		rename
			make as line_make
		redefine
			conf_recompute
		end

creation

	make


feature -- Initialization 

	make  is
			-- Create current line.
		do
			init_fig (Void);
			line_make ;
			!! p1;
			!! p2;
			p2.set_x (1);
			surround_box.set_infinite
		end;

feature -- Element change	

	set (o1, o2: like p1) is
			-- Set the two end points of the line.
		require else
			not o1.is_superimposable (o2)
		do
			p1 := o1;
			p2 := o2;
			set_conf_modified
		end;

	set_p2 (p: like p2) is
			-- Set the second point.
		require else
			not p1.is_superimposable (p)
		do
			p2 := p;
			set_conf_modified
		end;

	set_p1 (p: like p1) is
			-- Set the first point.
		require else
			not p2.is_superimposable (p)
		do
			p1 := p;
			set_conf_modified
		end;

feature -- Output

	draw is
			-- Draw the line.
		do
			if drawing.is_drawable then
				drawing.set_cap_style (CapProjecting);
				set_drawing_attributes (drawing);
				drawing.draw_inf_line (p1, p2)
			end
		end;


feature -- Status report

	is_null: BOOLEAN is
			-- Is the line null ?
		do
			Result := false
		end;

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the line superimposable to `other' ?
		do
			Result := 0 = ((p2.y-p1.y)*(other.p2.x-other.p1.x)-(p2.x-p1.x)*(other.p2.y-other.p1.y))
		end;


feature {NONE} -- Access

	CapProjecting: INTEGER is 3;
		-- Code to define projecting cap

feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute is
		do
			surround_box.set_infinite;
			unset_conf_modified
		end;

invariant

	not p1.is_superimposable (p2)

end -- class INF_LINE



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

