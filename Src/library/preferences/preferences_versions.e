note
	description: "List all supported format versions used by the preference library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_VERSIONS

feature -- Access

	default_version: IMMUTABLE_STRING_32
			-- Default version if none specified.
		do
			Result := version_1_0
		end

	version_1_0: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("1.0")
		end

	version_2_0: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("2.0")
		end

feature -- Status report

	valid_version (a_version: detachable IMMUTABLE_STRING_32): BOOLEAN
			-- Is `a_version' a supported version?
		do
			Result := a_version /= Void and then
				(a_version.same_string (version_1_0) or a_version.same_string (version_2_0))
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
