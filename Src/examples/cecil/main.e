
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
		do
			!! s.make (100000000000);
		end;

feature

	test_argument (ss: STRING; aa: ANY; dd: DOUBLE; ii: INTEGER) is
		do
		end

feature

	test_ll is
		do
			!!ll.make;

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
		end;


	ll: LINKED_LIST [STRING];

feature

	test_void is
		local
			s: STRING
		do
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
			Result := True
		end

end
