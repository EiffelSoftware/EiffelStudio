indexing

	description: 
		"Abstraction of data elements that make up a linkable data entity.";
	date: "$Date$";
	revision: "$Revision $"

deferred class LINKABLE_ELEMENT_DATA

inherit

	ELEMENT_DATA

feature -- Properties

	stone (data: LINKABLE_DATA): ELEMENT_STONE is
		do
			!! Result.make (Current, data);
		end;

	destroy_command (a_data: LINKABLE_DATA): DESTROY is
		deferred
		end;

feature -- Element change

	insert_before (data_cont: LINKABLE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		deferred
		end;

end -- class LINKABLE_ELEMENT_DATA
