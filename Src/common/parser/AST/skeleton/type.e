indexing
	description: 
		"AST representation for Eiffel types."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TYPE

inherit
	AST_EIFFEL

feature -- Properties

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
			-- Do nothing
		end

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end

--feature -- Access
--
--	frozen is_deep_equal (other: EIFFEL_TYPE): BOOLEAN is
--			-- Is the current type the same as `other' ?
--			--| `deep_equal' cannot be used as for STRINGS, the area
--			--| can have a different size but the STRING is still
--			--| the same (problem detected for LIKE_FEATURE). Xavier
--		do
--			Result := other /= Void and then c_same_type ($Current, $other)
--				and then is_equivalent (other)
--		end

feature -- Comparison

	same_as (other: EIFFEL_TYPE): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
		end

feature -- Output

	trace is
		do
			io.error.putstring (dump);
		end

	dump: STRING is
			-- Dumped trace
		deferred
		end

--	append_to (st: STRUCTURED_TEXT) is
--			-- Append Current type to `st'.
--		require
--			non_void_st: st /= Void
--		do
--			st.add_string (dump)
--		end

feature --{COMPILER_EXPORTER} 

	is_solved: BOOLEAN is
			-- Is the type solved ? (i.e: is the type a result to a call
			-- to feature `solved_type' ?)
		do
			-- Do nothing
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--		end

end -- class EIFFEL_TYPE
