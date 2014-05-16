note
	description : "[
			Use {XML_STOPPABLE_PARSER}
		]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_LITE_STOPPABLE_PARSER

obsolete "Use {XML_STOPPABLE_PARSER} [2012-oct]"

inherit
	XML_LITE_PARSER
		redefine
			reset, report_error,
			set_checkpoint_position, unset_checkpoint_position, checkpoint_position
		end

create
	make

feature -- Settings

	error_ignored: BOOLEAN
			-- Ignore error?
			-- If True, do not stop parser on error (no guarantee)
			-- Default: False			

feature -- Settings change

	set_error_ignored (b: BOOLEAN)
			-- Set `error_ignored' to `b'
		do
			error_ignored := b
		end

feature -- Status change

	abort, request_stop
			-- Request the parser to stop
		do
			stop_requested := True
			parsing_stopped := True
		end

feature -- Parsing status

	stop_requested: BOOLEAN
			-- Requested to stop parsing

feature -- Element change

	reset
			-- Reset parser states
		do
			Precursor
			stop_requested := False
		ensure then
			stop_requested_unset: not stop_requested
		end

feature {NONE} -- Implementation

	checkpoint_position: detachable XML_POSITION
		do
			if checkpoint_position_line > 0 then
				create Result.make (buffer.name, checkpoint_position_byte_index, checkpoint_position_column, checkpoint_position_line)
			end
		end

	checkpoint_position_line: like line
	checkpoint_position_column: like column
	checkpoint_position_byte_index: like byte_index

	set_checkpoint_position
		do
			checkpoint_position_line := line
			checkpoint_position_column := column
			checkpoint_position_byte_index := byte_index
		end

	unset_checkpoint_position
		do
			checkpoint_position_line := 0
			checkpoint_position_column := 0
			checkpoint_position_byte_index := 0
		end

feature {NONE} -- Implementation: parse

	report_error (a_message: READABLE_STRING_GENERAL)
			-- Report error with message `a_message'
		do
			Precursor (a_message)
			parsing_stopped := not error_ignored
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
