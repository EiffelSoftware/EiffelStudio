indexing
	description:
			"Abstract description of the content of a"
	date: "$Date$"
	revision: "$Revision$"

deferred class CONTENT_AS

inherit
	AST_EIFFEL

feature -- Properties

	is_constant: BOOLEAN is
			-- is the current content a constant content ?
		do
			-- Do nothing
		end

	is_unique: BOOLEAN is
			-- Is the current content a unique ?
		do
			-- Do nothing
		end

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
		do
			-- Do nothing
		end

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
		do
			-- Do nothing
		end

	has_precondition: BOOLEAN is
			-- Has the content precondition(s) ?
		do
			-- Do nothing
		end

	has_postcondition: BOOLEAN is
			-- Has the content postcondition(s) ?
		do
			-- Do nothing
		end

feature -- Access

	has_assertion: BOOLEAN is
			-- Has the content pre- or postcondition(s) ?
		do
			Result := has_precondition or else has_postcondition
		end

	has_rescue: BOOLEAN is
			-- Has the current content a rescue clause ?
		do
			-- Do nothing
		end

	is_body_equiv (other: like Current): BOOLEAN is
		-- Is the current feature equivalent to `other' ?
		require
			valid_other: other /= Void
		deferred
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does the current content has instruction `i'?
		deferred
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in current content.
		deferred
		end

feature {BODY_AS} -- Type check and byte code

	check_local_names is
			-- Check conflicts between local names and feature names
		do
		end

feature -- test for empty body

	is_empty : BOOLEAN is
			-- Is content empty?
		do
			Result := True  -- redefined in ROUTINE_AS
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
			-- Create default rescue clause if necessary
		require
			valid_feature_name : def_resc_name /= Void
		do
			-- redefined in ROUTINE_AS
		end

end -- class CONTENT_AS
