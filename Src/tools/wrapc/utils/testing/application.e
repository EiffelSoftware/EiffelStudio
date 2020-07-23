note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
		do
			print ("Testing Int Array%N")
			test_wrap_int_array
			print ("%NTesting Double Array%N")
			test_wrap_double_array
			print ("%NTesting Structure Array%N")
			test_wrap_structure_array
		end

	test_wrap_int_array
		local
			arr: WRAPC_INTEGER_32_ARRAY
			l_ptr: POINTER
			i: INTEGER
		do
			l_ptr := {C2EIFFEL_ARRAY}.c_int_array (10)
			create arr.make_shared (l_ptr, 10)
			from
				i := 0
			until
				i = 10
			loop
				print (arr [i])
				print ("%N")
				i := i + 1
			end
		end

	test_wrap_double_array
		local
			arr: WRAPC_REAL_64_ARRAY
			count: INTEGER
			l_ptr: POINTER
			i: INTEGER
			fd: FORMAT_DOUBLE
		do
			l_ptr := {C2EIFFEL_ARRAY}.c_double_array ($count)
			create arr.make_shared (l_ptr, count)
			create fd.make (6,2)
			from
				i := 0
			until
				i = count
			loop
				print (fd.formatted (arr [i]))
				print ("%N")
				i := i + 1
			end
		end


	test_wrap_structure_array
		local
			arr: WRAPC_PERSON_STRUCTURE_ARRAY
			count: INTEGER
			l_ptr: POINTER
			i: INTEGER
		do
			l_ptr := {C2EIFFEL_ARRAY}.c_structure_person_array ($count)
			create arr.make_shared (l_ptr, count)
			from
				i := 0
			until
				i = count
			loop
				print ("Person name: " + arr[i].name.string + " id:" + arr[i].id.out )
				print ("%N")
				i := i + 1
			end
		end

	c_define
		external "C inline"
		alias
			"#define C2EIFFEL_IMPL"
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		5949 Hollister Ave., Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end
