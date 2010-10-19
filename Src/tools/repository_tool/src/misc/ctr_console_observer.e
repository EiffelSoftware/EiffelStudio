note
	description: "Summary description for {CTR_CONSOLE_OBSERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CTR_CONSOLE_OBSERVER

feature -- Access

	log_custom (m: STRING_GENERAL; t: INTEGER)
		do
			inspect t
			when {CTR_CONSOLE}.log_warning_type then
				log_warning (m)
			when {CTR_CONSOLE}.log_error_type then
				log_error (m)
			else
				log (m)
			end
		end

	log (m: STRING_GENERAL)
			-- Log message `m'
		require
			m_attached: m /= Void
		deferred
		end

	log_error (m: STRING_GENERAL)
			-- Log message `m'
		require
			m_attached: m /= Void
		deferred
		end

	log_warning (m: STRING_GENERAL)
			-- Log message `m'
		require
			m_attached: m /= Void
		deferred
		end

end
