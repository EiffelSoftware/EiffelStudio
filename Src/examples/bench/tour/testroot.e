class TESTROOT create

	make

feature

	o1, o2: PARENT;

	make is
		do
			display_demonstration_message
			create {HEIR} o1
			create o2
			o1.display
			o2.display
		end

	display_demonstration_message is
		do
			io.put_new_line
			io.put_string (" ISE Eiffel spoken here")
			io.put_new_line
			io.put_string ("--------------------------------%N%N")
		end

		-- To get a typical compilation error, remove the two dashes
		-- at the beginning of the next line:
	-- inv: INVALID
end
