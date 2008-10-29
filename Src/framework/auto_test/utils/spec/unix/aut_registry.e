indexing
	description: "Dummy registry implementation"
	author: "Ilinca Ciupa and Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_REGISTRY
	
inherit
	
	AUT_ABSTRACT_REGISTRY

feature -- Access
		
	subkeys (key: STRING): DS_LINEAR [STRING] is
		do
			check 
				dead_end: False 
			end
		end

	string_value (key: STRING): STRING is
		do
			check 
				dead_end: False 
			end
		end

feature -- Status report

	is_available: BOOLEAN is False

end
