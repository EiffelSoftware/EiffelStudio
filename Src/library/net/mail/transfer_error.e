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


