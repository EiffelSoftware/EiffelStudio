indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create 
	make
feature
	make is do end

	b: BOOLEAN

invariant
	i_1: (agent: BOOLEAN do Result := (agent: BOOLEAN do Result := True end).item ([]) end).item ([])
	i_2: (agent: BOOLEAN do Result := not (agent b).item ([]) end).item ([])

end
