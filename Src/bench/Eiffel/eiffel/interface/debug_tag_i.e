class DEBUG_TAG_I 

inherit

	DEBUG_I
		redefine
			is_partial
		end

creation

	make

	
feature 

	tags: SORTED_SET [STRING];
			-- Debug tags

	make is
		do
			!!tags.make;
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
			pos: INTEGER;
		do
			from
				io.error.putstring ("tags: ");
				l := tags;
				pos := l.position;
				l.start;
			until
				l.after
			loop
				io.error.putstring (l.item);
				io.error.putstring (" ");
				l.forth;
			end;
			l.go (pos);
		end;

	generate (file: UNIX_FILE; id: INTEGER) is
			-- Generate assertion value in `file'.
		do
			file.putstring ("{DB_ALL, (int16) ");
			file.putint (tags.count);
			file.putstring (", keys");
			file.putint (id);
			file.putstring ("}");
		end;

	generate_keys (file: UNIX_FILE; id: INTEGER) is
			-- Generate keys C array
		require
            good_argument: file /= Void;
            is_open: file.is_open_write;
		local
			l: SORTED_TWO_WAY_LIST [STRING];
		do
			file.putstring ("static char *keys");
			file.putint (id);
			file.putstring ("[] = {");
			from
				l := tags;
				l.start
			until
				l.after
			loop
				file.putchar ('"');
				file.putstring (l.item);
				file.putstring ("%", ");
				l.forth;		
			end;
			file.putstring ("};%N%N");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		local
			l: SORTED_TWO_WAY_LIST [STRING];
		do
			from
				ba.append (Db_tag);
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
