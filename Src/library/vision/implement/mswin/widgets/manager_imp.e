indexing
	description: "This class represents a MS_IMPmanager";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class MANAGER_IMP

inherit

	COMPOSITE_IMP
		redefine
			realize
		end

	MANAGER_I

	COLORED_FOREGROUND_WINDOWS
	
feature --Status setting
	
	realize is
		do
			Precursor {COMPOSITE_IMP}
				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end
		end

end -- class MANAGER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

