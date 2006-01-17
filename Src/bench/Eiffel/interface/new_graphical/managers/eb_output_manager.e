indexing
	description	: "Manager for output and error messages"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	scroll_to_end is
			-- Scroll to end of text.
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

	display_breakpoints is
			-- Display the breakpoints status.
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_OUTPUT_MANAGER
