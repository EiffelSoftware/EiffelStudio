indexing
	description: "Shared operator table.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_OPERATOR_TABLE

feature

	operator_table: OPERATOR_TABLE is
			-- Operator table
		once
			create Result.make
		end

end
