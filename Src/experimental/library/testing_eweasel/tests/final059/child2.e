
class CHILD2
inherit	
	PARENT
		redefine
			placeholder_length
		end

feature -- Initialization

	placeholder_length: INTEGER
		external
			"C inline"
		alias
			"47"
		end


end
