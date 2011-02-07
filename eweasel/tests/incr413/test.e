class
	TEST

create
	make

feature {NONE}

	make
		local
			t2: TEST2
			t1: TEST1
			int: INTERNAL
			i: INTEGER
		do
			create int
			create t2
			from i := 1 until i > int.field_count (t2) loop
				if int.is_field_transient (i, t2) then
					print (int.field_name (i, t2))
					io.put_string (" is transient")
					io.put_new_line
				end
				i := i + 1
			end

			create t1
			from i := 1 until i > int.field_count (t1) loop
				if int.is_field_transient (i, t1) then
					print (int.field_name (i, t1))
					io.put_string (" is transient")
					io.put_new_line
				end
				i := i + 1
			end
		end

end
