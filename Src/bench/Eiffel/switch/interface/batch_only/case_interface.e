class CASE_INTERFACE

create
	make

feature

	make (output_w : OUTPUT_WINDOW;rev_w : DEGREE_OUTPUT) is
		local
			format: FORMAT_CASE_STORAGE
		do
			create format.make (output_w, rev_w, True)
				-- FIXME: manus 11/24/1999
			format.execute ("")
		end;

end -- class PERM_WIND1
