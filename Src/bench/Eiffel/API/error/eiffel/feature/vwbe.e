-- Error for a non-boolean expression

deferred class VWBE 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature 

	code: STRING is "VWBE";
			-- Error code

	type: TYPE_A;

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

	where: STRING is
		deferred
		end;

	build_explain is
		do
			put_string (where);
			put_string ("%NExpression type: ");
			type.append_clickable_signature (error_window);
			new_line;
		end;

end

