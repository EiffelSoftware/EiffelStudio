deferred class MT_STREAMABLE 

feature {NONE}  -- Access 

	next_object : DB_DATA is
		-- Next Object in Stream
		do
			Result := stream.next_object
		end -- next_object

feature {NONE} -- Implementation

	stream : MT_STREAM is
		deferred
		end -- stream

end -- class MT_STREAMABLE
