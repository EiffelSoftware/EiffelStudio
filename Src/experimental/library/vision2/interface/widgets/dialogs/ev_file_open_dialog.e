note
	description:
		"Eiffel Vision file open dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_OPEN_DIALOG

inherit
	EV_FILE_DIALOG
		rename
			ok_actions as open_actions
		redefine
			implementation
		end

create
	default_create,
	make_with_title


feature -- Event handling

	ok_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when user clicks Open.
		obsolete
			"This has been replaced by open_actions"
		do
			Result := open_actions
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more than one filename be selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.multiple_selection_enabled
		ensure
			bridge_ok: Result = implementation.multiple_selection_enabled
		end

	file_names: ARRAYED_LIST [STRING_32]
			-- Full names of currently selected files including path.
			-- No particular order is guaranteed.
		obsolete
			"Use `file_paths' instead."
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_names
		ensure
			Result_not_void: Result /= Void
		end

	file_paths: ARRAYED_LIST [PATH]
			-- Full paths of currently selected files.
			-- No particular order is guaranteed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_paths
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	enable_multiple_selection
			-- Allow more than one filename to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_selection
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection
			-- Allow only one filename to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_multiple_selection
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FILE_OPEN_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FILE_OPEN_DIALOG_IMP} implementation.make
		end

invariant
	full_file_path_consistent_with_file_paths: not file_paths.is_empty implies file_paths.first.is_equal (full_file_path)

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
