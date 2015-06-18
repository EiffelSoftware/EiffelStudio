note
	description: "Processor-local access to a separate SUBJECT."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_PROXY [SUBJECT, UTILS -> ANY create default_create end]

feature {NONE} -- Initialization

	make (a_subject: separate like subject)
			-- Initialization for `Current'.
		do
			subject := a_subject
			create utils
			default_create
		ensure
			subject_set: subject = a_subject
		end

feature -- Access

	subject: separate SUBJECT
			-- The actual subject proxied by `Current'.

feature {NONE} -- Implementation

	utils: UTILS
			-- Helper functions to access the separate `subject'.

end
