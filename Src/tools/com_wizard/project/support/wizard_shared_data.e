indexing 
	description: "Common data used both by the GUI and the business logic"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class 
	WIZARD_SHARED_DATA

feature -- Access

	environment: WIZARD_ENVIRONMENT is
			-- Data used to generate code
		do
			Result := Shared_environment_cell.item
		end

	message_output: WIZARD_MESSAGE_OUTPUT is
			-- Shared message output.
		do
			Result := message_output_cell.item
		end

	progress_report: WIZARD_PROGRESS_REPORT is
			-- Shared wizard progress report.
		do
			Result := progress_report_cell.item
		end

feature -- Element Change

	set_shared_wizard_environment (an_environment: WIZARD_ENVIRONMENT) is
			-- Set `environment' with `an_environment'.
		require
			non_void_environment: an_environment /= Void
		do
			Shared_environment_cell.replace (an_environment)
		ensure
			environment_set: environment = an_environment
		end

	set_message_output (a_window: like message_output) is
			-- Set `message_output' with `a_window'.
		require
			non_void_window: a_window /= Void
		do
			message_output_cell.replace (a_window)
		ensure
			message_output_set: message_output = a_window
		end

	set_progress_report (a_progress_report: like progress_report) is
			-- Set `progress_report' with `a_progress_report'.
		require
			non_void_progress_report: a_progress_report /= Void
		do
			progress_report_cell.replace (a_progress_report)
		ensure
			progress_report_set: progress_report = a_progress_report
		end

feature {NONE} -- Implementation

	Shared_environment_cell: CELL [WIZARD_ENVIRONMENT] is
			-- Wizard environment shell
		indexing
			once_status: global
		once
			create Result.put (create {WIZARD_ENVIRONMENT}.make)
		end

	message_output_cell: CELL [WIZARD_MESSAGE_OUTPUT] is
			-- Output window shell
		indexing
			once_status: global
		once
			create Result.put (Void)
		end

	progress_report_cell: CELL [WIZARD_PROGRESS_REPORT] is
			-- Progress report shell
		indexing
			once_status: global
		once
			create Result.put (Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class SHARED_DATA

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
