indexing
	description : "xebra_translator application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			
		end



	parse_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
		-- Parse open stream.
	require
		a_stream_not_void: a_stream /= Void
		a_stream_open: a_stream.is_open_read
	local
		a_parser: XM_PARSER
		a_consumer: TAGCOUNT_CALLBACKS
	do
		-- Create the parser.
		-- It is left in the default state, which means:
		-- ascii only, no external entities or DTDs,
		-- no namespace resolving.
		create {XM_EIFFEL_PARSER} a_parser.make

		-- Create the event consumer that counts start tags.
		create {TAGCOUNT_CALLBACKS} a_consumer.make
		a_parser.set_callbacks (a_consumer)

		-- Parse and display result
		a_parser.parse_from_stream (a_stream)
		if not a_parser.is_correct then
	--		error_handler.report_error_message (a_parser.last_error_extended_description)
		else
		--	error_handler.report_info_message ("Number of tags found: " + a_consumer.count.out)
		end
	end


end
