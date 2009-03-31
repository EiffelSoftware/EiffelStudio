note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XH_SESSION_MANAGER

--create
--	make

--feature {NONE} -- Initialization

--	make
--			-- Initialization for `Current'.
--		do
--			create sessions.make


--		end

feature -- Basic operations




	get_session (a_uuid: STRING): XH_SESSION
			--

		deferred
		end

	generate_cookies (a_response: XH_RESPONSE)
			--
		deferred
		end




feature -- Access

	sessions: HASH_TABLE [XH_SESSION, STRING]


feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
