-- Error when file to exclude doesn't exist

class VD12

inherit

	VD07
		redefine
			code
		end

feature

	code: STRING is "VD12";
			-- Error code

end
