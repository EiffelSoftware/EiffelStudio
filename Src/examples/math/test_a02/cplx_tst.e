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

end -- class COMPLEX_TEST

--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for numerical
--| computation ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

