indexing

	description: 
		"AST representation for Eiffel types.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE

inherit

	AST_EIFFEL

feature -- Properties

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
			-- Do nothing
		end;

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end;

feature -- Access

	is_deep_equal (other: TYPE): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := deep_equal (Current, other)
		end;

feature -- Comparison

	same_as (other: TYPE): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
		end;

feature -- Output

	trace is
		do
			io.error.putstring (dump);
		end;

	dump: STRING is
			-- Dumped trace
		deferred
		end;

	append_to (cw: OUTPUT_WINDOW) is
			-- Append Current type to `cw'.:wq
		require
			non_void_cw: cw /= Void
		do
			cw.put_string (dump)
		end;

feature {COMPILER_EXPORTER} 

	is_solved: BOOLEAN is
			-- Is the type solved ? (i.e: is the type a result to a call
			-- to feature `solved_type' ?)
		do
			-- Do nothing
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (dump)
		end;

end -- class TYPE
