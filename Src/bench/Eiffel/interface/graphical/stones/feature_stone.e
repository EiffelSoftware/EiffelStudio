class FEATURE_STONE 

inherit

	FILED_STONE
		rename
			origin_text as normal_origin_text,
			is_valid as fs_valid
		redefine
			synchronized_stone
		end;

	FILED_STONE
		redefine
			origin_text, is_valid, synchronized_stone
		select
			origin_text, is_valid
		end;

	SHARED_WORKBENCH;

	HASHABLE_STONE
		undefine
			header
		redefine
			origin_text, is_valid, synchronized_stone
		end

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
			temp := clone (class_c.class_name)
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
			temp := normal_origin_text;
			if temp /= Void then
				Result := "-- Version from class: ";
				cn := clone (feature_i.written_class.class_name)
				cn.to_upper;
				Result.append (cn);
				Result.append ("%N%N%T");
				if 
					temp.count >= end_position and 
					start_position < end_position 
				then
					temp := temp.substring (start_position + 1, end_position);
					Result.append (temp)
				end;
				Result.append ("%N");
			end
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
				sp := ep + 3;
				ep := sp + end_position - start_position;
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
			file: RAW_FILE;
			start_line_pos: INTEGER;
		do
			!!file.make_open_read (file_name);
			from
			until
				file.position > start_position + 1 or else file.end_of_file
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
			-- Is `Current' a valid stone?
		do
			Result := fs_valid and then class_c /= Void 
						and then feature_i /= Void
		end;

	set_positions (s, e: INTEGER) is
			-- Assign `s' to start_position.
			-- Assign `e' to end_position.
		do
			start_position := s;
			end_position := e
		end;

	synchronized_stone: FEATURE_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			new_feature_i: FEATURE_I
		do
			if class_c /= Void and feature_i /= Void then
				if System.id_array.item (class_c.id) = class_c then
					new_feature_i := class_c.feature_table.item
													(feature_i.feature_name);
					if new_feature_i /= Void then
						Result := new_feature_i.stone (class_c)
					end
				end
			end
		end;

feature -- Hashable

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := class_c.class_name.hash_code
		end;

end
