indexing
    description: "";
    date: "$Date$";
    revision: "$Revision$"

class
	CONSUMER

inherit
	THREAD

creation
	make

feature -- Initialization

	make (buf: PROXY [BUFFER]; i: INTEGER; finish: PROXY [BOOLEAN_REF]) is
			-- Initialize parameters, set proxies,  and launch thread.
		do
			p_buffer := buf
			p_finished := finish
			id := i
			launch
		end

feature	-- Shared access

	p_buffer: PROXY [BUFFER]
			-- Shared buffer.

	p_finished: PROXY[BOOLEAN_REF]
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
				p_finished.item.item
			loop
				p_buffer.item.get (id)
			end	
			p_buffer.item.monitor.lock
			io.put_string ("Consumer ")
			io.put_integer (id)
			io.put_string (" has terminated%N")		
			p_buffer.item.monitor.unlock
		end
end -- class CONSUMER

