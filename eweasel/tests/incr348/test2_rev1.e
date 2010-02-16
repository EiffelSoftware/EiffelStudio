
class TEST2
inherit
	EXCEPTIONS
create
	make
feature

	make
		do
		end

	try
		local
			op: ANONYMOUS_OPERATION
		do
			create op.make (agent confirm_quit)
			op.execute
			if op.aborted then
				abort_close_request
				print ("Hi weasel!%N")
			end
		end

	abort_close_request do  end
	
	confirm_quit
		do
			try_me ("Quit now")
		end
	
	try_me (s: STRING) 
		do 
			confirm (s) 
		end
	
	confirm (s: STRING)
		do
			raise ("Abort")
		end

end
