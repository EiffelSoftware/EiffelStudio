class DB_RESULT_MAT

inherit

	HANDLE_STREAM
		export {NONE} all
		end

	DB_RESULT_I

	MT_STREAM_EXTERNAL

	DB_STATUS_USE

feature -- Status stetting

	fill_in (descriptor_index: INTEGER) is
		-- Load object from stream
		local
			one_object : MT_OBJECT
		do
			if Last_object.item /= Void then 
				data := Last_object.item 
			else 
				data := Last_stream.item.next_object
			end
		end -- fill_in

	update_map_table (object: ANY) is
		-- Do nothing : map_table not used
		do
		end -- update_map_table

feature -- Access

	data : DB_DATA -- Contains current object in stream

	map_table: ARRAY [INTEGER] is
		-- Void object
		do
 		end -- map_table

end -- class DB_RESULT_MAT
