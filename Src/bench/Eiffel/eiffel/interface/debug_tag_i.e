class DEBUG_TAG_I 

inherit

	DEBUG_I
		redefine
			is_partial
		end;

	COMPILER_EXPORTER

create

	make

	
feature 

	tags: TWO_WAY_SORTED_SET [STRING];
			-- Debug tags

	make is
		do
			create tags.make;
			tags.compare_objects
		end;

	is_partial: BOOLEAN is
			-- Is the debug option a partial one ?
		do
			Result := True;
		end;

	is_debug (tag: STRING): BOOLEAN is
			-- Is `tag' compatible with current debug option value ?
		do
			Result := tags.has (tag);
		end;

	merge (o: like Current) is
			-- Merge tags of `o' into `tags'.
		require
			good_argument: o /= Void;
		do
			tags.merge (o.tags);
		end;

	trace is
			-- Debug purpose
		local
			l: LINKED_LIST [STRING];
			old_cursor: CURSOR;
		do
			from
				io.error.put_string ("tags: ");
				l := tags;
				old_cursor := l.cursor;
				l.start;
			until
				l.after
			loop
				io.error.put_string (l.item);
				io.error.put_string (" ");
				l.forth;
			end;
			l.go_to (old_cursor);
		end;

	generate (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate assertion value in `buffer'.
		do
			buffer.put_string ("{OPT_ALL, (int16) ");
			buffer.put_integer (tags.count);
			buffer.put_string (", keys");
			buffer.put_integer (id);
			buffer.put_string ("}");
		end;

	generate_keys (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate keys C array
		require
			good_argument: buffer /= Void;
		local
			l: SORTED_TWO_WAY_LIST [STRING];
		do
			buffer.put_string ("static char *keys");
			buffer.put_integer (id);
			buffer.put_string ("[] = {");
			from
				l := tags;
				l.start
			until
				l.after
			loop
				buffer.put_character ('"');
				buffer.put_string (l.item);
				buffer.put_string ("%", ");
				l.forth;		
			end;
			buffer.put_string ("};%N%N");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		local
			l: SORTED_TWO_WAY_LIST [STRING];
		do
			from
				ba.append ({DB_CONST}.Db_tag);
				ba.append_short_integer (tags.count);
				l := tags;
				l.start
			until
				l.after
			loop
				ba.append_string (l.item);
				l.forth;
			end;
		end;

end
