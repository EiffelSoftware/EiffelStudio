indexing

	description: 
		"Undoable command for adding command data.";
	date: "$Date$";
	revision: "$Revision $"


class ADD_COMMAND_U 

inherit

	ADD_FEATURE_U
		redefine
			create_data, name
		end

creation

	make, make_with

feature -- Property

	name: STRING is 
		once
			Result := "Add command"
		end;

feature -- Element change

	create_data is
		local
			feature_name: STRING;
			comments: FEATURE_COMMENT_DATA;
		do
			feature_name := data_container.new_feature_name;
			!! data.make (feature_name, data_container);
			!! comments.make;
			comments.put_front ("Comment.");
			data.set_comments (comments);
		end

end -- class ADD_COMMAND_U
