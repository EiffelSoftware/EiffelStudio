indexing 
	description: "Common data used both by the GUI and the business logic"
	status: "See notice at end of class";
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

end -- class SHARED_DATA

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
