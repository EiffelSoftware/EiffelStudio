
indexing
    description: "";
    date: "$Date$";
    revision: "$Revision$"


class
	PC
			-- Root class.
inherit
	THREAD_CONTROL
			-- For join_all.

create
	make

feature -- Customizable parameters

	it ,size, n_c, n_p: INTEGER
			-- Period of displaying, size of buffer,
			-- number of consumers and producers.

feature	-- Access

	buffer: BUFFER
			-- Global buffer.

	finished: BOOLEAN_REF
			-- Boolean reference for exiting.
			-- It has not to be expanded so that we can put it into a proxy.

feature	-- Initialization

	make is
			-- Customization, initilialization, execution.
		local 
			consumer: CONSUMER
			producer: PRODUCER	
			i : INTEGER
		do
			
			io.put_string ("##################################################%
						%%N# Producer-consumer example using eiffel threads.#%
						%%N# Enter the number of procucers, consumers, size #%
						%%N# of the shared buffer and a period n.           #%
						%%N# A producer puts a number in the shared buffer  #%
						%%N# while a consumer removes one from it. Every n  #%
						%%N# operations, the buffer is displayed and a      #%
						%%N# prompt will ask you whether you want to        #%
						%%N# continue or not.                               #%
						%%N##################################################%N")

			io.put_string ("%N******* PRODUCER-CONSUMER *********%N")
			io.put_string ("Number of producers:")
			io.read_integer
			n_p := io.last_integer
			
			io.put_string ("Number of consumers:")
			io.read_integer
			n_c := io.last_integer

			io.put_string ("Size of buffer:")
			io.read_integer
			size := io.last_integer
				
			io.put_string ("Iterations for displaying buffer (0 -> never)")
			io.read_integer
			it  :=  io.last_integer
			create finished
			create buffer.make (size, it, finished)

			from
				i := 1
			until
				i > n_p
			loop
				create producer.make (buffer, i, finished)
				i := i + 1
			end
			from
				i := 1
			until
				i > n_c
			loop
				create consumer.make (buffer, i,  finished)
				i := i + 1
			end
			join_all			
			io.put_string ("%N***** END *****%N")
		end

end  -- class PC (ROOT CLASS)
