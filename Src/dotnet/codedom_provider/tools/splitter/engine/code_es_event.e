indexing
	description: "Event that occured during file splitting"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_EVENT

inherit
	EV_THREAD_EVENT
		rename
			make as ev_make
		end

create
	make

feature {NONE} -- Implementation

	make (a_message, a_title: STRING; a_severity: INTEGER) is
			-- Initialize instance.
		require
			non_void_message: a_message /= Void
			non_void_title: a_title /= Void
			valid_severity: is_valid_severity (a_severity)
		do
			message := a_message
			title := a_title
			severity := a_severity
		ensure
			message_set: message = a_message
			title_set: title = a_title
			severity_set: severity = a_severity
		end

feature -- Access

	message: STRING
			-- Event message
	
	title: STRING
			-- Event title

end -- class CODE_ES_EVENT

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------