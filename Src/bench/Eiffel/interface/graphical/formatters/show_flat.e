
-- Command to display flat form of a class

class SHOW_FLAT 

inherit

	FORMATTER;
	SHARED_SERVER

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showflat) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showflat end;

	title_part: STRING is do Result := l_Flat_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat form of `c'.
-- !!! The implementation should be written in FLAT_CLASS
-- !!! but the compiler did not seem to want to melt it
-- !!! (infinite loop). Do it before next freezing.
		local
			-- !!! flat_class: FLAT_CLASS;

			feature_table: FEATURE_TABLE;
			feature_i: FEATURE_I;
			feature_as: FEATURE_AS;
			class_c: CLASS_C;
			flat_text: STRING;
			original_text: STRING;
			file: UNIX_FILE;
			done: BOOLEAN;
			temp_string: STRING
		do
			-- !!! !!flat_class.make (c.class_c);
			-- !!! flat_class.flat;
			-- !!! text_window.put_string (flat_class.flat_text);
			-- !!! text_window.share (flat_class.click_list)

			class_c := c.class_c;
			feature_table := Feat_tbl_server.item (class_c.id);
			!!flat_text.make (10000);
			flat_text.append ("-- Flat form%N%Nclass ");
			flat_text.append (class_c.signature);
			flat_text.append ("%N%Nfeature%N%N");

			-- Append the features.
			from
				feature_table.start
			until
				feature_table.offright
			loop
				feature_i := feature_table.item_for_iteration;
				class_c := feature_i.written_class;
				if
					class_c.class_id >
					System.any_class.compiled_class.class_id
				then
					feature_as := Body_server.item (feature_i.body_id);
					!!file.make_open_read (class_c.file_name);
					file.readstream (feature_as.end_position);
					flat_text.append (file.laststring.substring 
							(feature_as.start_position, feature_as.end_position));
					if feature_as.body.content /= Void then
							-- It is a routine.
						flat_text.append (";%N%N")
					else
							-- It is an attribute.
							-- Append the trailing comments.
						from
							file.next_line
						until
							file.end_of_file or else
							done
						loop
							file.readline;
							temp_string := file.laststring.duplicate;
							temp_string.left_adjust;
							if 
								(temp_string.count >= 2) and then
								temp_string.substring (1,2).is_equal ("--")
							then
								flat_text.append ("%N");
								flat_text.append (tabs(3));
								flat_text.append (temp_string)
							else	
								done := True
							end
						end;
					 	flat_text.append ("%N%N");
					end;
					file.close;
				end;
				feature_table.forth
			end;

			-- Append the invariant.

			flat_text.append ("end");
			text_window.put_string (flat_text)			
		end
 
end
