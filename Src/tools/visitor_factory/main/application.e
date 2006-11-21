indexing
	description: "[
		Application command line entry point.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	APPLICATION

inherit
	SHARED_STATUS_MESSAGES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_layout: EIFFEL_LAYOUT
			l_parser: ARGUMENT_PARSER
		do
				-- Initialize environment
			create l_layout
			if not l_layout.is_eiffel_layout_defined then
				l_layout.set_eiffel_layout (create {EC_EIFFEL_LAYOUT})
			end

				-- Parse arguments and execute application
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Start exection of application
		require
			a_parser_attached: a_parser /= Void
		local
			l_options: APPLICATION_OPTIONS
			l_printer: TEXT_PRINTER
			l_generator: FILE_GENERATOR_ENGINE
		do
				-- Create configuration objects
			create {BASIC_TEXT_PRINTER}l_printer.make (io.default_output)
			l_printer.put_string (status_messages.scanning_files_message)
			create l_options.make (a_parser)
			l_printer.put_string (status_messages.done_message)
			l_printer.new_line

				-- Generate classes
			l_printer.put_string (status_messages.generating_visitor_class_message)
			create l_generator
			l_generator.generate_files (l_options)
			l_printer.put_string (status_messages.done_message)
			l_printer.new_line
		end

end -- class APPLICATION
