indexing

	description: 
		"Abstraction of data elements that make up a feature data entity.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_ELEMENT_DATA

inherit

	ELEMENT_DATA

feature -- Properties

	stone (data: FEATURE_DATA): ELEMENT_STONE is
		do
			!! Result.make (Current, data);
		end;

	destroy_command (a_data: FEATURE_DATA): DESTROY is
		deferred
		end;

feature -- Element change

	insert_before (data_cont: FEATURE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		deferred
		end;
	
feature -- Output

	clickable_string: STRING is
		deferred
		end;

end -- class FEATURE_ELEMENT_DATA
