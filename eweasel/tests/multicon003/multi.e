indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		-- each class (A,B,C) has the features make, f and g
		-- A keeps nothing
		-- B keeps g and make
		-- C keeps f

		MULTI[G->{	A rename f as f_a, g as g_a, make as make_a end,
					C rename g as g_c, make as make_c end,
					B rename f as f_b end} create make end]

create
	make

feature -- Initialize

	make is
			-- Do the testing
		do
			create mc.make
		end
feature -- Command

	test is
			-- Do some testing
		local
			i: INTEGER
			d: DOUBLE
			l_a: A
			l_b: B
			l_c: C
			l_any: ANY
		do
					-- call every feature
			mc.make_a
			i := mc.make_c
				println (i)
			mc.make
			i := mc.f_a
				println (i)
			d := mc.f_b
				println (d)
			mc.f
			mc.g_a
			l_any := mc.g
				println (l_any.generating_type)
			d := mc.g_c
				println (d)

			mc ?= l_any
			
			l_a := mc
			l_b := mc
			l_c := mc

			l_a.make
			l_b.make
			i := l_c.make
				println (i)

			l_c ?= l_b
			l_a ?= l_c
			l_b ?= l_a

			i := l_a.f
				println (i)
			d := l_b.f
				println (d)
			l_c.f

			l_a.g
			l_c ?= l_b.g
			d := l_c.g
				println (d)


			

		end

feature -- Access

	mc: G

feature -- Implementation

	println (a_any: ANY) is
			-- Print new line
		do
			print (a_any)
			print ('%N')
		end

end
