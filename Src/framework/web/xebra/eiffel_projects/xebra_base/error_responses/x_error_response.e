note
	description: "[
		Abstract class for error responses that are sent back to the HTTP server
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	X_ERROR_RESPONSE

feature -- Initialization

	make (a_arg: STRING)
			-- Initialization for Current
			-- a_arg can be empty
		do
			arg := a_arg
		ensure
			arg_set: arg = a_arg
		end

feature -- Access

	arg: STRING
		-- Can be used to pass an argument to the message

	message : STRING
			-- The message
		deferred
		end

feature -- Status report

	render_to_response: XH_RESPONSE
			-- Converts current into a response
		do
			create Result.make_empty
			Result.append (Start_msg + message + End_msg)
		end

feature -- Constants

	Start_msg: STRING = "[
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title>Xebra Server - Error report</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css">
	<!--
	body, td, th {
		font-family: Geneva, Arial, Helvetica, sans-serif;
		font-size: 12px;
	}
	h1 {
		font-size: 18px;
		background-color:#F15922;
		color: #FFFFFF;
	}
	h3 {
		font-size: 14px;
		background-color:#F15A22;
		color: #FFFFFF;
	}
	.em {
		font-size: 14px;
		background-color:#F15A22;
		color: #FFFFFF;
		margin-right: 10px;
		font-weight: bold;
	}
	-->
	</style>
	</head>
	<body>
	<h1>Xebra Server Error Report</h1>
	<hr/>
	<p><span class="em">Message:</span>
	]"

	End_msg: STRING = "[
	</p>
	<p><img src="http://www.yiyinglu.com/failwhale/images/failwhale.gif" alt="fail whale image" width="800" height="432" /></p>
	<hr/>
	<h3>Xebra Server $Revision 1$</h3>
	</body>
	</html>
	]"
end
