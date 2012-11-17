note
	description: "EiffelVision file open dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_OPEN_DIALOG_I

inherit
	EV_FILE_DIALOG_I
		redefine
			internal_accept
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?
		deferred
		end

	file_names: ARRAYED_LIST [STRING_32]
			-- Full names of currently selected files including path.
		obsolete
			"Use `file_paths' instead."
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	file_paths: ARRAYED_LIST [PATH]
			-- Full paths of currently selected files.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	enable_multiple_selection
			-- Allow multiple items to be selected.
		deferred
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		deferred
		end

feature {NONE} -- Implementation

	internal_accept: STRING_32
			-- The text of the "ok" type button of `Current'.
			-- e.g. not the cancel button.
			-- See comment in EV_STANDARD_DIALOG_I.
		do
			Result := ev_open
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
