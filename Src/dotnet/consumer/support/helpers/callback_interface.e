indexing
	description: "Agents used for callbacks during processing"

class
	CALLBACK_INTERFACE

feature -- Access

	status_querier: FUNCTION [ANY, TUPLE[], BOOLEAN]
			-- Check whether to stop process
	
	status_printer, error_printer: ROUTINE [ANY, TUPLE [STRING]]
			-- Print status and error messages

feature -- Element settings

	set_status_querier (querier: like status_querier) is
			-- Set `status_querier' with `querier'.
		require
			non_void_querier: querier /= Void
		do
			status_querier := querier
		ensure
			status_querier_set: status_querier = querier
		end
		
	set_status_printer (printer: like status_printer) is
			-- Set `status_printer' with `printer'.
		require
			non_void_printer: printer /= Void
		do
			status_printer := printer
		ensure
			status_printer_set: status_printer = printer
		end
		
	set_error_printer (printer: like error_printer) is
			-- Set `status_querier' with `printer'.
		require
			non_void_printer: printer /= Void
		do
			error_printer := printer
		ensure
			error_printer_set: error_printer = printer
		end

end -- class CALLBACK_INTERFACE
