note
	description: "Dialog constants. Standard strings displayed on "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_NAMES

feature -- Button Texts

	ev_ok: IMMUTABLE_STRING_32
			-- Text displayed on "ok" buttons.
		once
			create Result.make_from_string_general ("OK")
		end

	ev_open: IMMUTABLE_STRING_32
			-- Text displayed on "open" buttons.
		once
			create Result.make_from_string_general ("Open")
		end

	ev_save: IMMUTABLE_STRING_32
			-- Text displayed on "save" buttons.
		once
			create Result.make_from_string_general ("Save")
		end

	ev_print: IMMUTABLE_STRING_32
			-- Text displayed on "print" buttons.
		once
			create Result.make_from_string_general ("Print")
		end

	ev_cancel: IMMUTABLE_STRING_32
			-- Text displayed on "cancel" buttons.
		once
			create Result.make_from_string_general ("Cancel")
		end

	ev_yes: IMMUTABLE_STRING_32
			-- Text displayed on "yes" buttons.
		once
			create Result.make_from_string_general ("Yes")
		end

	ev_no: IMMUTABLE_STRING_32
			-- Text displayed on "no" buttons.
		once
			create Result.make_from_string_general ("No")
		end

	ev_abort: IMMUTABLE_STRING_32
			-- Text displayed on "abort" buttons.
		once
			create Result.make_from_string_general ("Abort")
		end

	ev_retry: IMMUTABLE_STRING_32
			-- Text displayed on "retry" buttons.
		once
			create Result.make_from_string_general ("Retry")
		end

	ev_ignore: IMMUTABLE_STRING_32
			-- Text displayed on "ignore" buttons.
		once
			create Result.make_from_string_general ("Ignore")
		end

feature -- Titles

	ev_warning_dialog_title: IMMUTABLE_STRING_32
			-- Title of EV_WARNING_DIALOG.
		once
			create Result.make_from_string_general ("Warning")
		end

	ev_question_dialog_title: IMMUTABLE_STRING_32
			-- Title of EV_QUESTION_DIALOG.
		once
			create Result.make_from_string_general ("Question")
		end

	ev_information_dialog_title: IMMUTABLE_STRING_32
			-- Title of EV_INFORMATION_DIALOG.
		once
			create Result.make_from_string_general ("Information")
		end

	ev_error_dialog_title: IMMUTABLE_STRING_32
			-- Title of EV_ERROR_DIALOG.
		once
			create Result.make_from_string_general ("Error")
		end

	ev_confirmation_dialog_title: IMMUTABLE_STRING_32
			-- Title of EV_CONFIRMATION_DIALOG.
		once
			create Result.make_from_string_general ("Confirmation")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
