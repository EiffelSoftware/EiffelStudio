note
	description:	"Abstract notion of a log writer"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

deferred class
	LOG_WRITER

inherit
	LOG_PRIORITY_CONSTANTS

feature {LOG_LOGGING_FACILITY} -- Initialization
	
	initialize
			-- Initialize the log writer
		require
			not_is_initialized: not is_initialized
		deferred
		ensure
			is_initialized_or_has_errors: is_initialized or has_errors
		end

feature -- Status Report

	has_errors: BOOLEAN
			-- Did an error occur during initialization?

	is_initialized: BOOLEAN
			-- Is this log writer initialized?

feature {LOG_LOGGING_FACILITY} -- Output

	write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to this log
		require
			is_initialized: is_initialized
			not_suspended: not suspended
			valid_msg: msg /= Void and then not msg.is_empty
		deferred
		ensure
			is_initialized: is_initialized
		end

feature {LOG_LOGGING_FACILITY} -- Access

	suspend
			-- Suspend output to this log writer
		do
			suspended := True
		end

	resume
			-- Resume output to this log writer
		do
			suspended := False
		end

feature {LOG_LOGGING_FACILITY} -- Status Report

	suspended: BOOLEAN;
			-- Is out to this log writer suspended?

note
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (See http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone 0044-208-742-3422 Fax 0044-208-742-3468
					Website http://www.itpassion.com
					Customer Support http://powerdesk.itpassion.com
				]"

end
