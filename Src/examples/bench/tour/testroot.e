class TESTROOT create

	make

feature

	o1, o2: PARENT
			-- Examples of attributes

	make is
			-- Output messages tracing what's going on.
		do
			display_demonstration_message
			create {HEIR} o1
			create o2
			o1.display
			o2.display
		end

	display_demonstration_message is
			-- Output a welcoming message.
		do
			io.put_new_line
			io.put_string (" ISE Eiffel spoken here")
			io.put_new_line
			io.put_string ("--------------------------------%N%N")
		end

		-- To get a typical compilation error, remove the two dashes
		-- at the beginning of the next line:
	-- inv: INVALID

end -- class TESTROOT
