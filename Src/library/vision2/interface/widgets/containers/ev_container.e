indexing
	description: 
		"EiffelVision container. Container is a widget that can hold children inside it"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_CONTAINER

inherit
	EV_WIDGET
		redefine
			implementation
		end
	
feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area (area of the
			-- widget excluding the borders etc) of
			-- container
		require
			exists: not destroyed	
		do
			Result := implementation.client_width
		ensure
			positive_result: Result >= 0
		end
	
	client_height: INTEGER is
			-- Height of the client area (area of the
			-- widget excluding the borders etc) of
			-- container
		require
			exists: not destroyed	
		do
			Result := implementation.client_height
		ensure
			positive_result: Result >= 0	
		end
	
	manager: BOOLEAN is
			-- Does the container managed the size of its
			-- children?
		do
			Result := True
		end

feature -- Status report

	accept_child: BOOLEAN is
			-- Is another child accepted by the container?
		do
			Result := implementation.add_child_ok
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		require
			exists: not destroyed
		do
			implementation.propagate_background_color
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		require
			exists: not destroyed
		do
			implementation.propagate_foreground_color
		end
	
feature -- Implementation

        implementation: EV_CONTAINER_I
	
end -- class EV_CONTAINER

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
