-- Error for violation of constrained genericity validity rule

class VTGG -- It should be VTCG


inherit

	FEATURE_ERROR
		redefine
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

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			from
				error_list.start
			until
				error_list.after
			loop
				error_list.item.build_explain (ow);
				error_list.forth;
			end;
		end;

	code: STRING is "VTCG";
			-- Error code

end
