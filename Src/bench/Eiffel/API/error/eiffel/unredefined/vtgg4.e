-- Error for violation of the constrained genericity rule by a parent type

class VTGG4 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature 

	parent_type: CL_TYPE_A;
			-- Parent type involved in the error

	set_parent_type (p: CL_TYPE_A) is
			-- Assign `p' to `parent_type'.
		do
			parent_type := p;
		end;

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
			ow.put_string ("In parent clause: ");
			parent_type.append_to (ow);
			ow.new_line;
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
