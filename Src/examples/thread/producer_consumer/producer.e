indexing
    description: "";
    date: "$Date$";
    revision: "$Revision$"

class
	PRODUCER

inherit
	THREAD

creation
	make

feature	-- Initialization

	make (buf: PROXY [BUFFER]; i: INTEGER; finish: PROXY [BOOLEAN_REF]) is
			-- Initialize parameters, set proxies,  and launch thread.
		do
			p_finished:= finish
			p_buffer := buf
			id := i			
			launch
		end

feature	-- Shared access

	p_buffer: PROXY [BUFFER]
			-- Shared buffer.

	p_finished : PROXY [BOOLEAN_REF]
			-- Shared boolean for exiting.

feature	{NONE} -- Private access

	id : INTEGER
			-- Id of producer.

	data: INTEGER
			-- New data to put into buffer

feature -- Thread execution

	execute is
			-- Put an element into the buffer until user asks for exiting.
		do
			from
			until 
				p_finished.item.item
			loop
				data :=  ( data + 1)  \\ 10000
				p_buffer.item.put (data, id)			
			end	
			p_buffer.item.monitor.lock
			io.put_string ("Producer ")
			io.put_integer (id)
			io.put_string (" has terminated%N")	
			p_buffer.item.monitor.unlock
		end

end -- class PRODUCER 
