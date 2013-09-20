note
	description: "This error indicates that some operation didn't meet the ACID requirements for transactions and therefore it has been aborted"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TRANSACTION_CONFLICT

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING = "Transaction error"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_transaction_error (Current)
		end

end
