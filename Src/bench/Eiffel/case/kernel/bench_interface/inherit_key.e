indexing

	description: "Key to identify an inheritance relationships.";
	date: "$Date$";
	revision: "$Revision $"

class INHERIT_KEY 

inherit

	RELATION_DATA_KEY
		rename
			f_rom as heir,
			t_o as parent
		end

creation

	make, make_with_relation

feature -- Properties

	data: INHERIT_DATA is
			-- Data associated with Current key
		do
			if internal_data = Void then
				internal_data := heir.heir_link_of (parent)
			end;
			Result := internal_data
		end;

end -- class INHERIT_KEY
