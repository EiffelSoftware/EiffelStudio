indexing
	description: "Objects that debit money from %
	% a shared bank account"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPENDER

inherit
	CUSTOMER
		rename 
			make_transaction as withdraw
		redefine
			withdraw
		end
	
creation
	make

feature -- Execution


	withdraw (m: INTEGER) is
		do
			c_make_transaction (-m, c_account)
		end

	
end	-- class SPENDER
