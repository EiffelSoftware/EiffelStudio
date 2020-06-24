note
	description: "Simple implementation of {SUGGESTION_ITEM} consisting of only a text label, and a custom displayed text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_LABEL_SUGGESTION_ITEM

inherit
	LABEL_SUGGESTION_ITEM
		redefine
			displayed_text
		end

create
	make

feature -- Access

	displayed_text: IMMUTABLE_STRING_32
			-- Rendered version of `text' used for display purpose.
		do
			Result := internal_displayed_text
			if Result = Void then
				Result := text
			end
		end

	internal_displayed_text: detachable IMMUTABLE_STRING_32

feature -- Element change

	set_displayed_text (a_text: detachable READABLE_STRING_GENERAL)
		do
			if a_text = Void then
				internal_displayed_text := Void
			else
				create internal_displayed_text.make_from_string_general (a_text)
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
