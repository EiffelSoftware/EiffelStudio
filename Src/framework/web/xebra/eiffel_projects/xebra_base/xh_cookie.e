note
	description: "[
		Contains all information of a rfc2109 cookie that was read from the request header
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_COOKIE

create
	make

feature {NONE} -- Initialization	

	make (a_name: STRING; a_value: STRING)
			-- Creates current.
		require
			a_name_not_empty: not a_name.is_empty
			a_value_not_empty: not a_Value.is_empty
		do
			name := a_name
			value := a_value
		ensure
			a_name_set: name = a_name
			a_value_set: value = a_value
		end

feature -- Access

	name: STRING
		--  Required.  The name of the state information ("cookie") is NAME,
		--  and its value is VALUE.  NAMEs that begin with $ are reserved for
		--  other uses and must not be used by applications.

	value: STRING
		-- The VALUE is opaque to the user agent and may be anything the
		-- origin server chooses to send, possibly in a server-selected
		-- printable ASCII encoding.  "Opaque" implies that the content is of
		-- interest and relevance only to the origin server.  The content
		-- may, in fact, be readable by anyone that examines the Set-Cookie
		-- header.


end
