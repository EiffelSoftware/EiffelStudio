indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A

feature 
	
	a: INTEGER

	agent_on_a: FUNCTION [ANY, TUPLE, INTEGER] is
		do
			a := 100
			Result := agent a
		end


end
