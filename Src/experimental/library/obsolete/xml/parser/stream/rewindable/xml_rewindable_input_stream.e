note
	description: "Summary description for {XML_REWINDABLE_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_REWINDABLE_INPUT_STREAM

inherit
	XML_INPUT_STREAM

feature -- Basic operation

	rewind
			-- Move back
		deferred
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
