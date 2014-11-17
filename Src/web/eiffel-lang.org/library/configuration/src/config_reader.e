note
	description: "Summary description for {CONFIG_READER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONFIG_READER

feature -- Status report

	has_item  (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Has item associated with key `k'?
		deferred
		end

feature -- Query

	text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String item associated with key `k'.
		deferred
		end

	integer_item (k: READABLE_STRING_GENERAL): INTEGER
			-- Integer item associated with key `k'.
		deferred
		ensure
			not has_item (k) implies Result = 0
		end

feature -- Duplication

	sub_config (k: READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration representing a subset of Current for key `k'.
		deferred
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
