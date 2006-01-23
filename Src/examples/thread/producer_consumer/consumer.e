indexing
    description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class.";
    date: "$Date$";
    revision: "$Revision$"

class
	CONSUMER

inherit
	THREAD

create
	make

feature -- Initialization

	make (buf: PC_BUFFER; i: INTEGER; finish: BOOLEAN_REF) is
			-- Initialize parameters, set proxies,  and launch thread.
		do
			buffer := buf
			finished := finish
			id := i
			launch
		end

feature	-- Shared access

	buffer: PC_BUFFER
			-- Shared buffer.

	finished: BOOLEAN_REF
			-- Shared boolean for exiting.
	
feature {NONE} -- Private Access

	id: INTEGER
			-- Id of Consumer.

feature -- Thread execution

	execute is
			-- Get elements from buffer until the user asks for exiting.
		do
			from
			until 
				finished.item
			loop
				buffer.get (id)
			end	
			buffer.monitor.lock
			io.put_string ("Consumer ")
			io.put_integer (id)
			io.put_string (" has terminated%N")		
			buffer.monitor.unlock
		end
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CONSUMER


