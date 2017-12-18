note
	description: "Generic {MODULE_LOADER} representing an dynamic loaded library or static librart."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MODULE_LOADER

feature -- Query

	api_pointer (a_api_name: READABLE_STRING_8): POINTER
		deferred
		end

feature -- Clean up

	unload
		deferred
		end

feature -- Status Report

	is_interface_usable: BOOLEAN
		deferred
		end
note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
