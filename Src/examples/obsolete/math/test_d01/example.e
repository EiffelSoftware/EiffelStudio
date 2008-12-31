note
	description: "Some sample functions to be integrated."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EXAMPLE_INTEGRANDS inherit

	MATHEMATICIAN

feature -- Access

	f1 (x: DOUBLE): DOUBLE
			-- Simple function whose work is proportional to count.
			-- but makes the answer f1(x) = x so we know the answer.	
		do
			Result := x;
		end;	 

	f2 (x: DOUBLE): DOUBLE
			-- Another simple function whose work is proportional to count.
			-- Make the answer f1(x) = x^2 so we know the answer.	 
		do
			Result := x^2.0; 
		end;	

	fun2 (x: DOUBLE): DOUBLE
			-- test for Gauss-Rational
		do
			Result := 1.0/(x*x*log(x))
		end;

	fun3 (x: DOUBLE): DOUBLE
			-- test for Gauss-Laguerre
		do
			Result := Euler^( -x)/x
		end;

	fun4 (x: DOUBLE): DOUBLE
			-- test result for Gauss-Hermite
		do
			Result := Euler^(x*(-3.0)*x-x*4.0-1.0)
		end;	 

	fun5 (x: DOUBLE): DOUBLE
			-- test result for Gauss-Hermite
		do
			Result := 1.0/((x + 1.) * sqrt(x));
		end;	 

	functional1 (x: ARRAY [DOUBLE]): DOUBLE
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

	oscillator (x: DOUBLE): DOUBLE
			-- Kernel for the oscillating test
		do
			Result := x * sine (x * 30.0) * cosine(x)
		end;

	difficult_at_one_seventh (x: DOUBLE): DOUBLE
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

	careful_log (x: DOUBLE): DOUBLE
		do
			if x > 0.0 then
				Result := log (x)
			end;
		end;

	f_cos (x: DOUBLE): DOUBLE
		do
			Result := cosine (x * Pi * 10.0)
		end;

	f_sin (x: DOUBLE): DOUBLE
		do
			Result := sine (x * 10.0)
		end;

	g (x: DOUBLE): DOUBLE
		do
			Result := 1.0 / (x * x + .01 * .01)
		end;

	one_over_sqrt_x (x: DOUBLE): DOUBLE
		do
			if x > 0.0 then
				Result := 1.0 / sqrt (x)
			end;
		end;

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


end -- class EXAMPLE_INTEGRANDS

