indexing
	description	: "Manager for output and error messages"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_OUTPUT_MANAGER

inherit
	ERROR_DISPLAYER

feature -- Basic Operations / Generic purpose

	clear is
			-- Clear the window.
		deferred
		end

	process_text (st: STRUCTURED_TEXT) is
			-- Print `st' on all output tools.
		deferred
		end

	clear_and_process_text (st: STRUCTURED_TEXT) is
			-- Clear window and print `st' on all output tools.
		deferred
		end

feature -- Basic Operations / Information message

	display_system_info is
			-- Print information about the current project.
		deferred
		end

	display_welcome_info is
			-- Display information on how to launch $EiffelGraphicalCompiler$.
		deferred
		end

	display_application_status is
			-- Display the application status.
		deferred
		end

	display_stop_points is
			-- Display the breakpoints status.
		deferred
		end

end -- class EB_OUTPUT_MANAGER
