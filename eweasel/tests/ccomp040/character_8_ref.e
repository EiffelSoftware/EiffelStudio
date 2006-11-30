indexing

	description:
		"References to objects containing a character value"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CHARACTER_8_REF

feature
	item: CHARACTER
	
	code: INTEGER is
			-- 
		do
			
		end

	set_item (v: CHARACTER) is
			-- 
		do
			
		end		

	to_reference: CHARACTER_REF is
		do
			create Result
			Result.set_item (item)
		end

end
