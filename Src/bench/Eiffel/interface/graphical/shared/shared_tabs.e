class SHARED_TABS

feature

	Minimum_step: INTEGER is 2;
			-- Minimum length for a tab

	Maximum_step: INTEGER is 16;
			-- Maximum length for a tab

	Default_tab_step: INTEGER is 4;

	valid_tab_step (step: INTEGER): BOOLEAN is
			-- Is `step' a valid tabulation length?
		do
			Result := step >= Minimum_step and step <= Maximum_step
		end;

invariant

	valid_default_tab_step: valid_tab_step (Default_tab_step)

end -- class SHARED_TABS
