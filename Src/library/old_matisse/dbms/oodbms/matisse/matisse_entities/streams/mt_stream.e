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
			if not handle.status.is_ok then handle.status.set_found(1) end -- Error or end :  close the stream
			c_close_stream(sid)
		end -- close

feature {DB_RESULT_MAT} -- Implementation

		sid : POINTER -- C pointer to stream

end -- class MT_STREAM

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

