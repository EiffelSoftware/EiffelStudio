-- Error when a local ACE file has a use clause

class VDUC
	
inherit

	VD02
		redefine
			code
		end

feature

	code: STRING is "VDUC";
			-- Error code

end
