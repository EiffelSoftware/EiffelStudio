-- Dispatch table: table fo correspondance between body indexes and
-- body ids

class DISPATCH_TABLE 

inherit

	CENTRAL_TABLE [DISPATCH_UNIT];
	SHARED_SERVER
		undefine
			twin
		end

creation

	init
	
feature 

	unit_of_body_index (body_index: INTEGER; type_id: INTEGER): DISPATCH_UNIT is
			-- Unit associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type of type id `type_id'.
		do
			Marker.set_body_index (body_index);
			Marker.set_class_type (System.class_type_of_id (type_id));
			Result := item (Marker);
		end;

	real_body_index (body_index: INTEGER; type_id: INTEGER): INTEGER is
			-- Body id associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type of type id `type_id'.
		local
			unit: DISPATCH_UNIT;
		do
			unit := unit_of_body_index (body_index, type_id);
			if not (unit = Void) then
				Result := unit.real_body_index;
			end;
		end;

	Marker: DISPATCH_UNIT is
			-- Marker for search
		local
			f: DYN_PROC_I;
		once
			!!f;
			f.set_body_index (1);
			!!Result.make (System.class_type_of_id (1), f);
		end;

	make_update (file: UNIX_FILE) is
			-- Generate byte code for updating the dispatch table
		
				-- 2.3 PATCH: dump long integer `v' in file `f'	
		local
			u: DISPATCH_UNIT;
		do
				-- Write first the new size of the dispatch table
			write_int (file.file_pointer, count);

			from
				melted_list.start
			until
				melted_list.offright
			loop
				u := melted_list.item;
				if u.is_valid then
					write_int (file.file_pointer, u.real_body_index - 1);
					write_int (file.file_pointer, u.real_body_id - 1);
					melted_list.forth;
				else
					melted_list.remove;
				end;
			end;
				-- End of update for the dispatch table
			write_int (file.file_pointer, -1);
		end;

	generate (file: UNIX_FILE) is
			-- Generate the dispatch table in `file'.
		require
			good_argument: file /= Void;
			is_open: file.is_open_write;
		local
			values: ARRAY [INTEGER];
			unit: DISPATCH_UNIT;
			i, nb: INTEGER;
		do
			from
				nb := count;
				!!values.make (1, nb);
				start
			until
				offright
			loop
				unit := item_for_iteration;
				values.put (unit.real_body_id - 1, unit.real_body_index);
				forth;
			end;
			from
				i := 1;
				file.putstring ("#include %"portable.h%"%N%N");
				file.putstring ("uint32 fdispatch[] = {%N");
			until
				i > nb
			loop
				file.putstring ("(uint32) ");
				file.putint (values.item (i));
				file.putchar (',');
				file.new_line;
				i := i + 1;
			end;
			file.putstring ("};%N");
		end;

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
			-- Write integer `v' in file `f'.
		external
			"C"
		end;

end
