-- Error when adaptation of a cluster conatains a paragraph about itself

class VD05

inherit

	VD03
		redefine
			code
		end

feature

	code: STRING is "VD05";
			-- Error code

end
