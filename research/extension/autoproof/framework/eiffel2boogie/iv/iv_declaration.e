note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_DECLARATION

feature -- Status report

	is_built_in: BOOLEAN
			-- Is this declaration built-in in background theory?

feature -- Status setting

	set_built_in
			-- Set `is_built_in' to True.
		do
			is_built_in := True
		ensure
			is_built_in: is_built_in
		end

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- Process `a_visitor'.
		deferred
		end

end
