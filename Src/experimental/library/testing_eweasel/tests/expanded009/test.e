class
	TEST

create
	make

feature

	make is
		local
			s: STRING
			i, dtype_string, dtype_a: INTEGER
			int: INTERNAL
			a: A
		do
			from
				create int
				dtype_string := int.dynamic_type ("TEST")
				dtype_a := int.dynamic_type_from_string ("A")
				i := 1
			until
				i > Max
			loop
				s := "TEST"
				a := my_c ($s, dtype_string, dtype_a)
				a := my_c2 ($s, dtype_string, dtype_a)
				i := i + 1
			end
		end

	my_c (a_s: POINTER; dtype_string, dtype_a: INTEGER): A
		external
			"C inline use <stdio.h>, <stdlib.h>"
		alias
			"[
				if ($dtype_string != Dftype($a_s)) {
					printf ("Failure\n");
				}
				return RTLN($dtype_a);
			]"
		end

	my_c2 (a_s: POINTER; dtype_string, dtype_a: INTEGER): A
		external
			"C inline use <stdio.h>, <stdlib.h>"
		alias
			"[
				if ($dtype_string != Dftype($a_s)) {
					printf ("Failure\n");
				}
				return NULL;
			]"
		end

	Max: INTEGER = 1_000_000

end

