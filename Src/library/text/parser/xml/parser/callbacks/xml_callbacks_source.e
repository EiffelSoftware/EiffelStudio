note
	description: "[
			Source of XML event callbacks
	
			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_CALLBACKS_SOURCE

feature -- Element change

	set_callbacks (a_callback: XML_CALLBACKS)
			-- Client will receive callbacks to.
		require
			a_callback_not_void: a_callback /= Void
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
