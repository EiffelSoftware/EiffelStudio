indexing
	description: "Shared constants for the proxy"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_SHARED_CONSTANTS

inherit
	ITP_SHARED_CONSTANTS

feature -- Access

	interpreter_log_prefix: STRING is "%T-- > "
			-- Prefix of messages sent from interpreter in log file

	multi_line_value_start_tag: STRING is "---multi-line-value-start---"
			-- Multi line start tag

	multi_line_value_end_tag: STRING is "---multi-line-value-end---"
			-- Multi line end tag

	interpreter_error_prefix: STRING is "error: "
			-- Prefix for interpreter error message

	interpreter_done_message: STRING is "done:"

	interpreter_success_message: STRING is "status: success"

	interpreter_exception_message: STRING is "status: exception"

	proxy_has_started_and_connected_message: STRING is "-- Proxy has started and connected to interpreter."
			-- Message printed to the log when a new interpreter is started

	time_passed_mark: STRING is "-- Time passed: "
			-- String used in proxy log to mark the passing of every minute

	itp_start_time_message: STRING is "-- Interpreter started after: "
			-- String used in proxy log to mark the time of every intepreter start

	exception_thrown_message: STRING is "-- Exception thrown after: "
			-- String used in proxy log to mark the time elpased until an exception is thrown

end
