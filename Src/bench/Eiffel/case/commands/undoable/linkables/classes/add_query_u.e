indexing

	description: 
		"Undoable command for adding query data.";
	date: "$Date$";
	revision: "$Revision $"


class ADD_QUERY_U 

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
			Result := "Add query"
		end;

feature -- Element change

	create_data is
		local
			feature_name: STRING;
			result_type: RESULT_DATA;
			comments: FEATURE_COMMENT_DATA;
		do
			feature_name := data_container.new_feature_name;
			!! data.make (feature_name, data_container);
			!! result_type.make;
			data.set_result (result_type);
			!! comments.make;
			comments.put_front ("Comment");
			data.set_comments (comments);
		end

end -- class ADD_QUERY_U
