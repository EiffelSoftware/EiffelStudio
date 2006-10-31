indexing
	description: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create

	make

feature -- Initialization

	make is
			-- Output a welcome message.
		local
			int1, int2: INTEGER
		do
			io.putstring ("Welcome to ISE Eiffel!%N");
			com_make
			if co_initialize = S_ok then
				create client
				client.initialize(Clsctx_inproc_server)
			
				print ("Enter first integer%N.")
				io.read_integer
				int1 := io.last_integer

				print ("Enter second integer%N.")
				io.read_integer
				int2 := io.last_integer

				print ("The sum equal ")
				print (client.sum (int1, int2))
				print ("%N")

			end
		end;

feature {NONE}-- Implementation

	client: CLIENT;

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


end -- class ROOT_CLASS
