indexing
	description: 
		"Eiffel Vision aggregate widget. WEL implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_AGGREGATE_WIDGET_IMP
	
inherit
	EV_AGGREGATE_WIDGET_I
		redefine
			interface
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			create {EV_AGGREGATE_BOX} box
			--| FIXME need to arrange for `box' to appear in current.
			check
				not_implemented: false
			end
		end

	cell: EV_CELL

feature -- 

	enable_transport is
            -- Activate pick/drag and drop mechanism.
		do
			cell.implementation.enable_transport
		end
	
	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			cell.implementation.disable_transport
		end

	start_transport (
        a_x, a_y, a_button: INTEGER;
        a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        a_screen_x, a_screen_y: INTEGER) is
			-- Start a pick and drop transport.
		do
			cell.implementation.start_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	end_transport (a_x, a_y, a_button: INTEGER) is
			-- Terminate the pick and drop mechanism.
		do
			cell.implementation.end_transport (a_x, a_y, a_button)
		end

	pointed_target: EV_PICK_AND_DROPABLE is
			-- Target at mouse position
		do
			Result := cell.implementation.pointed_target
		end

	draw_rubber_band  is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			cell.implementation.draw_rubber_band
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		do
			cell.implementation.erase_rubber_band
		end

	enable_capture is
      	      -- Grab the user input.
		do
			cell.enable_capture
		end

	disable_capture is
	      	-- Ungrab the user input.do
		do
			cell.disable_capture
		end

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		do
			Result := cell.parent
		end

	pointer_position: EV_COORDINATES is
			-- Position of the screen pointer relative to `Current'.
		do
			Result := cell.pointer_position
		end
		
	pointer_style: EV_CURSOR is
			-- Cursor displayed when screen pointer is over current widget.
		do
			Result := cell.pointer_style
		end

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		do
			Result := cell.foreground_color
		end

	background_color: EV_COLOR is
			-- Color displayed behind foreground features.
		do
			Result := cell.background_color
		end

	tooltip: STRING is
			-- Text displayed when user moves mouse over widget.
		do
			Result := cell.tooltip
		end

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events.
		do
			Result := cell.is_sensitive
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := cell.is_show_requested
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
		do
			Result := cell.is_displayed
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := cell.has_focus
		end

	hide is
			-- Request that `Current' not be displayed when its parent is.
		do
			cell.hide
		end
	
	show is
			-- Request that `Current' be displayed when its parent is.
		do
			cell.show
		end

	set_focus is
			-- Grab keyboard focus.
		do
			cell.set_focus
		end

	enable_sensitive is
			-- Enable sensitivity to user input events.
		do
			cell.enable_sensitive
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		do
			cell.disable_sensitive
		end

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		do
			cell.set_pointer_style (a_cursor)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		do
			cell.set_background_color (a_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			cell.set_foreground_color (a_color)
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		do
			cell.set_minimum_width (a_minimum_width)
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		do
			cell.set_minimum_height (a_minimum_height)
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		do
			cell.set_minimum_size (a_minimum_width, a_minimum_height)
		end

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		do
			cell.set_tooltip (a_text)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
		do
			cell.remove_tooltip
		end

	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			Result := cell.x_position
		end
	
	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			Result := cell.y_position
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := cell.width
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := cell.height
		end
	
	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		do
			Result := cell.minimum_width
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		do
			Result := cell.minimum_height
		end

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		obsolete "don't use it"
		do
			Result := cell.implementation.dimensions_set (new_width, new_height)
		end		

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- When the widget is not shown, the result is 0
		obsolete "don't use it"
		do
			Result := cell.implementation.minimum_dimensions_set (new_width, new_height)
		end		

	position_set (new_x, new_y: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- When the widget is not shown, the result is -1
		obsolete "don't use it"
		do
			Result := cell.implementation.position_set (new_x, new_y)
		end

	initialize is
			-- Do post creation initialization.
			-- While make must be redefined in each descendant,
			-- initialize may remain more general.
			--| Called from EV_ANY.default_create
		do
		end

	destroy is
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		do
		end























	
	


feature -- Implementation

	interface: EV_WIDGET
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_AGGREGATE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| Revision 1.3  2000/02/14 22:26:33  oconnor
--| merged from HACK-O-RAMA
--|
--| Revision 1.1.2.4  2000/02/14 20:53:58  rogers
--| Removed the inheritance of EV_WIDGET_IMP and EV_CONTAINER_IMP. Added cell, and implemented deferred features inherited from EV_AGGREGATE_WIDGET_I, to use this cell. ev_aggregate_widget_imp.e
--|
--| Revision 1.1.2.3  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.1.2.2  2000/01/28 19:00:34  oconnor
--| changed to use EV_AGGREGATE_BOX
--|
--| Revision 1.1.2.1  2000/01/28 16:40:35  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
