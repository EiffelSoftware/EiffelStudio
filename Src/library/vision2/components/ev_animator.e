indexing
	description:
		"Sequence of pixmaps displayed cyclically."
	status: "See notice at end of class"
	keywords: "animate, animated, movie"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_ANIMATOR

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			initialize
		end

	INTERACTIVE_LIST [EV_PIXMAP]
		undefine
			default_create
		end

create
	default_create,
	make_with_interval,
	make_for_test

feature -- Initialization

	make_with_interval (an_interval: INTEGER) is
			-- Create with `an_interval' in milliseconds.
		require
			an_interval_not_negative: an_interval >= 0
		do
			default_create
			set_interval (an_interval)
		end

feature -- Status report

	interval: INTEGER is
			-- Time between cells in milliseconds.
		do
			Result := timer.interval
		ensure
			delegate_ok: Result = timer.interval
		end

feature -- Status setting

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' to `interval'. 
		require
			an_interval_not_negative: an_interval >= 0
		do
			timer.set_interval (an_interval)
		ensure
			interval_assigned: interval = an_interval
		end

feature {NONE} -- Implementation

	on_item_added (an_item: EV_PIXMAP) is
			-- Resize if necessary.
		do
			if an_item.width > da.minimum_width then
				da.set_minimum_width (an_item.width)
			end
			if an_item.height > da.minimum_height then
				da.set_minimum_height (an_item.height)
			end
		end

	on_item_removed (an_item: EV_PIXMAP) is
			-- Do nothing.
		do
		end

	da: EV_DRAWING_AREA

	timer: EV_TIMEOUT

	flip is
			-- Display the next cell.
		local
			p: EV_PIXMAP
		do
			if not empty then
				if after then
					start
				end
				da.draw_pixmap (0, 0, item)
				forth
			end
		end

	initialize is
			-- Create drawing area, cell list and timer.
		do
			make
			{EV_PRIMITIVE} Precursor
			create timer
			timer.actions.extend (~flip)
			create da
			implementation.box.extend (da)
		end
		
	implementation: EV_AGGREGATE_WIDGET_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_AGGREGATE_WIDGET_IMP} implementation.make (Current)
		end

end -- class EV_ANIMATOR

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/06/07 17:27:26  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.1  2000/05/09 18:22:07  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
 
