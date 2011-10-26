class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			i: INTEGER
		do
			io.put_string ("")
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
					extern char *eif_typename(EIF_TYPE_INDEX);
#ifdef EIF_IL_DLL
					printf ("TEST\n");
#else
					printf ("%s\n", eif_typename((EIF_TYPE_INDEX)Dftype($an_obj)));
#endif
					return 5;
			]"
		end
		
	
end
