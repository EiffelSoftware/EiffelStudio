-- test routine for interface to chapter d01
indexing
	description: " Test routines for d01"
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	DRIVE
inherit
	EIFFELMATH_TESTING_FRAMEWORK

create
	make

feature -- The main program

	make (args: ARRAY [STRING]) is
			-- test of various routines from d01
		do
			test_root;
			test_sys;
		end;


feature -- Test of c05adc, root finder

	testf: TEST_CLASS;
			-- A class that contains feature f1 such that f1(1.5)=0.

	test_root is
			-- test zero in an interval
		local
			gr: FUNCTION_ROOT_FINDER;
			-- An zero finder for finite intervals.
		do
	 		-- create an instance of the target class for passing to the root finder.
			create testf

			create gr.make;
			gr.make_target (testf, "f1");
			gr.set_interval(1., 2.);

			print("Solving for zero of f1. Answer should be 1.5%N");
			gr.solve;

			print ("Root: ") ;
			print (gr.last_root);
			print_nl ("");
		end;

	test_sys is
			-- test zero of non-linear system with and without Jacobian
		local
			gr: NONLINEAR_SYSTEM_SOLVER;
			t: TEST_SYSTEM;
			x: ARRAY [DOUBLE];
		do
	 		-- create an instance of the target class for passing to the root finder.
			create t;

			create gr.make (t);

			print("Solving for zero of system. Answer should be %N");
			x := <<-.5707, -.6816, -.7017, -.7042, -.7014,
				-.6919, -.6658, -.5960, -.4164>>;
			print("Checking function and Jacobian from Eiffel%N")
			print(x.tagged_out);
			print(t.value(x).tagged_out);
			print(t.jacobian(x).tagged_out);

			x := << -1., -1., -1., -1., -1., -1., -1., -1., -1.>>;
			gr.do_not_use_jacobian;
			gr.solve (x);
			
			print ("Solution without Jacobian, last_root: ") ;
			print (gr.last_root.tagged_out);
			print ("last_value: ") ;
			print (gr.last_value.tagged_out);
			print_nl ("");

			gr.use_jacobian;
			gr.check_jacobian (x);
			print("Jacobian checked against system, ok.%N");
			gr.solve (x);

			print ("Solution with Jacobian, last_root: ") ;
			print (gr.last_root.tagged_out);
			print ("last_value: ") ;
			print (gr.last_value.tagged_out);
			print_nl ("");
		end;

end -- class DRIVE

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

