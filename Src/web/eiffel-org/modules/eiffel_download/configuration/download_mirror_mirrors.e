note
	description: "Summary description for {DOWNLOAD_MIRROR_MIRRORS}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_MIRROR_MIRRORS


feature	-- Access

	text: detachable READABLE_STRING_32
			-- Description

	url: detachable READABLE_STRING_32
			-- Mirror's url.

	priority: INTEGER


feature -- Element Change

	set_text (a_text: like text)
			-- Assign `text' with `a_text'.
		do
			text := a_text
		ensure
			text_assigned: text = a_text
		end

	set_url (an_url: like url)
			-- Assign `url' with `an_url'.
		do
			url := an_url
		ensure
			url_assigned: url = an_url
		end

	set_priority (a_priority: like priority)
			-- Assign `priority' with `a_priority'.
		do
			priority := a_priority
		ensure
			priority_assigned: priority = a_priority
		end


end
