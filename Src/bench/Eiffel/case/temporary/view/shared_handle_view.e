indexing

	description: "Shared handle based on the identifier.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_HANDLE_VIEW

inherit

	HANDLE_VIEW;
	ONCES

creation

	make

feature {NONE} -- Initialization

	make (id: INTEGER) is
		require
			valid_id: id > 0
		do
			identifier := id
		ensure
			id_set: identifier = id
		end;

feature {NONE} -- Properties

	identifier: INTEGER;
			-- Shared handle identifier

	data: HANDLE_DATA is
			-- Data created with Current
		do
			Result := view_information.handle_data (identifier)
		end;

feature {NONE} -- Setting

	update_data (a_data: DATA) is 
			-- Do nothing.
		do 
		end

end -- clas SHARED_HANDLE_VIEW
