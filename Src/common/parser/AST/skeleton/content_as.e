-- Abstract description of the content of a feature

deferred class CONTENT_AS

inherit

	AST_EIFFEL
		redefine
			byte_node
		end

feature -- Conveniences

	is_constant: BOOLEAN is
			-- is the current content a constant content ?
		do
			-- Do nothing
		end;

	is_unique: BOOLEAN is
			-- Is the current content a unique ?
		do
			-- Do nothing
		end;

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
		do
			-- Do nothing
		end;

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
		do
			-- Do nothing
		end;

	has_precondition: BOOLEAN is
			-- Has the content precondition(s) ?
		do
			-- Do nothing
		end;

	has_postcondition: BOOLEAN is
			-- Has the content postcondition(s) ?
		do
			-- Do nothing
		end;

	has_assertion: BOOLEAN is
			-- Has the content pre- or postcondition(s) ?
		do
			Result := has_precondition or else has_postcondition;
		end;

	has_rescue: BOOLEAN is
			-- Has the current content a rescue clause ?
		do
			-- Do nothing
		end;

	is_body_equiv (other: like Current): BOOLEAN is
		-- Is the current feature equivalent to `other' ?
		deferred
		end;

feature -- Type check and byte code

	byte_node: BYTE_CODE is
            -- Associated byte code
        do
		ensure then
			False
        end;

	check_local_names is
			-- Check conflicts between local names and feature names
		do
		end;

end
