class MT_INDEX_CRITERION 

inherit

	MATISSE_CONST

feature -- Status Report

	type : INTEGER is  
		-- The type of the index creterion
		-- Do nothing
		do
		end -- type

	size : INTEGER is
		-- The size of the criterion as described in the meta-schema
		-- Do nothing
		do
		end -- size

	ordering : INTEGER is
		-- Ordering of the indexation for the criterion as described in the meta-schema
		-- Do nothing
		do
		ensure
			ascend_or_descend : Result = Mtascend or else Result = Mtdescend
		end -- ordering

feature {NONE} -- Implementation

	icid : INTEGER -- Identifier in database

end -- class MT_INDEX_CRITERION
