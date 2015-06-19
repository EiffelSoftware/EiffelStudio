note
	description: "Summary description for {OPENID_DISCOVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPENID_DISCOVER

create
	make

feature {NONE} -- Initialization

	make (a_server_uri: READABLE_STRING_8; a_version: like version)
		do
			version := a_version
			server_uri := a_server_uri
		end

feature -- Access

	version: INTEGER
	server_uri: READABLE_STRING_8
	delegate: detachable READABLE_STRING_8 assign set_delegate
	ax_supported: BOOLEAN assign set_ax_supported
	sreg_supported: BOOLEAN assign set_sreg_supported
	identifier_select: BOOLEAN assign set_identifier_select

	has_error: BOOLEAN assign set_has_error

feature -- Change

	set_delegate (v: like delegate)
		do
			delegate := v
		end

	set_ax_supported (v: like ax_supported)
		do
			ax_supported := v
		end

	set_sreg_supported (v: like sreg_supported)
		do
			sreg_supported := v
		end

	set_identifier_select (v: like identifier_select)
		do
			identifier_select := v
		end

	set_has_error (v: like has_error)
		do
			has_error := v
		end

end
