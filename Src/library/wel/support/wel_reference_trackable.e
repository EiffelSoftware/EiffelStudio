indexing
	description	: "Facility to track references of an object."
	status		: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WEL_REFERENCE_TRACKABLE

feature -- Status Report

	reference_tracked: BOOLEAN
			-- Are the number references of `Current' tracked?

	shared: BOOLEAN is
			-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.
		deferred
		end

	exists: BOOLEAN is
			-- Is `Current' valid?
		deferred
		end
	
feature -- Status Setting

	enable_reference_tracking is
			-- Set `references_tracked' to True.
			-- 
		require
			exists: exists
			not_shared: not shared
			tracking_reference_disabled: not reference_tracked
		do
			reference_tracked := True
			references_number := 1
		end

	decrement_reference is
			-- Decrement the number of references to this object.
			--
			-- When the number of references reach zero, 
			-- `delete' is called if the object is not protected.
		require
			exists: exists
			not_shared: not shared
			tracking_references_started: reference_tracked
		do
			if references_number > 0 then
				references_number := references_number - 1
				if references_number = 0 then
					destroy_item
				end
			end
		end

	increment_reference is
			-- Increment the number of references to this object.
		require
			exists: exists
			not_shared: not shared
			tracking_references_started: reference_tracked
		do
			references_number := references_number + 1
		end

feature {NONE} -- Removal

	destroy_item is
			-- Ensure the current object is destroyed.
		deferred
		end

feature {ANY} -- Implementation

	references_number: INTEGER
			-- Number of object referring to this object.

end -- class WEL_REFERENCE_TRACKABLE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

