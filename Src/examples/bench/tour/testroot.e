class TESTROOT creation

	make

feature

	o1, o2: PARENT;

	make is
		do
			display_demonstration_message;
			!HEIR! o1; 
			!! o2;
			o1.display;
			o2.display
		end;

	display_demonstration_message is
		do
			io.new_line;
			io.putstring ("ISE Eiffel spoken here");
			io.new_line;
			io.putstring ("--------------------------------%N%N");
		end;

		-- To get a typical compilation error, remove the two dashes
		-- at the beginning of the next line:
	-- inv: INVALID;
end
