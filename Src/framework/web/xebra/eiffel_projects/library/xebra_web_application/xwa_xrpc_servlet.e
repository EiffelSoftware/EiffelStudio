note
	description: "[
		A servlet that can receive xml-rpc calls.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_XRPC_SERVLET [G -> XWA_XRPC_API create default_create end]

inherit
	XWA_SERVLET
		redefine
			make
		 end

	XRPC_SHARED_SERVER_DISPATCHER
		rename
			dispatcher as server_dispatcher
		export
			{NONE} all
		end

	XRPC_DELEGATE
		redefine
			initialize,
			on_before_call,
			on_after_call
		end

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor

			create {ARRAYED_LIST [XWA_CONTROLLER]} internal_controllers.make (0)


				-- Create the API object, where the XML-RPC routines will be called.
			create api

				-- Extend the dispatch server with our own delegate
			server_dispatcher.extend (Current)

				-- The {MY_XMLRPC} object should now be assigned to a dispatcher.
			check has_dispatcher: has_dispatcher end
		end

	initialize
			-- <Precursor>
		do
			Precursor

				-- Initialize the XML-RPC api class for first use.
			api.initialize
		end

feature-- Access

	frozen internal_controllers: LIST [XWA_CONTROLLER]
			-- <Precursor>
--		attribute
--			create {ARRAYED_LIST [XWA_CONTROLLER]} Result.make (0)
--		end

feature-- Implementation




	set_all_booleans (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
		end

	handle_form_internal (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			--<Precursor>
		do
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		local
			l_xmlrpc_handler: XWA_XMLRPC_HANDLER
		do
			create l_xmlrpc_handler.make
			l_xmlrpc_handler.handle (request, response, dispatcher)
		end

	clean_up_after_render (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
		do
			Result := True
		end

feature {NONE} -- Access

	frozen api: G
			-- XML-RPC api

feature {XRPC_SERVER_DISPATCHER} -- Action handlers

	on_before_call (a_name: READABLE_STRING_8; a_args: detachable TUPLE)
			-- <Precursor>
		do
			Precursor (a_name, a_args)
				-- Notify the XML-RPC that a call is about to take place.
			api.on_before_call (a_name, a_args)
		end

	on_after_call (a_name: READABLE_STRING_8; a_args: detachable TUPLE; a_response: detachable XRPC_RESPONSE)
			-- Called after executing one of the registered methods in the API.
			-- <Precursor>
		do
			Precursor (a_name, a_args, a_response)
				-- Notify the XML-RPC that a call is about to take place.
			api.on_after_call (a_name, a_args, a_response)
		end

invariant
	xrpc_api_attached: attached api

end

