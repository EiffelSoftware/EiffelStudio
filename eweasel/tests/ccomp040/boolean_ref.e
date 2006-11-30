indexing

	description:
		"References to objects containing a boolean value"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class BOOLEAN_REF 

feature

	prefix "not": like Current is
			-- Negation
		do
		end

	infix "and" (other: like Current): BOOLEAN is
		do
		end

	infix "and then" (other: like Current): BOOLEAN is
		do
		end

	infix "implies" (other: like Current): BOOLEAN is
		do
		end

	infix "or" (other: like Current): BOOLEAN is
		do
		end

	infix "or else" (other: like Current): BOOLEAN is
		do
		end

	infix "xor" (other: like Current): BOOLEAN is
		do
		end

	item: BOOLEAN
	
	set_item (v: BOOLEAN) is
			-- 
		do
			
		end
		

end -- class BOOLEAN_REF



