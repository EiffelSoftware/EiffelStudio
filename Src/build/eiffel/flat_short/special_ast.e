class SPECIAL_AST 

inherit

	SHARED_TEXT_ITEMS

feature

	flat_ctxt: FLAT_CONTEXT is
		once
			!!Result;
		end;

	is_short: BOOLEAN is
			-- Is Current doing a flat-short? (False implies flat)
		do
			Result := is_short_bool.value
		end;

	in_bench_mode: BOOLEAN is
			-- Are all instruction calls clickable?
		do
			Result := in_bench_mode_bool.value
		end;

	in_assertion: BOOLEAN is
		do
			Result := in_assertion_bool.value
		end;

	order_same_as_text: BOOLEAN is
		do
			Result := order_same_as_text_bool.value
		end;

	print_fix_keyword: BOOLEAN is
			-- Print fix keyword? 
			--| This is used for a hack.
		do
			Result := print_fix_keyword_bool.value
		end;

feature {NONE}

	is_short_bool: SHARED_BOOL is
		once
			!!Result
		end;

	in_bench_mode_bool: SHARED_BOOL is
		once
			!!Result
		end;

	in_assertion_bool: SHARED_BOOL is
		once
			!!Result
		end;

	print_fix_keyword_bool: SHARED_BOOL is
		once
			!!Result
		end;

	order_same_as_text_bool: SHARED_BOOL is
		once
			!!Result
		end;

end	
