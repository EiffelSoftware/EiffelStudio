note
	description: "[
					Action sequence that handle {SD_CONTENT}.are_actions_ignored
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTIFY_ACTION_SEQUENCE

inherit
	EV_NOTIFY_ACTION_SEQUENCE
		redefine
			call
		end

	ANY
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make_with_content

create {SD_NOTIFY_ACTION_SEQUENCE}
	make_filled

feature {NONE} -- Initialization

	make_with_content (a_content: SD_CONTENT)
			-- Creation method
		do
			content := a_content

			default_create
		ensure
			set: content = a_content
		end

feature -- Command

	call (event_data: detachable TUPLE)
			-- <Precursor>
		do
			if attached content as l_content and then not l_content.are_actions_ignored then
				Precursor (event_data)
			end
		end

feature {NONE} -- Implementation

	content: detachable SD_CONTENT
			-- Associate content

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
