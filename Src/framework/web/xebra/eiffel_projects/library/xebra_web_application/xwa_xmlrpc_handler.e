note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_XMLRPC_HANDLER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Access

feature -- Status report

feature -- Status setting

feature -- Basic operations

	handle (a_request: XH_REQUEST): XH_RESPONSE
			-- Invokes the rpc calls
		require
			a_request_attached: a_request /= Void
		do
			create Result.make_empty
			if attached {XH_POST_REQUEST} a_request as l_req then
				Result.set_xml_content_type
				Result.append ("<?xml version=%"1.0%"?><methodResponse><params><param><value><string>South Dakota</string></value></param></params></methodResponse>")
			else
				Result.append ("Only POST requests allowed for XMLRPC.")
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

invariant

end

