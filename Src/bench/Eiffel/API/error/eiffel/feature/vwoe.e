-- Error when a prefix/infix operator doesn't exist in a class

class VWOE 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature

	other_class: CLASS_C;
			-- Class for which there is no infix/prefix feature

	op_name: STRING;
			-- Internal name of the infix/prefix feature

	node: EXPR_AS;
			-- Binary or unary node

	set_other_class (o: CLASS_C) is
			-- Assign `o' to `other_class'.
		do
			other_class := o;
		end;

	set_op_name (s: STRING) is
			-- Assign `s' to `op_name'.
		do
			op_name := s;
		end;

	set_node (e: EXPR_AS) is
			-- Assign `e' to `node'.
		do
			node := e;
		end;

	code: STRING is "VWOE";
			-- Error code

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("%TThere is no feature ");
			put_string (op_name);
			put_string (" in class ");
-- FIXME
--			put_clickable_string (other_class, other_class.class_name);
			put_string (other_class.class_name);
			new_line;
		end

end
