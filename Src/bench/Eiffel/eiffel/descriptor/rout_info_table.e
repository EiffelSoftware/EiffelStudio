-- Direct access structure of ROUT_INFO objects indexed by the 
-- routine id's of the entire system.


class ROUT_INFO_TABLE

inherit

	ARRAY [ROUT_INFO]
		rename
			make as array_make,
			put as array_put
		end;
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_ARRAY_BYTE
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make

feature -- Creation and Resizing

	nb_elements: INTEGER;
			-- Actual number of elements in the table

	Growth_factor: INTEGER is 500;
			-- Number of new entries to be added to
			-- the table when full

	make is
			-- Create an empty table.
		do
			array_make (1, Growth_factor);
			!!offset_counters.make (1, 0) 
		end;

	init is
			-- Initialize the table so that it takes the 
			-- total number of classes in the system into
			-- account.
		do
			offset_counters.resize (1, System.id_array.count);	
		end;

feature -- Insertion

	put (r_id: INTEGER; org: CLASS_C) is
			-- Record the routine id `rout_id', the origin 
			-- of the corresponding routine and the offset of 
			-- the routine in the origin class.
		local
			info: ROUT_INFO;
			rout_id: INTEGER
		do
				-- Take care of the case where the
				-- new routine is an attribute.
			if r_id < 0 then rout_id := - r_id else rout_id := r_id end;

			if rout_id <= capacity then
				info := item (rout_id);
			end;


			if info /= Void then
					-- The routine id has been recorded 
					-- earlier.
				if info.origin /= org.id then
						-- The origin of the routine has changed
						-- a new offset must be computed, and the
						-- origin value updated.
					info.set_offset (new_offset (org));
					info.set_origin (org.id)
				end;
			else
					-- The routine is brand new.
				!! info.make (org.id, new_offset (org));
				force (info, rout_id);
			end;

				-- Update the number of elements.
			if (rout_id > nb_elements) then 
				nb_elements := rout_id
			end
		end;

feature -- Offset processing

	offset_counters: ARRAY [INTEGER];
			-- Array indexed by CLASS_C id's
			-- The entry for a given class id corresponds
			-- to the number of origins recorded so far for
			-- that class.

	new_offset (c: CLASS_C): INTEGER is
			-- New offset for class `c'. The routine offsets
			-- start at 0.
			--|Beware: this function has a side effect!
			--|Note: see if "obsolete" offsets could be reused.
		do
			Result := offset_counters.item (c.id) + 1;
			offset_counters.put (Result, c.id);
			Result := Result - 1;
		end;

feature -- Query features

	origin (rout_id: INTEGER): CLASS_C is
			-- Origin of routine of id `rout_id'
		do
			Result := System.id_array.item (item (rout_id).origin)
		end;

	offset (rout_id: INTEGER): INTEGER is
			-- Offset of routine of id `rout_id'
			-- in origin class
		do
			Result := item (rout_id).offset
		end;

	descriptor_size (c: CLASS_C): INTEGER is
			-- Number of routines introduced
			-- in class 'c'
		do
			Result := offset_counters.item (c.id)
		end;

feature -- Generation

	C_string: STRING is
				-- C code of run-time structure representing Current
		local
			i: INTEGER;
			ri: ROUT_INFO
		do
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
				ri := item (i);
				if ri /= Void then
					Result.append ("%T{(int16) ");
					Result.append_integer (ri.origin);
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
			i: INTEGER;
			ri: ROUT_INFO
		do
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
				ri := item (i);
				if ri /= Void then
					Byte_array.append_short_integer (ri.origin);
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
			i: INTEGER
		do
			from
				i := 1
			until
				i > nb_elements
			loop
				if item (i) /= Void then
					io.putstring ("Routine id: ");
					io.putint (i);
					item (i).trace;
					io.new_line
				end;
				i := i + 1
			end;
		end;

end
