indexing
	description: "Row descriptor"
	external_name: "AssemblyManager.RowDescriptor"

class
	ROW_DESCRIPTOR

create
	make

feature {NONE} -- Initialization

	make (a_number: like row_number) is
			-- Set `row_number' with `a_number'.
		indexing
			external_name: "Make"
		require
			positive_number: a_number >= 0
		do
			row_number := a_number
		ensure
			row_number_set: row_number = a_number
		end

feature -- Access
		
	row_number: INTEGER
			-- Row number in the assemblies table
		indexing
			external_name: "RowNumber"
		end
	
invariant
	positive_number: row_number >= 0

end -- class ROW_DESCRIPTOR