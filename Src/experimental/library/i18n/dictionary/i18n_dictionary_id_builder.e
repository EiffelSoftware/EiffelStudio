note
	description: "Builder of identifier of a dictionary entry"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_DICTIONARY_ID_BUILDER

feature -- Access

	id_from_original_and_context (a_original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): STRING_32
			-- Id of dictionary entry from `a_original' and `a_context'
		do
			if attached a_context as l_context then
				Result := a_original.as_string_32 + a_context.as_string_32
			else
				Result := a_original.as_string_32
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
