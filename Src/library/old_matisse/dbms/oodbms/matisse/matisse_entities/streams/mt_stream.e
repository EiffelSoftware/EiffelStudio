deferred class MT_STREAM

inherit

	MATISSE_CONST
		export {NONE} all
		end

	MT_STREAM_EXTERNAL

	HANDLE_USE
		export {NONE} all
		end

feature -- Access

	next_object : DB_DATA is
		-- Get Next object in stream
		deferred
		end -- next_object

feature -- Close

	close is
		-- Close Stream
		do
			if not handle.status.is_ok_mat then handle.status.set_found(1) end -- Error or end :  close the stream
			c_close_stream(sid)
		end -- close

feature {DB_RESULT_MAT} -- Implementation

		sid : POINTER -- C pointer to stream

end -- class MT_STREAM
