note
	description:
		"[
			Null resolver that always fails

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_NULL_EXTERNAL_RESOLVER

inherit

	XML_EXTERNAL_RESOLVER

feature -- Action(s)

	resolve (a_system: READABLE_STRING_GENERAL)
			-- Fails.
		do
		ensure then
			fails: has_error
		end

feature -- Result

	has_error: BOOLEAN
			-- Always true
		do
			Result := True
		ensure then
			fails: Result
		end

	last_error: detachable STRING_32
			-- Error message.
		do
			Result := {STRING_32} "external entities not supported"
		end

	last_stream: detachable XML_INPUT_STREAM
			-- Not used.
		do
		ensure then
			never_called: False
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
