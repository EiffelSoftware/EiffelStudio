indexing

	description: 
		"Widget that is treated as a primitive (as a single widget) %
		%but is actually a composite throught its implementation. %
		%The `main_widget' is usually the manager class.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	PRIMITIVE_COMPOSITE_IMP

feature -- Access

	main_widget: MEL_WIDGET is
		deferred
		end;

feature -- Status report

	height: INTEGER is
			-- Height of widget
		do
			Result := main_widget.height
		end; 

	real_x: INTEGER is
			-- Vertical position relative to root window
		do
			Result := main_widget.real_x
		end; 

	real_y: INTEGER is
			-- Horizontal position relative to root window
		do
			Result := main_widget.real_y
		end; 

	realized: BOOLEAN is
			-- Is screen window realized?
		do
			Result := main_widget.realized
		end; 

	is_shown: BOOLEAN is
			-- Is current widget visible?
		do
			Result := main_widget.is_shown
		end; 

	width: INTEGER is
			-- Width of widget
		do
			Result := main_widget.width
		end; 

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := main_widget.x
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := main_widget.y
		end 

feature -- Status setting

	hide is
			-- Make widget invisible on the screen.
		do
			main_widget.hide
		end; 

	lower is
			-- lower current to the bottom of its
			-- peers stacking order
		do
			main_widget.lower
		end;

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event.
		do	
			main_widget.propagate_event
		end; 

	set_no_event_propagation is
			-- Don't propagate event to direct ancestor.
		do
			main_widget.set_no_event_propagation
		end;

	raise is
			--raise current to top of
			-- peer stacking order
		do	
			main_widget.raise
		end;

	realize is
			-- Create screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do	
			main_widget.realize
		end; 

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do	
			main_widget.set_height (new_height)
		end; 

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		do	
			main_widget.set_size (new_width, new_height)
		end; 

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		do	
			main_widget.set_width (new_width)
		end; 

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do	
			main_widget.set_x (x)
		end; 

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do	
			main_widget.set_x_y (new_x, new_y)
		end; 

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do	
			main_widget.set_y (new_y)
		end; 

	show is
			-- Make widget visible on the screen.
		do	
			main_widget.show
		end; 

	unrealize is
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do	
			main_widget.unrealize
		end; 

end -- class PRIMITIVE_COMPOSITE_IMP


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

