indexing
	description: 
		"EiffelVision box, implementation interface."
	status: "See notice at end of class"
	keywords: "container, box"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_I
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end
	
feature -- Constants
	
	Default_homogeneous: BOOLEAN is False
	Default_spacing: INTEGER is 0
	Default_border_width: INTEGER is 0

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		deferred
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		deferred
		ensure
			positive_result: Result >= 0
		end

	padding: INTEGER is
			-- Space between children in pixels.
		deferred
		ensure
			positive: Result >= 0
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy available spare space.
		require
			has_child: interface.has (child)
		deferred
		end
	
feature {EV_ANY, EV_ANY_I} -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		deferred
		ensure
			homogeneous_set: is_homogeneous = flag
		end

	set_border_width (value: INTEGER) is
			-- Assign `value' to `border_width'.
		require
			positive_value: value >= 0
		deferred
		ensure
			border_assigned: border_width = value
		end	
	
	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		require
			positive_value: value >= 0
		deferred
		end	

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill avalible spare space.
		require
			has_child: interface.has (child)
		deferred
		ensure
			flag_assigned: is_item_expanded (child) = flag
		end	
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_BOX

end -- class EV_BOX_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

