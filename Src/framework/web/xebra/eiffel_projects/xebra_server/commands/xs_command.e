note
	description: "Summary description for {XS_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_COMMAND

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_OUTPUTTER
	XS_SHARED_SERVER_CONFIG

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	execute (a_server: XS_MAIN_SERVER)
			-- Executes the command.
		require
			a_server_attached: a_server /= Void
		deferred
		end

	handle_error (a_server: XS_MAIN_SERVER)
			--
		require
			a_server_attached: a_server /= Void
		local
			l_printer: XS_ERROR_PRINTER
		do
			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_errors (l_printer)
				a_server.stop := True
			end
		end
end
