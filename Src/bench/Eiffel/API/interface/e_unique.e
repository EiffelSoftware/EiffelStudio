indexing

	description: 
		"Representation of an unique constant.";
	date: "$Date$";
	revision: "$Revision $"

class E_UNIQUE

inherit

	E_CONSTANT
		redefine
			is_unique
		end

create

	make

feature -- Property

	is_unique: BOOLEAN is True;

end -- class E_UNIQUE
