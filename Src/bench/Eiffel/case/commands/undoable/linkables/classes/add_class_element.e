indexing

	description: 
		"Abstract class for adding linkable elements.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ADD_CLASS_ELEMENT

inherit

	ADD_LINKABLE_ELEMENT
		redefine
			data_container, request_for_data,
			free_data
		end

feature {NONE}

	data_container: CLASS_DATA

	request_for_data is
		do
			data_container.request_for_information;
		end;

	free_data is
		do
			data_container.free_information
		end;

end -- class ADD_CLASS_ELEMENT
