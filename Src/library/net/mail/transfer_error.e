indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSFER_ERROR

feature -- Access

	transfer_error_message: STRING

feature -- Status report

	transfer_error: BOOLEAN
		-- Is transfer error?


feature -- Status setting

	enable_transfer_error is
		do
			transfer_error:= True
		end

	disable_transfer_error is
		do
			transfer_error:= False
		end

	set_transfer_error_message (s: STRING) is
		do
			transfer_error_message:= s
		end

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




end -- class TRANSFER_ERROR

