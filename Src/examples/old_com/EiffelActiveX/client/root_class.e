indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	ROOT_CLASS

inherit 

	EOLE_COM
		rename
			make as com_make
		export
			{NONE} all
		end

	EOLE_ERROR_CODE
		export 
			{NONE} all
		end

creation

	make

feature -- Initialization

	make is
			-- Output a welcome message.
			--| (Automatically generated.)
		local
			int1, int2: INTEGER
		do
			io.putstring ("Welcome to ISE Eiffel!%N");
			com_make
			if co_initialize = S_ok then
				!!client
				client.initialize(Clsctx_inproc_server)
			
				print ("Enter integers.")
				io.read_integer
				int1 := io.last_integer

				io.read_integer
				int2 := io.last_integer

				print (client.sum (int1, int2))

			end
		end;
feature -- Implementation

	client: CLIENT

end -- class ROOT_CLASS
