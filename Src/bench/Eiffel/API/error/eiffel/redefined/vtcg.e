indexing
	description: "Error for violation of constrained genericity validity rule.";
	date: "$Date$";
	revision: "$Revision $"

class VTCG

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	code: STRING is "VTCG";
			-- Error code

	error_list: LINKED_LIST [CONSTRAINT_INFO];
			-- Error description list

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			from
				error_list.start
			until
				error_list.after
			loop
				error_list.item.build_explain (st);
				error_list.forth;
			end;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_error_list (e: like error_list) is
			-- Assign `e' to `error_list'.
		do
			error_list := e;
		end;

end -- class VTCG
