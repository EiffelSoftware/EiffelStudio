indexing

        description:
                "Asynchronous socket polling, timer-based.";

        status: "See notice at end of class";
        date: "$Date$";
        revision: "$Revision$"

deferred class

	SOCKET_POLLER

feature -- Creation

	make is
			-- Create internal structure of poller.
		do
			make_listen_list;
			make_service_list;
			set_poll_all;
			set_no_discard
			
		end;

	make_active (a_poll_delay: INTEGER) is
			-- Create active poller with `a_poll_delay' time
			-- quantum (in milliseconds).
		do
			make;
			set_active (a_poll_delay)
		end


feature -- Activation

	set_active (a_poll_delay: INTEGER) is
			-- Activate poller timer with `a_poll_delay'
			-- time quantum (in milliseconds).
		require
			a_poll_delay_positive_and_not_null: a_poll_delay > 0;
			poller_inactive: not is_poller_active
		deferred
		end;

	set_inactive is
			-- Disactivate poller timer.
		require
			poller_active: is_poller_active
		deferred
		end;

	is_poller_active: BOOLEAN is
			-- Is poller called back?
		deferred
		end;

	is_poll_all: BOOLEAN;
			-- Are all subscribed socket polled at each timer call-
			-- back or just one?

	set_poll_one is
			-- Only one subscribed listening socket and one service
			-- socket will be polled at each poll delay (if present).
		do
			is_poll_all := False
		end;

	set_poll_all is
			-- All subscribed sockets will be polled at each poll
			-- delay.
		do
			is_poll_all := True
		end;

	is_auto_discard: BOOLEAN;
			-- Subscription is removed at call-back.

	set_auto_discard is
			-- Poller will call back only once.
		do
			is_auto_discard := True
		end;

	set_no_discard is
			-- Subsciption to polling remains after call-back.
		do
			is_auto_discard := False
		end


feature -- Subscription

	add_accept_call_back (a_stream_socket: STREAM_SOCKET; a_command: POLL_COMMAND; an_argument: ANY) is
			-- Set command	`a_command' to be called when
			-- `a_stream_socket' is connected.
		require
			stream_socket_open_read: a_stream_socket.is_open_read;
			command_not_void: a_command /= Void
		do
			listen_list_extend (a_stream_socket, a_command, an_argument)
		end;

	remove_accept_call_back (a_stream_socket: STREAM_SOCKET) is
			-- Remove socket `a_stream_socket' from call-back list.
		do
			listen_list_remove (a_stream_socket)
		end;

	add_readable_call_back (a_socket: SOCKET; a_command: POLL_COMMAND; an_argument: ANY) is
			-- Set command	`a_command' to be called when
			-- `a_socket' is readable.
		require
			socket_open_read: a_socket.is_open_read;
			command_not_void: a_command /= Void
		do
			service_list_extend (a_socket, a_command, an_argument)
		end;

	remove_readable_call_back (a_socket: SOCKET) is
			-- Remove socket `a_socket' from call-back list.
		do
			service_list_remove (a_socket)
		end;

	wipe_out_all_call_backs is
			-- Remove all socket call_backs from poller.
		do
			listen_socket_list.wipe_out;
			listen_command_list.wipe_out;
			listen_argument_list.wipe_out;
			listen_list_exhausted := True;
			service_socket_list.wipe_out;
			service_command_list.wipe_out;
			service_argument_list.wipe_out;
			service_list_exhausted := True
		end


feature {NONE} -- execution

	poll is
			-- Synchronously poll when called back by timer.
		local
			was_blocking, we_are_done: BOOLEAN;
			loc_stream_sock: STREAM_SOCKET
		do
			debug
				io.error.putstring ("Poller called%N")
			end;
			from
				if not service_list_empty then
					service_list_set_start
				end
			until
				service_list_exhausted or
					we_are_done
			loop
				if service_list_socket_item.readable then
					service_list_command_item.execute
						(service_list_argument_item);
					if is_auto_discard then
						service_list_remove (service_list_socket_item)
					end;
					if not is_poll_all then
						we_are_done := True
					end
				end;
				service_list_forth
			end;

			we_are_done := False;
			from
				if not listen_list_empty then
					listen_list_set_start
				end
			until
				listen_list_exhausted or
					we_are_done
			loop
				loc_stream_sock := listen_list_socket_item;
				if loc_stream_sock.is_blocking then
					was_blocking := True
				end;
				loc_stream_sock.set_non_blocking;
				loc_stream_sock.accept;
				if loc_stream_sock.accepted /= Void then
					listen_list_command_item.execute (listen_list_argument_item);
					if is_auto_discard then
						listen_list_remove (listen_list_socket_item)
					end;
					if not is_poll_all then
						we_are_done := True
					end
				end;
				listen_list_forth
			end
		end
			

feature {NONE} -- implementation

--x All the following should be provided exclusively by class LINKED_CIRCULAR.
--x since this facility is completely unusable (bug in put/remove, extend, etc.)
--x the changes will have to be performed when fixed up.

	listen_socket_list: LINKED_LIST [STREAM_SOCKET];
			-- List of listen sockets to poll for connection.

	listen_command_list: LINKED_LIST [POLL_COMMAND];
			-- List of commands to operate at connection.

	listen_argument_list: LINKED_LIST [ANY];
			-- List of argument to be passed.

	service_socket_list: LINKED_LIST [SOCKET];
			-- List of service sockets to poll for data.

	service_command_list: LINKED_LIST [POLL_COMMAND];
			-- List of commands to operate at data arrival.

	service_argument_list: LINKED_LIST [ANY];
			-- List of argument to be passed.

	make_listen_list is
			-- Create three sublists regarding listen sockets.
		do
			create listen_socket_list.make;
			create listen_command_list.make;
			create listen_argument_list.make;
			listen_list_exhausted := True
		end;

	make_service_list is
			-- Create three sublists regarding service sockets.
		do	
			create service_socket_list.make;
			create service_command_list.make;
			create service_argument_list.make;
			service_list_exhausted := True
		end;

	listen_list_extend (a_stream_socket: STREAM_SOCKET; a_command: POLL_COMMAND; an_argument: ANY) is
			-- Add `a_stream_socket' at the end of the circular,
			-- i.e. at position before cursor.
		do
			if listen_list_empty or else
					listen_list_isfirst then
				listen_socket_list.extend (a_stream_socket);
				listen_socket_list.start;
				listen_command_list.extend (a_command);
				listen_command_list.start;
				listen_argument_list.extend (an_argument);
				listen_argument_list.start
			else
				listen_socket_list.put_left (a_stream_socket);
				listen_command_list.put_left (a_command);
				listen_argument_list.put_left (an_argument)
			end
		end;

	listen_list_remove (a_stream_socket: STREAM_SOCKET) is
			-- Remove 'a_stream_socket' from subscribed listen list,
			-- cursor goes to previous item in circular.
		local
			i: INTEGER
		do
			i := listen_socket_list.index_of (a_stream_socket, 1);

			listen_socket_list.go_i_th (i);
			listen_socket_list.remove;

			listen_command_list.go_i_th (i);
			listen_command_list.remove;

			listen_argument_list.go_i_th (i);
			listen_argument_list.remove;

			if listen_socket_list.empty then
				listen_list_exhausted := True
			elseif listen_socket_list.after then
				listen_socket_list.start;
				listen_command_list.start;
				listen_argument_list.start
			end
		end;

	listen_list_empty: BOOLEAN is
			-- Is listen list empty?
		do
			Result := listen_socket_list.empty
		end;

	listen_list_after: BOOLEAN is
			-- Is underlying linked_list after?
		do
			Result := listen_socket_list.after
		end;

	listen_list_isfirst: BOOLEAN is
			-- Is underlying linked_list pointing first item?
		do
			Result := listen_socket_list.isfirst
		end;

	listen_list_socket_item: STREAM_SOCKET is
			-- Current socket item in listen list.
		do
			Result := listen_socket_list.item
		end;

	listen_list_command_item: POLL_COMMAND is
			-- Current command item in listen list.
		do
			Result := listen_command_list.item
		end;

	listen_list_argument_item: ANY is
			-- Current argument item in listen list.
		do
			Result := listen_argument_list.item
		end;

	listen_list_forth is
			-- One step ahead in listen_list, loop with first if
			-- after.
		do
			if not listen_list_empty then
				listen_socket_list.forth;
				listen_command_list.forth;
				listen_argument_list.forth;
				if listen_list_after then
					listen_socket_list.start;
					listen_command_list.start;
					listen_argument_list.start;
					if listen_socket_list.index_of (listen_list_socket_item, 1) = listen_list_start then
						listen_list_exhausted := True
					end
				end
			end
		end;

	listen_list_exhausted: BOOLEAN;
			-- Has listen_list been exhausted by traversal?

	listen_list_start: INTEGER;
			-- Index of start mark in underlying linked_list.

	listen_list_set_start is
			-- Set current item to be the mark for exhausted.
		do
			if not listen_list_empty then
				listen_list_start := listen_socket_list.index_of (listen_list_socket_item, 1);
				listen_list_exhausted := False
			else
				listen_list_exhausted := True
			end
		end;


	service_list_extend (a_socket: SOCKET; a_command: POLL_COMMAND; an_argument: ANY) is
			-- See listen_list comments.
		do
			if service_list_empty or else
					service_list_isfirst then
				service_socket_list.extend (a_socket);
				service_socket_list.start;
				service_command_list.extend (a_command);
				service_command_list.start;
 				service_argument_list.extend (an_argument);
				service_argument_list.start
	 		 else
	 			service_socket_list.put_left (a_socket);
				service_command_list.put_left (a_command);
 				service_argument_list.put_left (an_argument)
	 		 end
	 	 end;

	service_list_remove (a_socket: SOCKET) is
			-- See listen_list comments.
		local
			i: INTEGER
		do
			i := service_socket_list.index_of (a_socket, 1);

 			service_socket_list.go_i_th (i);
	 		service_socket_list.remove;

			service_command_list.go_i_th (i);
 			service_command_list.remove;

	 		service_argument_list.go_i_th (i);
			service_argument_list.remove;

			if service_socket_list.empty then
				service_list_exhausted := True
			elseif service_socket_list.after then
				service_socket_list.start;
				service_command_list.start;
				service_argument_list.start
			end
 		 end;

	service_list_empty: BOOLEAN is
			-- See listen_list comments.
	 	do
	 		Result := service_socket_list.empty
		end;

	service_list_after: BOOLEAN is
			-- See listen_list comments.
 		do
 			Result := service_socket_list.after
		end;

	service_list_isfirst: BOOLEAN is
			-- See listen_list comments.
 		do
 			Result := service_socket_list.isfirst
		end;

	service_list_socket_item: SOCKET is
			-- See listen_list comments.
 		do
 			Result := service_socket_list.item
		end;

	service_list_command_item: POLL_COMMAND is
			-- See listen_list comments.
 		do
 			Result := service_command_list.item
		end;

	service_list_argument_item: ANY is
			-- See listen_list comments.
 		do
 			Result := service_argument_list.item
		end;

	service_list_forth is
			-- See listen_list comments.
 		do
 			if not service_list_empty then
				service_socket_list.forth;
 				service_command_list.forth;
	 			service_argument_list.forth;
				if service_list_after then
 					service_socket_list.start;
	 				service_command_list.start;
					service_argument_list.start;
 					if service_socket_list.index_of (service_list_socket_item, 1) = service_list_start then
						service_list_exhausted := True
		 			end
		 		end
		 	end
		end;

	service_list_exhausted: BOOLEAN;
			-- See listen_list comments.

	service_list_start: INTEGER;
			-- See listen_list comments.

	service_list_set_start is
			-- See listen_list comments.
		do
			if not service_list_empty then
				service_list_start := service_socket_list.index_of (service_list_socket_item, 1);
				service_list_exhausted := False
			else
				service_list_exhausted := True
			end
		end

end -- class SOCKET_POLLER



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

