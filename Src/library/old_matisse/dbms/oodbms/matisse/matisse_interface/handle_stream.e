class HANDLE_STREAM 

feature -- Implementation

	Last_stream : CELL[MT_STREAM] is
		-- Current opened stream
		once 
			!!Result.put(Void)
		end -- Last_stream

	Last_object : CELL[DB_DATA] is
		-- Last object read
		once 
			!!Result.put(Void)
		end -- Last_object

end -- class HANDLE_STREAM
