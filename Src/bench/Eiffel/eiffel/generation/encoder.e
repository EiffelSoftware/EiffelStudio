-- Encoder of C generate names

class ENCODER 

inherit

	SHARED_WORKBENCH
	
feature 

	feature_name (id: INTEGER; body_id: INTEGER): STRING is
			-- Name of an Eiffel feature belonging to type of id `id'
			-- and of body id `body_id'.
		require
			good_type_id: id <= System.static_type_id_counter.total_count;
			good_body_id: body_id <= System.body_id_counter.value;
		local
			old_body_id: INTEGER
		do
			Result := Buffer;
			if System.is_dynamic then
				if System.in_final_mode then
					old_body_id :=
						System.dle_finalized_nobid_table.item (body_id)
				else
					old_body_id := System.dle_frozen_nobid_table.item (body_id)
				end;
				eif000 ($Result, id, old_body_id)
			else
				eif000 ($Result, id, body_id)
			end
		end;

feature {NONE}

	Address_table_buffer: STRING is
			-- String buffer
		once
			!! Result.make (7)
			Result.append ("e000000");
		end;

	Buffer: STRING is
			-- String buffer
		once
			!!Result.make (7);
			Result.append ("E000000");
		end;

feature {NONE} -- External features

	eif000 (s: POINTER; i,j: INTEGER) is
		external
			"C"
		end;

	eif101 (s: POINTER; i: INTEGER) is
		external
			"C"
		end;

	eif011 (s: POINTER; i: INTEGER) is
		external
			"C"
		end;

end
