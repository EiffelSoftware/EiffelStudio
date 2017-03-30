note
	legal: "See notice at end of class."
	status: "See notice at end of class.";
    date: "$Date$";
    revision: "$Revision$"

class
	PRODUCER

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature {NONE} -- Initialization

	make (buf: PC_BUFFER; i: INTEGER; finish: BOOLEAN_REF)
			-- Initialize parameters, set proxies,  and launch thread.
		do
			thread_make
			finished:= finish
			buffer := buf
			id := i
			launch
		end

feature	-- Shared access

	buffer: PC_BUFFER
			-- Shared buffer.

	finished: BOOLEAN_REF
			-- Shared boolean for exiting.

feature	{NONE} -- Private access

	id : INTEGER
			-- Id of producer.

	data: INTEGER
			-- New data to put into buffer

feature -- Thread execution

	execute
			-- Put an element into the buffer until user asks for exiting.
		do
			from
			until
				finished.item
			loop
				data :=  ( data + 1)  \\ 10000
				buffer.put (data, id)
			end
			buffer.monitor.lock
			io.put_string ("Producer ")
			io.put_integer (id)
			io.put_string (" has terminated%N")
			buffer.monitor.unlock
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
