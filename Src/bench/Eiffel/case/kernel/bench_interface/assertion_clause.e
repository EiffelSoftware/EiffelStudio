indexing

	description: "Index information.";
	date: "$Date$";
	revision: "$Revision $"

class ASSERTION_CLAUSE

inherit

	TAG_INFO
		redefine
			setup_namer, focus, clickable_string
		end;
	LINKABLE_ELEMENT_DATA
		redefine
			is_in_class_content
		end;

creation

	make, make_from_storer

feature -- Properties

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.index_cursor
		end;
	
	stone_type: INTEGER is
		do
			Result := Stone_types.index_type
		end;

	destroy_command (a_data: LINKABLE_DATA): DESTROY_LIST_ELEMENT is
		do
			--!! Result.make (a_data, a_data.chart.indexes, Current);
		end;

	is_in_class_content: BOOLEAN is
			--| (Even though Current maybe
			--| used for cluster this query
			--| will only be done for class data)
		do
			Result := True
		end;

feature -- Setting

	setup_namer (namer: NAMER_WINDOW) is
		do
			namer.set_up (True, False);
			namer.set_tag_id (tag);
			namer.set_tag_text (text);
			namer.set_tag_not_empty;
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
--			ld: LINKABLE_DATA;
--			chart: CHART;
		do
--			ld ?= data;
--			if ld /= Void then
--				chart := ld.chart
--			end;
--			Result := ld /= Void and then chart /= Void and then
--						chart.indexes /= Void and then
--						chart.indexes.has (Current);
		end;

	illegal_characters (tg, txt: STRING): BOOLEAN is
		local
			i: INTEGER;
			ch: CHARACTER;
			between_quotes: BOOLEAN;
		do
			from
				i := 1
			until
				i > tg.count or else Result
			loop
				ch := tg.item (i);
				Result := ch /= '_' and then
							(ch < '0' or ch > '9') and then
							(ch < 'A' or ch > 'Z') and then
							(ch < 'a' or ch > 'z');
				i := i + 1;
			end;
			if not Result then
				from
					i := 1
				until
					i > txt.count or else Result
				loop
					ch := txt.item (i);
					if ch = '%"' then
						between_quotes := not between_quotes;
					end;
					if not between_quotes then
						Result := (ch /= '_' and then
									ch /= ' ' and then
									ch /= ',' and then
									ch /= '%"' and then
									(ch < '0' or ch > '9') and then
									(ch < 'A' or ch > 'Z') and then
									(ch < 'a' or ch > 'z'));
					end;
					i := i + 1;
				end;
			end;
		end;

feature -- Element change

	insert_before (data_cont: LINKABLE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		local
			swap: SWAP_ELEMENT_U
		do
			--!! swap.make (data_cont, data_cont.chart.indexes, Current, a_data)
		end;

feature -- redefinition ( pascalf, to have a good generation )
	
	focus, clickable_string : STRING is
		do
			!! Result.make ( 0 )
			if tag/= Void and then not tag.empty then
				Result.append ( tag )
				REsult.append (": ")
			end
			-- here are the changes ...
			if text.count>1 then
				if not text.item(1).is_equal('"') then
					Result.append("%"")
				end
				Result.append ( text )
				if not text.item(text.count).is_equal ('"') then
					Result.append("%"")
				end
			end
			if text.count=0 then
				Result.append("%"%"")
			end
		end

end -- class INDEX_DATA
