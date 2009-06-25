
class TEST

create
	make

feature

	make
		local
			t: TYPE [like Current]
		do
			t := {TEST}
			if t /= {TEST} then
				io.put_string ("Failure%N")
			end
			if t /= {TEST} then
				io.put_string ("Failure%N")
			end
		end

end
