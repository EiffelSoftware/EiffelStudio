class
	TEST1

feature

	frozen inline_feature (an_obj: POINTER): INTEGER is
		external
			"C++ inline use <stdio.h>, %"eif_gen_conf.h%""
		alias
			"[
#ifdef EIF_IL_DLL
					printf ("TEST\n");
#else
					printf ("%s\n", eif_typename_id(Dftype($an_obj)));
#endif
					return 5;
			]"
		end
		
	
end
