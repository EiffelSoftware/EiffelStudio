note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_XRPC_API

feature {XWA_XRPC_SERVLET} -- Initialization

	initialize
			-- Initializes the API for first use.
		do
		end

feature {XWA_XRPC_SERVLET} -- Action handlers

	on_before_call (a_name: READABLE_STRING_8; a_args: detachable TUPLE)
			-- Called prior to executing one of the registered methods in the API.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
		end

	on_after_call (a_name: READABLE_STRING_8; a_args: detachable TUPLE; a_response: detachable XRPC_RESPONSE)
			-- Called after executing one of the registered methods in the API.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
		end

end

