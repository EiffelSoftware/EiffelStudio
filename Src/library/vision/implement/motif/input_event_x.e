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
			motif: MOTIF
		do
			motif ?= toolkit;
			Result := motif.application_context;
		end;

end -- class IO_HANDLER_X

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
