class CASE_INTERFACE

creation
	make

feature

	make (output_w : OUTPUT_WINDOW;rev_w : DEGREE_OUTPUT) is
		local
			format: FORMAT_CASE_STORAGE
		do
			!! format.make (output_w, rev_w, True)
			format.execute
		end;

end -- class PERM_WIND1
