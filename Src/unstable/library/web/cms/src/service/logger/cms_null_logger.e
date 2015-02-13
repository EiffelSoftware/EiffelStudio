note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CMS_NULL_LOGGER

inherit
	CMS_LOGGER

feature -- Logging

	put_information (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
		end

	put_error (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
		end

	put_warning (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
		end

	put_critical (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
		end

	put_alert (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
		end

	put_debug (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
		end

end
