-- Command to display the routines clients

class SHOW_ROUTCLIENTS

inherit

	FORMATTER;
	SHARED_SERVER

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showfs) 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showfs end;

	title_part: STRING is do Result := l_Flatshort_form_of end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display flat|short form of `c'.
		local
			feature_i: FEATURE_I;
			feat_table: FEATURE_TABLE;
			feature_as : FEATURE_AS;
			class_c: CLASS_C;
			classc_stone : CLASSC_STONE;
			feature_stone: FEATURE_STONE;
			clients: SORTED_SET [DEPEND_UNIT];
			class_depend: CLASS_DEPENDANCE;
			last_id: INTEGER;
		do
		--	feature_i := f.feature_i;
		--		class_c := feature_i.written_class;
		--class_depend := Depend_server.item (class_c.id);
		--	clients := class_depend.item (feature_i.feature_name);
		--	from
		--		clients.start;
	--		until
	--			clients.after
	--		loop
			--	class_c := system.class_of_id (clients.item.id);
	--			if class_c.id /= last_id then
	--				last_id := class_c.id;
	--				classc_stone.make (class_c);
			--		text_window.put_clickable_string (classc_stone,
--						 classc_stone.signature);
		--			text_window.put_string ("%N");
		--			feat_table := Feat_tbl_server (clients.item.class_id);
		--		end;
		--		from 
		--			feat_table.start
		--		until
		--			feat_table.offright
		--			or else feat_table.item.feature_id = clisnts.item.feature_id
		--		loop
		--			feat_table.forth;
		--		end;
		--		if not feat_table.offright then
		--			feature_i := feat_table.item;
		----			feature_as := Body_server.item (feature_i.body_id);
--		--			!!feature_stone.make (feature_i, feature_as.start_position,
--		--				feature_as.end_position);
		--			text_window.put_string ("%T");
--		--			text_window.put_clickable_string (feature_stone, 
--		--				feature_i.signature);
		--			text_window.put_string ("%N");
		--		end;
		--		clients.forth;
		--	end
		end

end
