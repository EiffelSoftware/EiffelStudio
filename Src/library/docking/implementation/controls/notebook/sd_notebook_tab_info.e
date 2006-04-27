indexing
	description: "Infomation about a SD_NOTEBOOK_TAB, used for draw tabs."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_INFO

feature -- Query

	is_tab_after: BOOLEAN
			-- If after Current, there is a tab?

	is_tab_before: BOOLEAN
			-- If after Current, there is a tab?

	is_tab_after_selected: BOOLEAN is
			-- `internal_is_tab_after_selected'
		require
			valid: is_tab_after
		do
			Result := internal_is_tab_after_selected
		end

	is_tab_before_selected: BOOLEAN is
			-- `internal_is_tab_before_selected'
		require
			valid: is_tab_before
		do
			Result := internal_is_tab_before_selected
		end

feature -- Setting

	set_tab_after (a_selected_tab_after: BOOLEAN) is
			-- Set `is_tab_after'.
		do
			is_tab_after := a_selected_tab_after
		ensure
			set: is_tab_after = a_selected_tab_after
		end

	set_tab_before (a_bool: BOOLEAN) is
			-- Set `is_tab_before'
		do
			is_tab_before := a_bool
		ensure
			set: is_tab_before = a_bool
		end

	set_tab_after_selected (a_bool: BOOLEAN) is
			-- Set `internal_is_tab_after_selected'
		require
			valid: is_tab_after
		do
			internal_is_tab_after_selected := a_bool
		ensure
			set: internal_is_tab_after_selected = a_bool
		end

	set_tab_before_selected (a_bool: BOOLEAN) is
			-- Set `internal_is_tab_before_selected'
		require
			valid: is_tab_before
		do
			internal_is_tab_before_selected := a_bool
		ensure
			set: internal_is_tab_before_selected = a_bool
		end

feature {NONE} -- Implementation

	internal_is_tab_after_selected: BOOLEAN
			-- If tab after selected?

	internal_is_tab_before_selected: BOOLEAN
			-- If tab before selected?

end
