indexing

	description: "Feature comments.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_COMMENT_DATA

inherit

	FEATURE_ELEMENT_DATA
		redefine
			generate
		end;
	FREE_TEXT_INFO
		redefine
			generate
		end

creation

	make, make_from_storer

feature -- Properties

	destroy_command (a_data: FEATURE_DATA): FEATURE_SET_COMMENT_U is
		do
			!! Result.make_with_container (a_data)
			Result.update_saved_is_on
		end
	
	stone_type: INTEGER is
		do
			Result := Stone_types.comment_type
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			fd: FEATURE_DATA
		do
			fd ?= data;
			Result := fd /= Void and then fd.has_comments and then
						fd.comments = Current;
		end

feature -- Element change

	insert_before (data_cont: FEATURE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		do
		end;

feature -- Output

	generate (text_area: TEXT_AREA; data: FEATURE_DATA ) is
		do
			if not empty then

				text_area.start_comment;

				from
					start;
				until
					after
				loop
					text_area.append_comment_string ("-- ");
					text_area.append_comment_string (item);
					text_area.new_line;
					forth;
				end;
				text_area.end_comment (stone (data));
			end;
		end;


	generate_c (text_area: TEXT_AREA; data: FEATURE_DATA) is
        do
            if not empty then
                from
                    start;
                    text_area.start_comment;
                until
                    after
                loop
                    text_area.append_comment_string ("// ");
                    text_area.append_comment_string (item);
                    text_area.new_line;
                    forth;
                end;
                text_area.end_comment (stone (data));
            end;
        end;

	generate_chart (text_area: TEXT_AREA; data: FEATURE_DATA) is
		local
			chart_feature_stone: CHART_FEATURE_STONE;
		do
			if not empty then
				from
					start;
					text_area.start_comment;
				until
					after
				loop
					text_area.append_comment_string (item);
					text_area.new_line;
					forth;
				end;
				!! chart_feature_stone.make (data);
				text_area.end_comment (chart_feature_stone);
			end;
		end;

end -- class FEATURE_COMMENT_DATA
