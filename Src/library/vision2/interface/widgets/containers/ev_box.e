indexing
	description: 
		"Linear widget container.%N%
		%Base class for EV_HORIZONTAL_BOX and EV_VERTICAL_BOX"
	status: "See notice at end of class"
	keywords: "box, container, child"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_BOX

inherit
	EV_WIDGET_LIST
		redefine
			implementation,
			is_in_default_state
		end

feature -- Status report

	is_homogeneous: BOOLEAN is
			-- Are all items forced to have same dimensions.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_homogeneous
		ensure
			bridge_ok: Result = implementation.is_homogeneous
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.border_width
		ensure
			bridge_ok: Result = implementation.border_width
			positive: Result >= 0
		end

	padding: INTEGER is
			-- Space between children in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.padding
		ensure
			bridge_ok: Result = implementation.padding
			positive: Result >= 0
		end 

feature -- Status report

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN is
			-- Is `an_item' expanded to occupy available spare space?
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.is_item_expanded (an_item)
		ensure
			bridge_ok: Result = implementation.is_item_expanded (an_item)
		end

feature -- Status setting
	
	enable_homogeneous is
			-- Force all items to have same dimensions.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_homogeneous (True)
		ensure
			is_homogeneous: is_homogeneous
		end

	disable_homogeneous is
			-- Allow items to have different dimensions.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_homogeneous (False)
		ensure
			not_is_homogeneous: not is_homogeneous
		end

	set_border_width (value: INTEGER) is
			-- Assign `value' to `border_width'.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_border_width (value)
		ensure
			border_width_assigned: border_width = value
		end

	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_padding (value)
		ensure
			padding_assigned: padding = value
		end

	enable_item_expand (an_item: EV_WIDGET) is
			-- Expand `an_item' to occupy available spare space.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			implementation.set_child_expandable (an_item, True)
		ensure
			an_item_expanded: is_item_expanded (an_item)
		end

	disable_item_expand (an_item: EV_WIDGET) is
			-- Do not expand `an_item' to occupy available spare space.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			implementation.set_child_expandable (an_item, False)
		ensure
			not_an_item_expanded: not is_item_expanded (an_item)
		end
		
feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_WIDGET_LIST} and (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
		end

feature  {EV_ANY_I} -- Implementation
	
	implementation: EV_BOX_I
			-- Responsible for interaction with native graphics toolkit.
			
end -- class EV_BOX

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

