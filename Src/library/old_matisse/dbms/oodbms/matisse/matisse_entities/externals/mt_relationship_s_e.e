class MT_RELATIONSHIP_STREAM_EXTERNAL
feature {NONE}

	c_open_relationship_stream (oid, rid: INTEGER): POINTER is
		external
			"C"
		end -- c_open_relationship_stream

end -- class MT_RELATIONSHIP_STREAM_EXTERNAL
