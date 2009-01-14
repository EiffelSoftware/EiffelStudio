
class TEST
inherit
	ANY
	EXCEPTION_MANAGER
		export
			{NONE} all
		end

create
	make

feature

	make is
		local
			n: INTEGER
		do
			io.put_string ("At start of make%N");
			io.output.flush
			inspect n
			when 0 then
				try_wrapper
			when 1 then
				
			end
			io.put_string ("At end of make%N");
			io.output.flush
		rescue
			io.put_string ("In make rescue%N");
			io.output.flush
			n := 1
			retry
		end

	try_wrapper
		do
			try
		rescue
			io.put_string ("In try_wrapper rescue%N")
			io.output.flush
		end

	try
		do
			-- Simulate programming error (Violate precondition)
			io.put_string (Void)
		rescue
			io.put_string ("In try rescue%N")
			io.output.flush
		end

end
