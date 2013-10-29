note
	description : "scoop_testbench application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	path : LINKED_LIST[separate VERTEX]
	sorted_path : LINKED_LIST[separate VERTEX]

	make
			-- Run application.
		local
			sep_v1, sep_v2, sep_v3 : separate VERTEX
		do
			create sep_v1.make (1, 0, 0)
			create sep_v2.make (2, 0, 0)
			create sep_v3.make (3, 0, 0)

			create path.make
			create sorted_path.make

			path.extend (sep_v2)
			path.extend (sep_v3)
			path.extend (sep_v1)

			sorted_path.extend(sep_v1)
			sorted_path.extend(sep_v2)
			sorted_path.extend(sep_v3)

			recursive_foo(1, sep_v1)
		end

	recursive_foo(n:INTEGER; v: separate VERTEX)
		local
			i, d : INTEGER
		do
			d := v.dummy(10)
			if n < sorted_path.count then
				recursive_foo(n+1, sorted_path.i_th (n+1))
			end
			from i := 1
			until i > path.count
			loop
				use_vertex(path.i_th (i))
				i := i + 1
			end
		end

	use_vertex(v : separate VERTEX)
		local
			i:INTEGER
		do
			i := v.dummy (100)
		end
end
