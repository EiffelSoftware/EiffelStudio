
class MAIN

creation

	make, nop

feature

	make is
		local
			a:ANY
		do
			!! a;
			test_argument ("FOO", a, 30.343, 25);
			test_ll;
			test_memory;
				-- Test "void" violation
			test_void;
				-- Test precondition violation
			test_precond;
		end;

	nop is do end; 

feature

	test_memory is
		local
			s: STRING
			n: INTEGER
		do
			io.put_string ("Testing memory...%N")
			io.put_string ("Give string length (enter a high number for raising an Eiffel exception)%N")
			io.read_integer
			n := io.last_integer	
			!! s.make (n);
			io.put_string ("Memory OK%N")
		end;

feature

	test_argument (ss: STRING; aa: ANY; dd: DOUBLE; ii: INTEGER) is
		do
		end

feature

	test_ll is
		do
			!!ll.make;

			io.put_string ("Testing ll...%N") 
			ll.extend ("1");
			ll.extend ("2");
			ll.extend ("3");
			ll.extend ("4");
			ll.extend ("5");

			from
				ll.start
			until
				ll.after
			loop
				print (ll.item);
				ll.forth
			end;
			io.put_string ("%Ntest_ll OK%N")
		end;


	ll: LINKED_LIST [STRING];

feature

	test_void is
		local
			s: STRING
		do
			io.put_string ("Testing if string void ...%N")
			io.put_string ("Enter a string: (press enter if you want to raise an Eiffel exception)%N")
			io.read_line
			s := clone (io.last_string)	
			if s.is_equal("") then print ("Ooops!%N"); s := Void  end
			io.putstring (s)
		end;

feature

	test_precond is
		require
			prec
		do
		end;

	prec: BOOLEAN is
		do
			io.put_string ("Testing precondition...")
			io.put_string ("By default it is true%N")
			Result := True
		end

end
