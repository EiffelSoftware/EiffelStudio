note
	description: "EiffelVision file selection dialog, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	full_file_path: PATH
			-- Full path of currently selected file including path.
		deferred
		end

	filter: STRING_32
			-- Filter currently applied to file list.
		deferred
		end

	filters: ARRAYED_LIST [TUPLE [filter: READABLE_STRING_GENERAL; text: READABLE_STRING_GENERAL]]
			-- All filters currently applied to file list.
			-- First element represents the filter e.g "*.txt".
			-- Second element represents the displayed text
			-- e.g. "Text files (*.txt)".

	start_path: PATH
			-- Base directory where browsing will start.
		deferred
		end

feature -- Status report

	selected_filter_index: INTEGER
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		deferred
		ensure
			result_zero_when_no_filters: filters.is_empty implies Result = 0
			valid_result_when_filters_set: not filters.is_empty implies Result >= 1 and Result <= filters.count
		end

feature -- Element change

	set_filter (a_filter: READABLE_STRING_GENERAL)
			-- Set `a_filter' as new filter.
		require
			a_filter_not_void: a_filter /= Void
		deferred
		ensure
			assigned: filter.same_string_general (a_filter)
		end

	set_full_file_path (a_path: PATH)
			-- Make `a_path' the selected file.
		require
			a_path_not_void: a_path /= Void
		deferred
		end

	set_start_path (a_path: PATH)
			-- Make `a_path' the base directory.
		require
			a_path_not_void: a_path /= Void
		deferred
		ensure
			assigned: start_path ~ a_path
		end

feature {EV_FILE_DIALOG} -- Contract support

	valid_file_name (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
		deferred
		end

	valid_file_title (a_title: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_title' a valid file title on the current platform?
		deferred
		end

invariant
	filters_not_void: filters /= Void

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




end -- class EV_FILE_DIALOG_I

