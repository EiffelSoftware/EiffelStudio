note
	description: "[
			XML Event filters that can forward event to 'next' filter

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_FILTER

inherit
	XML_CALLBACKS
		undefine
			default_create
		end

	XML_CALLBACKS_SOURCE
		rename
			set_callbacks as set_next
		undefine
			default_create
		end

	XML_FORWARD_CALLBACKS
		-- implementation of default behaviour:
		-- forwarding to 'next' processor in chain
		rename
			callbacks as next,
			set_callbacks as set_next
		end

create
    make_null,
	set_next

invariant
	next_not_void: next /= Void

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
