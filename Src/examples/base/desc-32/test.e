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

end -- class TEST

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

