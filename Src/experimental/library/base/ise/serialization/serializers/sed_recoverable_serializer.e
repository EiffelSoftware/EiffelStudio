note
	description: "[
		Encoding of arbitrary objects graphs between different version of
		programs containing types that might have changed and for which the
		retrieving system may know how to fix the mismatches.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_RECOVERABLE_SERIALIZER

inherit
	SED_INDEPENDENT_SERIALIZER
		redefine
			is_store_settings_enabled
		end

create
	make

feature {NONE} -- Status Report

	is_store_settings_enabled: BOOLEAN = True
			-- <Precursor>

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
