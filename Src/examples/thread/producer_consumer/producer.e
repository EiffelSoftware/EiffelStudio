indexing
    description: "";
    date: "$Date$";
    revision: "$Revision$"

class
	PRODUCER

inherit
	THREAD

create
	make

feature	-- Initialization

	make (buf: BUFFER; i: INTEGER; finish: BOOLEAN_REF) is
			-- Initialize parameters, set proxies,  and launch thread.
		do
			finished:= finish
			buffer := buf
			id := i			
			launch
		end

feature	-- Shared access

	buffer: BUFFER
			-- Shared buffer.

	finished: BOOLEAN_REF
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

end -- class PRODUCER 
