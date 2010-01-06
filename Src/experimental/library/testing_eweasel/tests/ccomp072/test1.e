class TEST1

create
	make

feature

	make is
		local
		do
			call ($Current, $f)
		end

	f is
		do
			print ("Success%N")
		end

	call (an_obj: POINTER; a_fn: POINTER) is
		external
			"C inline"
		alias
			"[
			#ifdef EIF_IL_DLL
				((void (*) ()) $a_fn) ();
			#else
				((void (*) (EIF_REFERENCE)) $a_fn) ($an_obj);
			#endif
			]"
		end

end
