class MT_TIME_STREAM 

inherit 


	MT_STREAM
		rename next_object as obsolete_next_object    
		export {NONE} obsolete_next_object
		undefine close
		end

	MT_TIME_STREAM_EXTERNAL

Creation {MT_CLASS} 

	make

feature {NONE} -- Implementation

	make is
		-- starts the enumeration of the versions that exist in the database
		do
			sid := c_time_enum_start
		end -- make

	next_time : STRING is
		-- String associated with the next version in the stream
		do
			!!Result.make(255)
			Result.from_c(c_next_time(sid))
		end -- next_time

	close is 
			-- Close the stream of the versions
		do
			c_time_enum_end(sid)
		end -- close

	obsolete_next_object : DB_DATA is
		-- Void object
		do
		end -- obsolete_next_object

end -- class MT_TIME_STREAM
