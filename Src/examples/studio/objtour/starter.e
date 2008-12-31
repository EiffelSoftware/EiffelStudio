note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class STARTER create

	make

feature

	my_list: LINKED_LIST [REAL];
	my_string: STRING;
    my_array: ARRAY [INTEGER];
	my_integer: INTEGER;

	make
			-- Create a list, a string, an array, and stop.
		do
			make_a_list (first_value, second_value, third_value);
			make_a_string;
			make_an_array;
            my_integer := 1995;
			nothing
		end;

	nothing
			-- Put a stop point on this routine to get  `make' to stop
			-- after calling `make_a_list' and `make_an_array',
			-- so that you can explore `my_list', its dependent
			-- LINKABLE objects, and the array `my_array'.
		do
		end;

	make_a_list (first, second, third: REAL)
			-- Create  `my_list' with the three values given.
		do
			create my_list.make;
			my_list.extend (first);
			my_list.extend (second);
			my_list.extend (third)
		end;

	make_a_string
			-- Assign to `my_string' the value of a constant string.
		do
			my_string := "MY MESSAGE"
		end;

	make_an_array
				-- Create `my_array' with known values
				-- (integer part of i/2 for each index i).
			
			local
				i: INTEGER; size: INTEGER
			do
				size := 1000;
				from
					create my_array.make (1, size); i := 1
				until
					i = 1000
				loop
					my_array.put (i // 2, i)
					i := i + 1
				end
			end;

	first_value: REAL
					-- A  value to be computed once: -6.5 (will be used)
			once
				Result := -6.5
			end;

	second_value: REAL
					-- A value to be computed once:  0.0 (will be used)
			once
				Result := 0.0
			end;

	third_value: REAL
					-- A value to be computed once: 3.5 (will be used)
			once
				Result := 3.5
			end;

	fourth_value: REAL
					-- A value to be computed once: 1.0 (will not be used)
			once
				Result := 1.0
			end;

	my_subobject: expanded OTHER;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class STARTER
