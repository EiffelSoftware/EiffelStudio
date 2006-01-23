indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class MAIN

create

	make, nop

feature

	make is
		local
			a:ANY
		do
			create a;
			test_argument ("FOO", a, 30.343, 25);
			test_linked_list;
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
			create s.make (n);
			io.put_string ("Memory OK%N")
		end;

feature

	test_argument (s: STRING; a: ANY; d: DOUBLE; i: INTEGER) is
		do
		end

feature

	test_linked_list is
		do
			create linked_list.make;

			io.put_string ("Testing linked_list...%N") 
			linked_list.extend ("1");
			linked_list.extend ("2");
			linked_list.extend ("3");
			linked_list.extend ("4");
			linked_list.extend ("5");

			from
				linked_list.start
			until
				linked_list.after
			loop
				print (linked_list.item);
				linked_list.forth
			end;
			io.put_string ("%Ntest_linked_list OK%N")
		end;


	linked_list: LINKED_LIST [STRING];

feature

	test_void is
		local
			s: STRING
		do
			io.put_string ("Testing if string void ...%N")
			io.put_string ("Enter a string: (press enter if you want to raise an Eiffel exception)%N")
			io.read_line
			s := io.last_string.twin
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


end

