indexing

	description: 
		"Callback structure for MEL_IDENTIFIERs of input, %
		% work_proc and timer callbacks."
	legal: "See notice at end of class.";
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

create

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

	has_widget: BOOLEAN is False;
			-- Does not need widget

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




end -- class MEL_ID_CALLBACK_STRUCT


