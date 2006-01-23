indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	TEST
inherit
	SHARED_LIBRARY_CONSTANTS

create
	make

feature
	make is
		do
			io.putstring ("Hello%N")
			testdesc
			io.read_line
		end

	testdesc is
		local
			dll: DLL_32
			routine: DLL_32_ROUTINE
			a: ARRAY [INTEGER]
			r1, r2: REAL
		do
			create dll.make ("testdesc.dll")
				-- Create a DLL_32 object

			create routine.make_by_name (dll, "Sum",
				<<T_string, T_array, T_short_integer>>,
				T_integer)
				-- Create a DLL_32_ROUTINE object

			a := <<10, 20, 30>>
			routine.call (<<"Eiffel", a, 3>>)
				-- Call the routine with the arguments

			io.put_string ("Sum of the array is ")
			io.put_integer (routine.integer_result)
				-- Print the result
			io.new_line

			routine.make_by_name (dll, "EiffelString",
				<<>>, T_string)
				-- A routine without arguments which
				-- returns a string (from the same DLL)
			routine.call (<<>>)
			io.put_string (routine.string_result)
			io.new_line

			create routine.make_by_name (dll, "double_function",
				<<T_double, T_double>>, T_double)
			routine.call (<<90.9, 2.2>>)
			io.putdouble (routine.double_result)

			create routine.make_by_name (dll, "output",
				<<T_integer, T_integer>>, T_integer)
			routine.call (<<5, 6>>)
			io.putint (routine.integer_result)
			io.new_line

			create routine.make_by_name (dll, "float_function",
				<<T_real, T_real>>, T_real)
			r1 := 12.2
			r2 := 6.6
			routine.call (<< r1, r2>>)
			io.putreal (routine.real_result)
			io.new_line
		end

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


end -- class TEST

