indexing
	description: "References to objects containing an integer value coded on 32 bits"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_32_REF

feature

	infix "+" (other: like Current): like Current is
		do
		end

	infix "-" (other: like Current): like Current is
		do
		end

	infix "*" (other: like Current): like Current is
		do
		end

	infix "/" (other: like Current): DOUBLE is
		do
		end

	infix ">" (other: like Current): BOOLEAN is
		do
		end

	infix ">=" (other: like Current): BOOLEAN is
		do
		end

	prefix "+": like Current is
		do
		end

	prefix "-": like Current is
		do
		end

	item: INTEGER

	set_item (v: INTEGER) is
			-- 
		do
			
		end

feature

	to_reference: INTEGER_REF is
		do
			create Result
			Result.set_item (item)
		end


end
