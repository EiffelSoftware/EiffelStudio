indexing
	description: "Shared tabular information.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_TABS

inherit
	EB_CONSTANTS

feature -- Properties

	default_tab_length: INTEGER_REF is
			-- Default tabulation length
		local
			tab_integer: INTEGER
		once
			create Result;
			tab_integer := General_resources.tab_step.actual_value;
			Result.set_item (tab_integer)
		end;

	Minimum_step: INTEGER is 2;
			-- Minimum length for a tab

	Maximum_step: INTEGER is 16;
			-- Maximum length for a tab

	Default_tab_step: INTEGER is 4;

feature -- Settings

	set_default_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `default_tab_length'.
		do
			default_tab_length.set_item (new_length)
		ensure
			assigned: default_tab_length.item = new_length
		end;

end -- class SHARED_TABS
