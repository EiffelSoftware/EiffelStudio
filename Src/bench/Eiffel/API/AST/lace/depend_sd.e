indexing
	description: "Depend clause in Ace file";
	date: "$Date$";
	revision: "$Revision$"

class
	DEPEND_SD

inherit
	AST_LACE

feature {DEPEND_SD, LACE_AST_FACTORY} -- Initialization

	initialize (d: like depend_on; s: like script) is
			-- Create a new TWO_NAME AST node.
		require
			d_not_void: d /= Void
			s_not_void: s /= Void
		do
			depend_on := d
			script := s
		ensure
			depend_on_set: depend_on = d
			script_set: script = s
		end

feature -- Properties

	depend_on: LACE_LIST [ID_SD]
			-- Name of file to depend on.
	
	script: ID_SD
			-- Script to run when file changes.

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result
			Result.initialize (depend_on.duplicate, script.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then depend_on.same_as (other.depend_on)
					and then script.same_as (other.script)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			depend_on.save (st)
			st.putstring (": ")
			script.save (st)
		end

end -- class DEPEND_SD
