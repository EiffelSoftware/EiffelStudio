indexing

	description:
		"Abstract notion of input events: events generated from %
		%sockets, files, time out and background task.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	INPUT_EVENT_X 

inherit

	EVENT_HDL;

	MEL_COMMAND;

	G_ANY

feature -- Access

	identifier: MEL_IDENTIFIER
			-- Task identifier 

	is_call_back_set: BOOLEAN is
			-- Is a call back already set?
		do
			Result := identifier /= Void
		end;

feature -- Status setting

	set_no_call_back is
			-- Remove any call-back already set.
		do
			identifier.remove;
			identifier := Void;
		end; 

	destroy is
			-- Remove identifier.
		do
			if identifier /= Void then
				set_no_call_back
			end
		end

feature {NONE} -- Implementation
		
	application_context: MEL_APPLICATION_CONTEXT is
		local
			motif: TOOLKIT_IMP
		do
			motif ?= toolkit;
			Result := motif.application_context;
		end;

end -- class INPUT_EVENT_X


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

