note
	description: "Summary description for {DOWNLOAD_PLATFORM}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_PLATFORM

feature -- Access

	id: detachable READABLE_STRING_32
		-- Platform ID, for example linux-x86.

	icon: detachable READABLE_STRING_32
		-- Name of the associated icon.

	text: detachable READABLE_STRING_32
		-- Platform description.

feature -- Change Element

	set_id (a_id: like id)
			-- Set `id' to `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_icon (a_icon: like icon)
			-- Set `icon' to `a_icon'.
		do
			icon := a_icon
		ensure
			icon_set: icon = a_icon
		end

	set_text (a_text: like text)
			-- Set `text' to `a_text'.
		do
			text := a_text
		ensure
			text_set: text = a_text
		end


end
