indexing
	description: "Objects that put money in shared bank account"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAVER

inherit
	CUSTOMER
		rename 
			make_transaction as deposit
		redefine
			deposit
		end
creation
	make

feature -- Execution
	
	deposit (m: INTEGER) is
		do
			c_make_transaction (m, c_account)
		end

end -- class SAVER
