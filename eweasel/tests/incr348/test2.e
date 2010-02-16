
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
			end
		end

	confirm_quit
		do
			confirm ("Quit now")
		end
	
	confirm (s: STRING)
		do
			raise ("Abort")
		end

end
