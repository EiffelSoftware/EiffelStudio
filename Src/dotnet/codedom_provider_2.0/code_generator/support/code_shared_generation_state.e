indexing
	description: "Generation states"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_GENERATION_STATE

feature -- Access

	Initial_state: INTEGER is 0
			-- Default state

	Code_analysis: INTEGER is 1
			-- Codedom analysis, build CODE_* instances

	Code_generation: INTEGER is 2
			-- Code generation, executing `code'

feature -- Status report

	current_state: INTEGER is
			-- Current generation state, see {CODE_SHARED_GENERATION_STATES} for possible values
		do
			Result := internal_current_state.item
		ensure
			valid_state: is_valid_generation_state (Result)
		end

	is_valid_generation_state (a_state: INTEGER): BOOLEAN is
			-- Is `a_state' a valid_generation state?
		do
			Result := a_state = Initial_state or a_state = Code_analysis or a_state = Code_generation
		ensure
			definition: Result = (a_state = Initial_state or a_state = Code_analysis or a_state = Code_generation)
		end

feature -- Status Setting

	set_current_state (a_state: like current_state) is
			-- Set `current_state' with `a_state'.
		require
			valid_state: is_valid_generation_state (a_state)
		do
			internal_current_state.set_item (a_state)
		ensure
			current_state_set: current_state = a_state
		end

feature {NONE} -- Implementation

	internal_current_state: INTEGER_REF is
			-- Internal representation of `current_state'.
		once
			create Result
			Result.set_item (Initial_state)
		ensure
			cell_created: Result /= Void
		end

invariant
	initial_state_is_valid_state: is_valid_generation_state (Initial_state)
	code_analysis_is_valid_state: is_valid_generation_state (Code_analysis)
	code_generation_is_valid_state: is_valid_generation_state (Code_generation)
	valid_state: is_valid_generation_state (current_state)

end -- class CODE_SHARED_GENERATION_STATE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------