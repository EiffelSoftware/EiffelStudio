-- Direct access structure of ROUT_INFO objects indexed by the 
-- routine id's of the entire system.


class ROUT_INFO_TABLE

inherit

	HASH_TABLE [ROUT_INFO, ROUTINE_ID]
		rename
			make as ht_make,
			put as table_put
		end;
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_ARRAY_BYTE
		undefine
			copy, setup, consistent, is_equal
		end;
	COMPILER_EXPORTER
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create an empty table.
		do
			ht_make (n);
			!! offset_counters.make (n)
		end

feature -- Insertion

	put (rout_id: ROUTINE_ID; org: CLASS_C) is
			-- Record the routine id `rout_id', the origin 
			-- of the corresponding routine and the offset of 
			-- the routine in the origin class.
		require
			rout_id_not_void: rout_id /= Void;
			org_not_void: org /= Void
		local
			info: ROUT_INFO
		do
			if has (rout_id) then
					-- The routine id has been recorded 
					-- earlier.
				info := item (rout_id);
				if not equal (info.origin, org.id) then
						-- The origin of the routine has changed
						-- a new offset must be computed, and the
						-- origin value updated.
					info.set_offset (new_offset (org));
					info.set_origin (org.id)
				end;
			else
					-- The routine is brand new.
				!! info.make (org, new_offset (org));
				force (info, rout_id);
			end;
		end;

feature -- Offset processing

	new_offset (c: CLASS_C): INTEGER is
			-- New offset for class `c'. The routine offsets
			-- start from 0.
			--|Beware: this function has a side effect!
			--|Note: see if "obsolete" offsets could be reused.
		local
			class_id: CLASS_ID;
			counter: COUNTER
		do
			class_id := c.id;
			if not offset_counters.has (class_id) then
				!! counter;
					-- Routine offsets start from 0.
				counter.set_value (-1);
				offset_counters.put (counter, class_id)
			else
				counter := offset_counters.item (class_id)
			end;
			Result := counter.next
		end;

	offset_counters: HASH_TABLE [COUNTER, CLASS_ID];
			-- Offset counters for feature introducted
			-- in the corresponding class

feature -- Query features

	origin (rout_id: ROUTINE_ID): CLASS_C is
			-- Origin of routine of id `rout_id'
		require
			rout_id_not_void: rout_id /= Void;
			has_rout_id: has (rout_id)
		do
			Result := System.class_of_id (item (rout_id).origin)
		ensure
			origin_not_void: Result /= Void
		end;

	offset (rout_id: ROUTINE_ID): INTEGER is
			-- Offset of routine of id `rout_id'
			-- in origin class
		require
			rout_id_not_void: rout_id /= Void;
			has_rout_id: has (rout_id)
		do
			Result := item (rout_id).offset
		end;

	descriptor_size (class_id: CLASS_ID): INTEGER is
			-- Number of routines introduced
			-- in class of id `class_id'
		do
			if offset_counters.has (class_id) then
				-- Offsets start from 0.
				Result := offset_counters.item (class_id).value + 1
			end
		end;

	renumbered_table: ARRAY [ROUT_INFO] is
			-- Routine info indexed by routine ids after
			-- renumbering
		local
			rout_id, max: INTEGER
		do
			from start until after loop
				rout_id := key_for_iteration.id;
				if max < rout_id then
					max := rout_id
				end;
				forth
			end;
			!! Result.make (1, max);
			from
				start
			until
				after
			loop
				Result.put (item_for_iteration, key_for_iteration.id);
				forth
			end;
		end;

feature -- Generation

	C_string: STRING is
				-- C code of run-time structure representing Current
		local
			rout_infos: ARRAY [ROUT_INFO];
			nb_elements: INTEGER;
			i: INTEGER;
			ri: ROUT_INFO
		do
			rout_infos := renumbered_table;
			nb_elements := rout_infos.count;
			!!Result.make (0);
			Result.append ("#include %"macros.h%"%N%N");
			Result.append ("struct rout_info forg_table[] = {%N");
				-- C tables start at 0, we want to start at 1, to
				-- that effect we insert a dummy entry.
			Result.append ("%T{(int16) -1, (int16) -1},%N");
				-- Entry for the invariant "routine"
			Result.append ("%T{(int16) 0, (int16) 0},%N");
			from
				i := 2	
			until
				i > nb_elements
			loop
				ri := rout_infos.item (i);
				if ri /= Void then
					Result.append ("%T{(int16) ");
					Result.append_integer (ri.origin.id);
					Result.append (", (int16) ");
					Result.append_integer (ri.offset);
					Result.append ("},%N");
				else
					Result.append ("%T{(int16) -1, (int16) -1},%N")
				end;
				i := i + 1
			end;
			Result.put ('%N', Result.count - 1);
			Result.put ('}', Result.count);
			Result.append (";%N");
		end;

feature -- Melting

	melted: CHARACTER_ARRAY is
			-- Byte code of Current table.
			-- Format:
			--    1) Number of elements (uint32)
			--    2) Sequence of pairs (short, short)
		local
			rout_infos: ARRAY [ROUT_INFO];
			nb_elements: INTEGER;
			i: INTEGER;
			ri: ROUT_INFO
		do
			rout_infos := renumbered_table;
			nb_elements := rout_infos.count;

				-- Clear the byte array
			Byte_array.clear;

				-- Number of elements
			Byte_array.append_uint32_integer (nb_elements + 1);

				-- C tables start at 0, we want to start at 1, to
				-- that effect we insert a dummy entry.
			Byte_array.append_short_integer (-1);
			Byte_array.append_short_integer (-1);

				-- Entry for the invariant "routine"
			Byte_array.append_short_integer (0);
			Byte_array.append_short_integer (0);

			from
				i := 2	
			until
				i > nb_elements
			loop
				ri := rout_infos.item (i);
				if ri /= Void then
					Byte_array.append_short_integer (ri.origin.id);
					Byte_array.append_short_integer (ri.offset);
				else
					Byte_array.append_short_integer (-1);
					Byte_array.append_short_integer (-1);
				end;
				i := i + 1
			end;

				-- Return correctly sized structure.
			Result := Byte_array.character_array;
			Byte_array.clear
		end;

feature -- Trace

	trace is
		local
			rout_infos: ARRAY [ROUT_INFO];
			nb_elements: INTEGER;
			i: INTEGER
		do
			rout_infos := renumbered_table;
			nb_elements := rout_infos.count;
			from
				i := 1
			until
				i > nb_elements
			loop
				if rout_infos.item (i) /= Void then
					io.putstring ("Routine id: ");
					io.putint (i);
					rout_infos.item (i).trace;
					io.new_line
				end;
				i := i + 1
			end;
		end;

feature -- DLE

	dle_C_string: STRING is
			-- C code of run-time structure representing Current
		require
			dynamic_syatem: System.is_dynamic
		local
			rout_infos: ARRAY [ROUT_INFO];
			nb_elements: INTEGER;
			i: INTEGER;
			ri: ROUT_INFO
		do
			rout_infos := renumbered_table;
			nb_elements := rout_infos.count;
			!!Result.make (0);
			Result.append ("#include %"macros.h%"%N%N");
			Result.append ("static struct rout_info Dforg_table[] = {%N");
				-- C tables start at 0, we want to start at 1, to
				-- that effect we insert a dummy entry.
			Result.append ("%T{(int16) -1, (int16) -1},%N");
				-- Entry for the invariant "routine"
			Result.append ("%T{(int16) 0, (int16) 0},%N");
			from
				i := 2	
			until
				i > nb_elements
			loop
				ri := rout_infos.item (i);
				if ri /= Void then
					Result.append ("%T{(int16) ");
					Result.append_integer (ri.origin.id);
					Result.append (", (int16) ");
					Result.append_integer (ri.offset);
					Result.append ("},%N");
				else
					Result.append ("%T{(int16) -1, (int16) -1},%N")
				end;
				i := i + 1
			end;
			Result.put ('%N', Result.count - 1);
			Result.put ('}', Result.count);
			Result.append (";%N%Nvoid dle_ecall()%N%
					%{%N%Teorg_table = Dforg_table;%N}%N")
		end;

end
