indexing

	description: 
		"Callback structure for MEL_IDENTIFIERs of input, %
		% work_proc and timer callbacks.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class MEL_ID_CALLBACK_STRUCT

inherit

	MEL_CALLBACK_STRUCT
		rename
			make as old_make
		redefine	
			has_widget
		end

creation

	make 

feature {NONE} -- Initialization

	make (an_id: like identifier) is
			-- Create an id callback structure.
		require
			valid_id: an_id /= Void and then an_id.is_valid
		do
			identifier := an_id
		end

feature -- Access

	identifier: MEL_IDENTIFIER
			-- Mel identfier return from input or work_proc 
			-- or timer callback registration

	has_widget: BOOLEAN is False
			-- Does not need widget

end -- class MEL_ID_CALLBACK_STRUCT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

