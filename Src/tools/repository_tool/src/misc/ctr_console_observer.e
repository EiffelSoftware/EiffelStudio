note
	description: "Summary description for {CTR_CONSOLE_OBSERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CTR_CONSOLE_OBSERVER

feature -- Access

	log (m: STRING_GENERAL)
			-- Log message `m'
		require
			m_attached: m /= Void
		deferred
		end

end
