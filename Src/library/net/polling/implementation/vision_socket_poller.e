class VISION_SOCKET_POLLER

inherit
	SOCKET_POLLER
		rename
			make as poller_make
		end -- inherit SOCKET_POLLER

	COMMAND

create
	make, make_active

feature -- Initialization

	make is
			-- Create timer and socket_poller.
		do
			poller_make
			create timer.make
		end

feature -- Activation

	set_active (a_poll_delay: INTEGER) is
            -- Set `a_poll_delay' to `delay_time'.
		do
			timer.set_regular_call_back (a_poll_delay, Current, Void)
		end

	set_inactive is
			-- Stop polling the socket.
		do
			timer.set_no_call_back
		end

	is_poller_active: BOOLEAN is
			-- Is the poller active?
		do
			Result := timer.is_call_back_set
		end 

feature -- Execute

	execute (arg: ANY) is
			-- Poll the socket.
		do
			poll
		end

feature {NONE} -- Timer

	timer: TIMER
		-- Timer to poll socket 'on time'

end -- class VISION_SOCKET_POLLER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

