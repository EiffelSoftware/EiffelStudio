indexing

	description: 
		"Error for invalid alias name in renaming.";
	date: "$Date$";
	revision: "$Revision $"

deferred class VFAV_VHRC

inherit

	VHRC
		undefine
			subcode
		redefine
			code
		end

feature -- Properties

	code: STRING is "VFAV"

end
