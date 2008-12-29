note
	description: "Shared constants for the proxy"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_SHARED_CONSTANTS

inherit
	ITP_SHARED_CONSTANTS

feature -- Access

	interpreter_log_prefix: STRING = "%T-- > "
			-- Prefix of messages sent from interpreter in log file

	multi_line_value_start_tag: STRING = "---multi-line-value-start---"
			-- Multi line start tag

	multi_line_value_end_tag: STRING = "---multi-line-value-end---"
			-- Multi line end tag

	interpreter_error_prefix: STRING = "error: "
			-- Prefix for interpreter error message

	interpreter_done_message: STRING = "done:"

	interpreter_success_message: STRING = "status: success"

	interpreter_exception_message: STRING = "status: exception"

	proxy_has_started_and_connected_message: STRING = "-- Proxy has started and connected to interpreter."
			-- Message printed to the log when a new interpreter is started

	time_passed_mark: STRING = "-- Time passed: "
			-- String used in proxy log to mark the passing of every minute

	itp_start_time_message: STRING = "-- Interpreter started after: "
			-- String used in proxy log to mark the time of every intepreter start

	exception_thrown_message: STRING = "-- Exception thrown after: "
			-- String used in proxy log to mark the time elpased until an exception is thrown

end
