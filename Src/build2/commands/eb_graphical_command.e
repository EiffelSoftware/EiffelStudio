indexing
	description	: "Command that can be added in an interface."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_GRAPHICAL_COMMAND

inherit
	EB_COMMAND

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			is_sensitive := True
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the graphical component associated with this command
			-- sensitive to user input?

feature -- Status setting

	enable_sensitive is
			-- Set `is_sensitive' to `True'.
		deferred
		ensure
			sensitive: is_sensitive
		end

	disable_sensitive is
			-- Set `is_sensitive' to `False'.
		deferred
		ensure
			unsensitive: not is_sensitive
		end

end -- class EB_GRAPHICAL_COMMAND
