indexing
 
	description:
		"Routine identifier sets.";
	date: "$Date$";
	revision: "$Revision $"

class ROUT_ID_SET 

inherit

	ARRAY [ROUTINE_ID]
		rename
			make as array_create,
			put as array_put,
			count as array_count,
			force as array_force,
			empty as array_empty,
			full as array_full, 
			has as array_has,
			wipe_out as array_wipe_out
		export
			{NONE} array_create, array_put, array_count, array_force,
				array_empty, array_full, array_has, array_wipe_out
		end

	COMPILER_EXPORTER
		undefine
			copy, setup, is_equal, consistent
		end

creation

	make

feature -- Initialization
	
	make (n: INTEGER) is
			-- Array creation
		do
			array_create (1, n);
		end;

feature -- Properties

	count: INTEGER;
			-- Number of routine ids present in the set

feature -- Access

	first: ROUTINE_ID is
			-- First routine id
		require
			not_empty: not empty
		do
			Result := item (1);
		ensure
			first_not_void: Result /= Void
		end;

	empty: BOOLEAN is
			-- Is the set empty ?
		do
			Result := count = 0;
		end;

	has (rout_id: ROUTINE_ID): BOOLEAN is
			-- Is the routine id `rout_id' present in the set ?
		require
			rout_id_not_void: rout_id /= Void
		local
			i: INTEGER
		do
			from
				i := 1;
			until
				i > count or else Result
			loop
				Result := rout_id.is_equal (item (i));
				i := i + 1;
			end;
		end;

	same_as (other: like Current): BOOLEAN is
			-- Has `other' the same content than Current ?
		require
			good_argument: other /= Void
		local
			i: INTEGER;
		do
			if count = other.count then
				from
					i := 1;
					Result := True;
				until
					i > count or else not Result
				loop
					Result := other.has (item (i));
					i := i + 1;
				end
			end;
		end;

feature -- Output

	trace is
			-- Debug purpose
		local
			i: INTEGER
		do
			io.error.putchar ('[');
			from
				i := 1;
			until
				i > count
			loop
				item (i).trace;
				io.error.putchar (' ');
				i := i + 1;
			end;
			io.error.putchar (']');
		end;

feature {COMPILER_EXPORTER}

	full: BOOLEAN is
			-- Is the set full ?
		do
			Result := count = array_count;
		end;

	put (rout_id: ROUTINE_ID) is
			-- Insert routine id `rout_id' in the set if not already
			-- present.
		require
			rout_id_not_void: rout_id /= Void;
			not_full: not full;
		local
			temp: ROUTINE_ID
		do
			if not has (rout_id) then
					-- Routine id `rout_id' is not present in the set
				count := count + 1;
				array_put (rout_id, count);
				-- Processing for attribute table:
				-- Since the byte code inspect the first value of this	
				-- routine id set, if there are thw ids one for a routine
				-- table and another one for an attribute table, the one
				-- for the attribute table must be in first position;
				if rout_id.is_attribute and not first.is_attribute then
					temp := item (1);
					array_put (rout_id, 1);
					array_put (temp, count);
				end;
			end;
		end;

	force (rout_id: ROUTINE_ID) is
			-- Insert routine id `rout_id' in the set if not already
			-- present. Resize the array if needed.
		require
			rout_id_not_void: rout_id /= Void
		local
			temp: ROUTINE_ID
		do
			if not has (rout_id) then
					-- Routine id `rout_id' is not present in the set.
				if count >= array_count then
						-- Resize needed
					resize (1, array_count + Chunk);
				end;
				count := count + 1;
				array_put (rout_id, count);
					-- See comment in `put'
				if rout_id.is_attribute and not first.is_attribute then
					temp := item (1);	
					array_put (rout_id, 1);
					array_put (temp, count);
				end;
			end;
		end;

	has_attribute_origin: BOOLEAN is
			-- Is in the routine id set an attribute offset table id ?
		require
			not_empty: not empty
		do
			Result := first.is_attribute
		end;
			
	update (l: LINKED_LIST [INHERIT_INFO]) is
			-- Update through inherited features in `l'.
		require
			good_argument: not (l = Void or else l.empty);
		do
			from
				l.start;
			until
				l.after
			loop
				merge (l.item.a_feature.rout_id_set);
				l.forth
			end;
		end;

	merge (other: like Current) is
			-- Put routine ids of `other' not present in Current.
		require
			good_argument: other /= Void;
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := other.count;
			until
				i > nb
			loop
				force (other.item (i));
				i := i + 1;
			end;
		end;

	wipe_out is
			-- Clear the structure.
		do
			count := 0
			clear_all
		end;

feature {NONE}

	Chunk: INTEGER is 5;
			-- Array chunk

end
