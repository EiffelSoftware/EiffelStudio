class
	TEST1

feature

	frozen inline_feature (an_obj: POINTER): INTEGER is
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
