-- Abstract class for Eiffel types

deferred class TYPE

inherit

	AST_EIFFEL;

feature

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feature table `feat_table'
		deferred
		end;

	actual_type: TYPE_A is
			-- Processed type of the type wthout taking care of the
			-- anchored type
		deferred
		end;

	trace is
		do
			io.error.putstring (dump);
		end;

	dump: STRING is
			-- Dumped trace
		deferred
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string (dump)
		end;

	is_solved: BOOLEAN is
			-- Is the type solved ? (i.e: is the type a result to a call
			-- to feature `solved_type' ?)
		do
			-- Do nothing
		end;

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
			-- Do nothing
		end;

	same_as (other: TYPE): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			-- Do nothing: implemented only for descendants of TYPE_A
		end;

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end;

end
