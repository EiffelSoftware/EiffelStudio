
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
		redefine
			f
		end

	HASHABLE

create
	make

feature

	t2: TEST2
	t3: TEST3

	make
		require
			a: True
		local
			i, n: INTEGER
			s: STRING
			a: ANY
		do
			s ?= "21321"

			io.put_string (s.out.out.out.out)

			a := << 1, 3, 5>>
			a := [a, "Fdsfds", 1]

			s := once "fdsfds"

			s := once "%N%R%T%U"

			if attached {attached STRING} s as ssdasda then
				print ("Fdsfds")
			end

			if (once "fdsfds").count > 10 then
				print ("Fdsfs")
			end

			check
				f: io /= Void
			end

			check
				f: io /= Void
				g: io /= Void
			end

			if i < 10 then
				if (i > 10) or io.default /= Void then
					print ("")
				elseif i > 100 then
					print ("")
				elseif n > 100 then
					print ("")
				else
					print ("fdsfdsfds")
				end
			elseif n < 10 then
				if n > 10 then
					print ("fds")
				else
					print ("fdsfds")
				end
			else
				print ("Fsdfsd")
			end

			from
				i := 10
			invariant
				i > 0
			variant
				i
			until
				i = 1
			loop
				i := i - 1
			end

			print ("FDSF")
			inspect i
			when 1 then
				print ("ftrew")
			when 3..5 then
				print ("FSFDS")
			else
				print ("Done")
			end

			debug ("FDSFSD", "Fsdfsd")
				print (io)
			end

			i := 10
			n := i - 1
		rescue
			print ("")
			retry
		end

	test (a: INTEGER; b: STRING)
		local
			i: INTEGER
			n: NATURAL_32
			c: CHARACTER
			w: CHARACTER_32
		do
			i := b.count
			i := a * i
			c := 'a'
			w := 'b'
			i := 12312
			n := 12312
			n := {NATURAL_32} 12312
		ensure
			b: io /= Void
		end

	hash_code: INTEGER = 1;

	f
		require else
			a: io /= Void
		do
		ensure then
			b: io /= Void
			c: old io = io
		end

	once_procedure
		note
			once_status: global
		once
			print ("Fdsfsd")
		end

	once_procedure_per_thread
		once
			print ("Fdsfsd")
		end

	once_integer: INTEGER
		note
			once_status: global
		once
			Result := 5
		end

	once_integer_per_thread: INTEGER
		once
			Result := 10
		end

	once_string: STRING
		note
			once_status: global
		once
			Result := "DFsdf"
		end

	once_string_per_thread: STRING
		once
			Result := "Fdsfdsf"
		end

	io_test: STD_FILES
			-- Handle to standard file setup
		once
			create Result
			Result.set_output_default
		ensure
			io_not_void: Result /= Void
		end

end

