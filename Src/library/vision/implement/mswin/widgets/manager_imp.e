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
			{COMPOSITE_IMP} Precursor

				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end
		end

end -- class MANAGER_IMP


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

