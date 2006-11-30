indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature	
	make is
		do
		end

	f (a: INTEGER) is
		do
		ensure
			e1: (agent: BOOLEAN local $A: BOOLEAN do Result := $A end).item ([])	 
		end

	
end
