-- Error for join rule when the types are not the same

class VDJR1 

inherit

	VDJR
		redefine
			build_explain
		end;

feature

	type: TYPE_A;
			-- Type of `new_feature'

	old_type: TYPE_A;
			-- Type of `old_feature'

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	set_old_type (t: TYPE_A) is
			-- Assign `t' to `old_type'.
		do
			old_type := t;
		end;

	print_types is
		do
			put_string ("First type: ");
			old_type.append_clickable_signature (error_window);
			put_string ("%NSecond type: ");
			type.append_clickable_signature (error_window);
			new_line;
		end;

	build_explain is
		do
			put_string ("Result types are different%N");
			print_types;
			print_signatures;
		end;

end
