
class TEST
inherit
	EXCEPTION_MANAGER

create
	make

feature

	make
		do
			test_local_constant
			test_remote_constant
		end

	test_local_constant
		local
			tried: BOOLEAN
			n: INTEGER
		do
			if not tried then
				n := Current.Weasel
				print ("No exception%N")
			else
				if {e: INVARIANT_VIOLATION} last_exception then
					print ("Class invariant violation%N");
				else
					print (last_exception.meaning); io.new_line
				end
			end
		rescue
			tried := True
			retry
		end

	test_remote_constant
		local
			tried: BOOLEAN
			n: INTEGER
		do
			if not tried then
				create x
				disable_test2_valid
				n := x.Stoat
				print ("No exception%N")
			else
				if {e: INVARIANT_VIOLATION} last_exception then
					print ("Class invariant violation%N");
				else
					print (last_exception.meaning); io.new_line
				end
			end
		rescue
			tried := True
			retry
		end

	disable_test2_valid
		local
			tried: BOOLEAN
		do
			if not tried then
				x.disable_valid
			end
		rescue
			tried := True
			retry
		end

	x: TEST2

	Weasel: INTEGER = 3

invariant
	valid: False
end
