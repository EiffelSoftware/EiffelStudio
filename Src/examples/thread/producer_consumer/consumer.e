indexing
    description: "";
    date: "$Date$";
    revision: "$Revision$"

class
	CONSUMER

inherit
	THREAD

create
	make

feature -- Initialization

	make (buf: BUFFER; i: INTEGER; finish: BOOLEAN_REF) is
			-- Initialize parameters, set proxies,  and launch thread.
		do
			buffer := buf
			finished := finish
			id := i
			launch
		end

feature	-- Shared access

	buffer: BUFFER
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
end -- class CONSUMER

