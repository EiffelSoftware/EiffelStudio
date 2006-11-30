class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			i: INTEGER
		do
			i := inline_feature ($Current)
			print (i)
			print ("%N")
			i := i + {TEST1}.inline_feature ($Current)
			print (i)
			print ("%N")
		end

	inline_feature (an_obj: POINTER): INTEGER is
		external
			"C++ inline use <stdio.h>"
		alias
			"[
					extern char *eif_typename(int16);
#ifdef EIF_IL_DLL
					printf ("TEST\n");
#else
					printf ("%s\n", eif_typename((int16)Dftype($an_obj)));
#endif
					return 5;
			]"
		end
		
	
end
