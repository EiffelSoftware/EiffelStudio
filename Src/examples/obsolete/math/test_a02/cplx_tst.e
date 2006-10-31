indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class

	COMPLEX_TEST

inherit

	EIFFELMATH_TESTING_FRAMEWORK

	NAG_G
		undefine
			print
		end

	SPECIAL_FUNCTIONS
		undefine
			print
		end

create

	make

feature -- Initialization

	make is
		local
			toto: DOUBLE
		do
			toto := g05cac

			print("test of COMPLEX %N")
			create x
			create y
			x.set (1, 0)
			y.set (0, 1)
			test
			x.set (2, 0)
			y.set (0, 4)
			test
			x.set (-5, 4)
			y.set (2, 3)
			test
		end

feature -- Attributes

	x,y,z: COMPLEX_REF

feature {NONE} -- Implementation

	test is
		do
			print("%Nx+y%N")
			print((x+y).out)
			print("%Nx-y%N")
			print((x-y).out)
			print("%Nx*y%N")
			print((x*y).out)


			--print("%Nproduct: x * y%N");
			--print((x.product (y)).out);

			print("%Nx/y%N")
			print((x/y).out)
			print("%Narg(x)%N")
			print((x.argument).out)
			print("%Nmodule(x)%N")
			print((x.modulus).out)
			print("%Nx^y%N")
			print((x^y).out)
			print("%Nconjugue(x)%N")
			print(x.conjugated.out)
			print("%Nsin(x)%N")
			print(x.sine.out)
			print("%Ncos(x)%N")
			print(x.cosine.out)
			print("%Ntan(x)%N")
			print(x.tangent.out)
			print("%Nexp(x)%N")
			print(x.exp.out)
			print("%Nlog(x)%N")
			print(x.log.out)
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


end -- class COMPLEX_TEST

