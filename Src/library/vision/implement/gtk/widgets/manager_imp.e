indexing

	description: 
		"EiffelVision manager, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
--XX deferred class
class
	MANAGER_IMP

inherit
	COMPOSITE_IMP	
	MANAGER_I
	



feature -- Access

	is_stackable: BOOLEAN is 
			-- Is the Current widget stackable?
		do
			Result := True;
		end;
	
feature -- Status Setting

	set_initial_input_focus (a_widget: WIDGET) is
			-- Set child which will initially have input focus
		local
			widget_implementation: WIDGET_IMP
		do
			widget_implementation ?= a_widget.implementation
			check
				widget_implementation /= void
			end
--XX			set_initial_focus (widget_implementation)
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
