indexing

	description: 
		"Abstraction of data elements that make up a class data entity.";
	date: "$Date$";
	revision: "$Revision $"

deferred class CLASS_ELEMENT_DATA

inherit

	LINKABLE_ELEMENT_DATA
		redefine
			stone,
			is_in_class_content
		end;

feature -- Properties

	is_in_class_content: BOOLEAN is
			-- Is current in the class content?
		do
			Result := True
		end;

	stone (data: CLASS_DATA): ELEMENT_STONE is
		do
			!! Result.make (Current, data);
		end;

	destroy_command (a_data: CLASS_DATA): DESTROY_LIST_ELEMENT is
		deferred
		end;

feature -- Element change

	insert_before (data_cont: CLASS_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		deferred
		end;

end -- class CLASS_ELEMENT_DATA
