-- Error for violation of constrained genericity validity rule

class VTGG 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature 

	error_list: LINKED_LIST [CONSTRAINT_INFO];
			-- Error description list

	set_error_list (e: like error_list) is
			-- Assign `e' to `error_list'.
		do
			error_list := e;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			from
				error_list.start
			until
				error_list.offright
			loop
				io.error.putchar ('%T');
-- FIXME:
--				error_list.item.build_explain;
				error_list.item.trace;
				error_list.forth;
			end;
		end;

	code: STRING is "VTGG";
			-- Error code

end
