class MT_ENTRYPOINT_STREAM_EXTERNAL
feature {NONE}

	c_open_ep_stream (name: POINTER; aid, cid: INTEGER): POINTER is
		external
			"C"
		end -- c_open_ep_stream

end -- class MT_ENTRYPOINT_STREAM_EXTERNAL
