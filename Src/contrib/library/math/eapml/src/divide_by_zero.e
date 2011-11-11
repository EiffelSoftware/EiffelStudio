note
	description: "An exception when dividing by zero"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "A right is not what someone gives you; it's what no one can take from you. -  Ramsey Clark, U.S. Attorney General, New York Times, 10/02/77"

class
	DIVIDE_BY_ZERO

inherit
	DEVELOPER_EXCEPTION
		redefine
			internal_meaning
		end

feature
	internal_meaning: STRING = "Divide by zero"
end
