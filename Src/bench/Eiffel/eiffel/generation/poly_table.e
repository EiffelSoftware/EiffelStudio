-- Abstract representation of a routine-or-attribute offset table for
--the final Eiffel executable.

deferred class POLY_TABLE [T -> ENTRY]

inherit

	SORTED_TWO_WAY_LIST [T];
	IDABLE
		rename
			id as rout_id,
			set_id as set_rout_id
		end;
	SHARED_WORKBENCH;
	SHARED_CODE_FILES;
	SHARED_ARRAY_BYTE;
	SHARED_SERVER;
	SH_DEBUG;
	COMPILER_EXPORTER

feature

	rout_id: ROUTINE_ID;
			-- Routine id of the table

	set_rout_id (i: ROUTINE_ID) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i;
		end;

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		require
			positive: type_id > 0;
		deferred
		end;

	writer: TABLE_GENERATOR is
			-- Generator of tables which spilt the generation in several
			-- files.
		deferred
		end;

	write is
			-- Generation of the table through the writer
		require
			writer_exists: writer /= Void;
		do
			if generable then
				writer.generate (Current);
			end;
			if has_type_table and then not has_one_type then
				writer.generate_type_table (Current);
			end;
		end;

	generable: BOOLEAN is
			-- Has the table to be generated ?
		require
			not_empty: not empty
		do
--			Result := used and then is_polymorphic (min_used);
			Result := used;
		end;

	generate (file: INDENT_FILE) is
			-- Generation of the table for final Eiffel executable.
		deferred
		end;

	min_type_id: INTEGER is
			-- Minimum effecitve type id of the table ?
		require
			not empty;
		do
			Result := first.type_id;
		end;

	max_type_id: INTEGER is
			-- Maximum type id of the table ?
		require
			not empty;
		do
			Result := last.type_id;
		end;

	min_used: INTEGER is
			-- Minimum used type id ?
		require
			not empty;
			is_used: used;
		local
			entry: ENTRY;
			local_cursor: BI_LINKABLE [T]
		do
			from
				local_cursor := first_element
			until
				Result > 0
			loop
				entry := local_cursor.item;
				if entry.used then
					Result := entry.type_id;
				end;
				local_cursor := local_cursor.right
			end;
		end;

	max_used: INTEGER is
			-- Minimum used type id ?
		require
			not empty;
			is_used: used;
		local
			entry: ENTRY;
			local_cursor: BI_LINKABLE [T]
		do
			from
				local_cursor := last_element
			until
				Result > 0
			loop
				entry := local_cursor.item;
				if entry.used then
					Result := entry.type_id;
				end;
				local_cursor := local_cursor.left;
			end;
		end;

	used: BOOLEAN is
			-- Is the table effectively used ?
		local
			entry: ENTRY;
			local_cursor: BI_LINKABLE [T]
		do
			from
				local_cursor := first_element
			until
				local_cursor = Void or else Result
			loop
				entry := local_cursor.item;
				Result := entry.used;
				local_cursor := local_cursor.right
			end;	
		end;

	final_table_size: INTEGER is
			-- Size of the C table
		require
			not empty;
			is_used: used;
		do
			Result := max_used - min_used + 1;
		end;

	workbench_table_size: INTEGER is
			-- Size of the C table
		require
			not empty;
		do
			Result := max_type_id - min_type_id + 1
		end;

	has_type_id (type_id: INTEGER): BOOLEAN is
			-- Is a non-deferred entry present at index greater
			-- than `type_id' ?
		require
			positive: type_id > 0
		local
			old_cursor: CURSOR;
		do
			old_cursor := cursor;
			goto (type_id);
			Result := not after;
			go_to (old_cursor);
		end;
			
	goto (type_id: INTEGER) is
			-- Move cursor to the first entry of type_id `type_id' 
			-- associated to an effective class (non-deferred).
		require
			positive: type_id > 0;
		do
			from
				start
			until
				after or else item.type_id >= type_id
			loop
				forth
			end;
		end;

	goto_used (type_id: INTEGER) is
			-- Move cursor to the first entry of type_id `type_id'
			-- associated to an used effective class (non-deferred).
		require
			positive: type_id > 0;
		local
			stop: BOOLEAN;
			entry: ENTRY;
		do
			from
				start
			until
				after or else stop
			loop
				entry := item;
				stop := entry.type_id >= type_id and then entry.used;
				forth
			end;
			if stop then
				back
			end;
		end;

	has_type_table: BOOLEAN is
			-- Is a type table needed for the current table ?
		do
			Result := System.type_set.has (rout_id);
		end;

	has_one_type: BOOLEAN is
			-- Is the type table not polymorphic ?
		require
			not_empty: not empty;
		local
			first_type: INTEGER;
			entry: ENTRY;
		do
			from
				goto (min_type_id);
				first_type := item.feature_type_id;
				forth;
				Result := True;
			until
				after or else not Result
			loop
				entry := item;
				Result := entry.feature_type_id = first_type;
				forth;
			end;
		end;

	generate_type_table (file: INDENT_FILE) is
			-- Generate the associated type table in final mode.
		local
			i, nb: INTEGER;
			entry: ENTRY;
			c_name: STRING;
		do
			file.putstring ("int16 ");
			c_name := rout_id.type_table_name;
			file.putstring (c_name);
			from
				file.putstring ("[] = {%N");
				i := min_type_id;
				goto (i);
				nb := max_type_id;
			until
				i > nb
			loop
				entry := item;
				if i = entry.type_id then
					entry := item;
					file.putint (entry.feature_type_id - 1);
					file.putchar (',');
					forth;
				else
					file.putstring ("0,");
				end;
				file.new_line;

				i := i + 1;
			end;
			file.putstring ("};%N%N");

		end;

	workbench_c_type: STRING is
			-- Associated C item structure name
		deferred
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for the current poly table.
		require
			good_argument: ba /= Void;
			not_empty: not empty;
		local
			local_cursor: BI_LINKABLE [T];
			entry: T;
		do
			make_header_code (ba);

				-- Entries byte code
			from
				local_cursor := first_element
			until
				local_cursor = Void
			loop
				local_cursor.item.make_byte_code (ba);
				local_cursor := local_cursor.right
			end;
			if has_type_table then
				ba.append ('%/001/');
				from
					local_cursor := first_element
				until
					local_cursor = Void
				loop
					entry := local_cursor.item;
					ba.append_short_integer (entry.type_id - 1);
					ba.append_short_integer (entry.feature_type_id - 1);
					local_cursor := local_cursor.right
				end;
			else
				ba.append ('%U');
			end;
		end;

	make_header_code (ba: BYTE_ARRAY) is
			-- Make header byte code
		do
				-- Routine id
			ba.append_int32_integer (rout_id.id);
				-- King of poly table: attribute / routine
			if is_routine_table then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;
				-- Minimum dynamic type
			ba.append_short_integer (min_type_id - 1);
				-- Maximum dynamic type
			ba.append_short_integer (max_type_id - 1);
				-- Count
			ba.append_short_integer (count);
		end;

	is_routine_table: BOOLEAN is
			-- Is the current table a routine table ?
		do
			-- Do nothing
		end;

	is_attribute_table: BOOLEAN is
			-- Is the current table an attribute table ?
		do
			-- Do nothing
		end;

end
