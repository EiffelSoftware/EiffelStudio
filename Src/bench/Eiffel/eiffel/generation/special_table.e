indexing
	description: "Special routine table: dispose routine table and initialization routine table."
	date: "$Date$"
	revision: "$Revision$"

class SPECIAL_TABLE

inherit
	ROUT_TABLE
		redefine
			min_used, max_used, generate, final_table_size, used
		end

create
	make

feature

	min_used: INTEGER is 1
	max_used: INTEGER is
		do
			Result := System.type_id_counter.value
		end

	final_table_size: INTEGER is
			-- Size of C table
		require else
			True
		do
			Result := max_used
		end

	used: BOOLEAN is True
			-- Special tables are always used.

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the routine table in buffer "erout*.c".
		do
			if max_position = 0 then
				buffer.putstring ("char *(*");
				buffer.putstring (Encoder.table_name (rout_id));
				buffer.putstring ("[")
				buffer.putint (final_table_size)
				buffer.putstring ("])();");
				buffer.new_line
			else
				Precursor {ROUT_TABLE} (buffer)
			end
		end

	void_type: VOID_I is
			-- Void universal type
		once
			create Result
		end;

feature -- Sort

	sort_till_position is
			-- Sort from `lower' to last inserted `max_position'.
		do
			if max_position > 0 then
				quick_sort (lower, max_position)
			end
		end

end
