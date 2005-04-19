indexing
	description: "Abstract class for Eiffel types.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_AS

inherit
	AST_EIFFEL

feature -- Properties

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			-- Do nothing
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		do
			-- Do nothing
		ensure
			definition: Result = (has_like or has_formal_generic)
		end

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

	frozen is_deep_equal (other: TYPE_AS): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := other /= Void and then other.same_type (Current)
				and then is_internal_equivalent (other)
		end;

feature -- Comparison

	same_as (other: TYPE_AS): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
		end;

feature {NONE} -- Comparison

	frozen is_internal_equivalent (other: TYPE_AS): BOOLEAN is
			-- Safe call for descendants classes of AST_EIFFEL to `is_equivalent'.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
		local
			l_other: like Current
		do
			l_other ?= other
			check
				not_void_since_same_type: l_other /= Void
			end
			Result := is_equivalent (l_other)
		end
	
feature -- Output

	dump: STRING is
			-- Dumped trace
		deferred
		end;

feature
	
	actual_type: TYPE_A is
		do
			fixme ("Manu")
		end
feature --

	is_solved: BOOLEAN is
			-- Is the type solved ? (i.e: is the type a result to a call
			-- to feature `solved_type' ?)
		do
			-- Do nothing
		end

end -- class TYPE_AS
