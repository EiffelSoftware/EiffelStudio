indexing

	description: "Key to identify a client supplier relationship";
	date: "$Date$";
	revision: "$Revision $"

class CLI_SUP_KEY 

inherit

	RELATION_DATA_KEY
		rename
			f_rom as client,
			t_o as supplier
		end

creation

	make, make_with_relation

feature -- Properties

	data: CLI_SUP_DATA is
			-- Data associated with Current key
		do
			if internal_data = Void then
				internal_data := client.client_link_of (supplier)
			end;
			Result := internal_data
		end;

end -- class CLI_SUP_KEY
