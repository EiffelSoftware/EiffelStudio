indexing
	description: "Some sample functions to be integrated."

class EXAMPLE_INTEGRANDS inherit

	MATHEMATICIAN

feature -- Access

	f1 (x: DOUBLE): DOUBLE is
			-- Simple function whose work is proportional to count.
			-- but makes the answer f1(x) = x so we know the answer.	
		local
			i: INTEGER
		do
			Result := x;
		end;	 

	f2 (x: DOUBLE): DOUBLE is
			-- Another simple function whose work is proportional to count.
			-- Make the answer f1(x) = x^2 so we know the answer.	 
		local
			i: INTEGER
		do
			Result := x^2.0; 
		end;	

	fun2 (x: DOUBLE): DOUBLE is
			-- test for Gauss-Rational
		do
			Result := 1.0/(x*x*log(x))
		end;

	fun3 (x: DOUBLE): DOUBLE is
			-- test for Gauss-Laguerre
		do
			Result := Euler^( -x)/x
		end;

	fun4 (x: DOUBLE): DOUBLE is
			-- test result for Gauss-Hermite
		do
			Result := Euler^(x*(-3.0)*x-x*4.0-1.0)
		end;	 

	fun5 (x: DOUBLE): DOUBLE is
			-- test result for Gauss-Hermite
		do
			Result := 1.0/((x + 1.) * sqrt(x));
		end;	 

	functional1 (x: ARRAY [DOUBLE]): DOUBLE is
			-- Example from Nag manual for d01ffc and d01gbc
		require
			x /= Void
		local
			x0, x1, x2, x3: DOUBLE;
			lower: INTEGER;
		do
			lower := x.lower;
			x0 := x @ lower;
			x1 := x @ (lower + 1);
			x2 := x @ (lower + 2);
			x3 := x @ (lower + 3);
			Result := x0 * 4.0 * (x2 * x2) * (Euler ^ (x0 * 2.0* x2)) /
				((x1 + 1.0 + x3) * (x1 + 1.0 + x3));
		end;

	oscillator (x: DOUBLE): DOUBLE is
			-- Kernel for the oscillating test
		do
			Result := x * sine (x * 30.0) * cosine(x)
		end;

	difficult_at_one_seventh (x: DOUBLE): DOUBLE is
			-- Kernel for the breakpoint test
		local
			a: DOUBLE;
		do
			a := dabs (x - 1.0/7.0);
			if a = 0. then
				Result := 0.0
			else
				Result := 1.0 / sqrt(a)
			end;
		end;

	careful_log (x: DOUBLE): DOUBLE is
		do
			if x > 0.0 then
				Result := log (x)
			end;
		end;

	f_cos (x: DOUBLE): DOUBLE is
		do
			Result := cosine (x * Pi * 10.0)
		end;

	f_sin (x: DOUBLE): DOUBLE is
		do
			Result := sine (x * 10.0)
		end;

	g (x: DOUBLE): DOUBLE is
		do
			Result := 1.0 / (x * x + .01 * .01)
		end;

	one_over_sqrt_x (x: DOUBLE): DOUBLE is
		do
			if x > 0.0 then
				Result := 1.0 / sqrt (x)
			end;
		end;

end -- class EXAMPLE_INTEGRANDS

--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

