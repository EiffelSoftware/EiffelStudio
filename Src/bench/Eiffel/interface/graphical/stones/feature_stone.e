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
		end;
--	SHARED_DEBUG
-- Removed to cut dependancies for the batch only version

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

	icon_name: STRING is
		require else
			is_valid
		local
			temp: STRING
		do
			!!Result.make (0);
			Result.append (feature_i.feature_name);
			Result.append (" (");
			temp := class_c.class_name.duplicate;
			temp.to_upper;
			Result.append (temp);
			Result.append (")");
		end;

	header: STRING is
		require else
			is_valid
		do
			!!Result.make (0);
			Result.append ("Feature: ");
			Result.append (feature_i.feature_name);
			Result.append ("    Class: ");
			Result.append (class_c.signature);
--			if Debug_info.is_breakpoint_set (feature_i, 1) then
--				Result.append ("   (stop)");
--			end;
		end;
 
feature -- dragging

	origin_text: STRING is
			-- Text of the feature
		local
			temp: STRING;
			cn: STRING;
		do
			Result := normal_origin_text;
			if 
				(Result /= Void) and then
				Result.count >= end_position
			then
				Result := Result.substring (start_position, end_position);
				!! temp.make (0);
				temp.append ("-- Version from class: ");
					cn := feature_i.written_class.class_name.duplicate;
					cn.to_upper;
				temp.append (cn);
				temp.append ("%N%N");
				temp.append (Result);
				Result := temp	
			end;
		end;

	click_list: ARRAY [CLICK_STONE] is
			-- Structure to make clickable the display of Current, nothing yet
			-- Now yeah
		local
			cs: CLICK_STONE;
			sp, ep: INTEGER;
			temp: STRING
		do 
			!! Result.make (1, 2);
				temp := "-- Version from class: ";
				sp := temp.count;
				ep :=  feature_i.written_class.class_name.count;
				ep := ep + sp;
			!! cs.make (feature_i.written_class.stone, sp, ep);
			Result.put (cs, 1);
				sp := ep + 2;
				ep := sp + end_position - start_position + 1;
			!! cs.make (Current, sp, ep);
			Result.put (cs, 2);
		end;
 
	file_name: STRING is
			-- The one from class origin of `feature_i'
		do
			if feature_i /= Void and then 
				feature_i.written_class /= Void and then
				class_c /= Void
			then
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
		end;

	line_number: INTEGER is
			-- Line number of feature text.
		require
			valid_start_position: start_position > 0;
			valid_feature: feature_i /= Void 
		local
			file: UNIX_FILE;
			start_line_pos: INTEGER;
		do
			!!file.make_open_binary_read (file_name);
			from
			until
				file.position > start_position or else file.end_of_file
			loop
				start_line_pos := file.position;
				Result := Result + 1;
				file.readline;
			end;
			file.close;
		end;

	start_position, end_position: INTEGER;
            -- Start and end of the text of the feature in origin file
			-- (in fact, to get origin text...)

	is_valid: BOOLEAN is
			-- Does Current have a corresponding feature_i?
		do
			Result := feature_i /= Void
		end;

	set_positions (s, e: INTEGER) is
			-- Assign `s' to start_position.
			-- Assign `e' to end_position.
		do
			start_position := s
			end_position := e
		end;
 
end
