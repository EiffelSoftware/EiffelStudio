class VISION_SOCKET_POLLER

inherit
	SOCKET_POLLER
		rename
			make as poller_make
		end -- inherit SOCKET_POLLER

	COMMAND

creation
	make, make_active

feature -- Initialization

	make is
			-- Create timer and socket_poller.
		do
			poller_make
			!!timer.make
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
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
