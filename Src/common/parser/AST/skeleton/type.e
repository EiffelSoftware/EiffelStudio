indexing

	description: "Abstract class for Eiffel types.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;

feature

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	trace is
		do
			io.error.putstring (dump);
		end;

	dump: STRING is
			-- Dumped trace
		deferred
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
			--|Note: implemented only for descendants of TYPE_A
		do
			-- Do nothing: implemented only for descendants of TYPE_A
		end;

	is_deep_equal (other: TYPE): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := deep_equal (Current, other)
		end;

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (dump)
		end;

end -- class TYPE
