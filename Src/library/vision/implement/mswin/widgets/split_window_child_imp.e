indexing

	descriotion:
		"Child for a SPLIT_WINDOW.";
	date: "$Date$";
	revision: "$Revision$"

deferred class SPLIT_WINDOW_CHILD_IMP
 
inherit
	FORM
		rename
			make as form_make,
			make_unmanaged as form_make_unmanaged
		redefine
			parent, implementation,
			manage, unmanage
		end


feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			parent:= a_parent
			form_make (a_name, a_parent)
		end;

feature -- Access

	exists: BOOLEAN is
			-- Does Current exist?
		do
			Result := implementation.exists
		end

feature -- Widget Management

	set_child_managed is
		do
			implementation.set_managed (True)
		end

	set_child_unmanaged is
		do
			implementation.set_managed (False)
		end

	manage is
			-- Manage Current.
			--| Ie. Make it visible on the screen.
		do
			--redefine it in the descendant
		end;

	unmanage is
			-- Unmanage Current.
			--| Ie. Make ir invisible on the screen.
		do
			--redefine it in the descendant
		end

feature -- Implementation

	implementation: FORM_IMP
			-- Implementation Window

	parent: SPLIT_WINDOW

end -- class SPLIT_WINDOW_CHILD_IMP
 


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

