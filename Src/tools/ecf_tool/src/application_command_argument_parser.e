note
	description: "Summary description for {APPLICATION_COMMAND_ARGUMENT_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	APPLICATION_COMMAND_ARGUMENT_PARSER

feature -- Access

	copyright: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_general ("Copyright Eiffel Software 1985-2016. All Rights Reserved.")
		end

	version: attached STRING
			--  <Precursor>
		once
			create Result.make (5)
			Result.append_natural_16 ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_natural_16 ({EIFFEL_CONSTANTS}.minor_version)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
