indexing
	description: "Tabular information."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAB_INFORMATION

feature -- Properties

	tab_length: INTEGER is
			-- Tab length of a tool.
		deferred
		end

	Minimum_step: INTEGER is 2
			-- Minimum length for a tab.

	Maximum_step: INTEGER is 16
			-- Maximum length for a tab.

	Default_tab_length: INTEGER is 4
			-- Default tab step.

feature -- Settings

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		require
			valid_length: new_length > 1
		deferred
		ensure
			assigned: tab_length = new_length
		end

end -- class TAB_INFORMATION
