indexing
	description: "Objects that ..."
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

end -- class TRANSFER_ERROR

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
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

