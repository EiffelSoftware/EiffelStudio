indexing

	description: 
		"EiffelVision composite, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_CONTAINER_IMP
	
inherit
	EV_CONTAINER_I	

	EV_WIDGET_IMP
	
feature {EV_CONTAINER}
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			child_imp.set_parent_imp (Current) 
			-- no other implementation needed (yet?) XXX
		end

feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := wel_window.client_rect.height
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := wel_window.client_rect.width
		end

feature {EV_WIDGET_IMP} -- Resizing
	
	child_has_resized (new_width: INTEGER; new_height: INTEGER) is
			-- Resize the container according to the 
			-- resize of the child
		do
			-- XX Have to take into account the borders 
			-- (new_width and new_height are the 
			-- dimensions of the client area)
			set_size (new_width + 2*system_metrics.window_frame_width, 
				  new_height + system_metrics.title_bar_height + system_metrics.window_border_height + 2 * system_metrics.window_frame_height)
		end
	
	
feature {NONE} -- Implementation
	
	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end
end

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
