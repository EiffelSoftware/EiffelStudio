indexing
	description: "Shared instance of logger, classic version only provides dummy implementation for now"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGGER

feature -- Access

	Log_source: STRING is "Eiffel Metadata Consumer"
			-- Windows event log source

	Log_name: STRING is "Application"
			-- Name of log where to log events

feature -- Status Report

	source_ready: BOOLEAN is
			-- Is log source initialized?
		do
		end

feature -- Basic Operations

	log_last_exception is
			-- Log last exception to Windows event log.
		require
			source_ready: source_ready
		do
		end

	log_message (a_message: STRING) is
			-- Log `a_message' to Windows event log.
		require
			source_ready: source_ready
			attached_message: a_message /= Void
		do
		end

	create_source is
			-- Create event source if not already created.
		do
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


end -- class SHARED_LOGGER