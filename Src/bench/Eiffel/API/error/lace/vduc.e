indexing

	description: 
		"Error when a local ACE file has a use clause.";
	date: "$Date$";
	revision: "$Revision $"

class VDUC
	
inherit

	VD02
		redefine
			code
		end

feature -- Property

	code: STRING is "VDUC";
			-- Error code

end -- class VDUC
