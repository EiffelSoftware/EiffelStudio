class MEL_SOCKET_POLLER

inherit
	SOCKET_POLLER
		rename
			make as poller_make,
			make_active as poller_make_active
		end 

	MEL_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (app_context: like application_context) is
			-- Create timer and socket_poller.
		do
			application_context := app_context;
			poller_make
			active := False
		end 

    make_active (app_context: like application_context; a_poll_delay: INTEGER) is
            -- Create timer and socket_poller.
            -- Set `a_poll_delay' to `delay_time'.
        do
            make (app_context)
            set_active (a_poll_delay) 
        end

feature -- Activation

	set_active (a_poll_delay: INTEGER) is
			-- Set `a_poll_delay' to `delay_time'. 
		do
			delay_time := a_poll_delay
			continue := True
			active := True
			application_context.set_time_out_callback (delay_time, Current, Void)
			timer_id := application_context.last_id
		end 

	set_inactive is
			-- Stop polling the socket.
		do
			if continue then
				continue := False
				timer_id.remove
				timer_id := Void
			end

			active := False
		ensure then
			not_continue: not continue
		end 

	is_poller_active: BOOLEAN is
			-- Is the poller active?
		do
			Result := active
		end 

feature -- Execute

	execute (arg: ANY) is
			-- Poll the socket.
		do
			poll

			if continue then
				active := False
				set_active (delay_time)
			end 
		end 

feature {NONE} -- Implementation

	application_context: MEL_APPLICATION_CONTEXT
			-- Application context of the Motif program

	timer_id: MEL_IDENTIFIER
			-- Timer identifier

	delay_time: INTEGER
			-- Time between polls (in msec)

	active, continue: BOOLEAN
			-- Status variables

end -- class MEL_SOCKET_POLLER


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

