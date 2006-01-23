indexing

	description:
		"Abstract notion of input events: events generated from %
		%sockets, files, time out and background task."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class INPUT_EVENT_X


