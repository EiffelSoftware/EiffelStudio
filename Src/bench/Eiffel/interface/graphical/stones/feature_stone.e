class FEATURE_STONE 

inherit

	FILED_STONE
		rename
			origin_text as normal_origin_text
		end;
	FILED_STONE
		redefine
			origin_text
		select
			origin_text
		end
	
creation

	make

feature -- making

	make (a_featurei: FEATURE_I; a_class: CLASS_C; s, e: INTEGER) is
		do
			feature_i := a_featurei;
			start_position := s;
			end_position := e;
			class_c := a_class
		end;
 
	feature_i: FEATURE_I;
	class_c: CLASS_C;
 
feature -- dragging

	origin_text: STRING is
			-- Text of the feature
		do
			Result := normal_origin_text;
			if (Result /= Void) then
				Result := Result.substring (start_position, end_position)
			end;
		end;

	click_list: ARRAY [CLICK_STONE] is do end;
			-- Structure to make clickable the display of Current, nothing yet
 
	file_name: STRING is
			-- The one from class origin of `feature_i'
		do
			if feature_i /= Void then
				Result := feature_i.written_class.file_name
			end;
		end;
 
	set_file_name (s: STRING) is do end;

	signature: STRING is
			-- Signature of Current feature
		do
			Result := feature_i.signature
		end;

	stone_type: INTEGER is do Result := Routine_type end;
 
	stone_name: STRING is do Result := l_Routine end;
 
	clickable: BOOLEAN is
		do
			Result := True
		end

feature {NONE} -- secret

	start_position, end_position: INTEGER;
            -- Start and end of the text of the feature in origin file
			-- (in fact, to get origin text...)
 
end
