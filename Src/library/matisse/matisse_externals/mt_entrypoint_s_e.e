indexing
	description: "External methods for class MT_ENTRY_POINT_STREAM."

class
	MT_ENTRYPOINT_STREAM_EXTERNAL

feature {NONE}

	c_open_entry_point_stream (name: POINTER; aid, cid, nb_obj_per_call: INTEGER): INTEGER is
		external
			"C"
		end

end -- class MT_ENTRYPOINT_STREAM_EXTERNAL
