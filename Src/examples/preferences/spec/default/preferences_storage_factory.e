note
	description	: "Preferences storage factory for the example"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"

class PREFERENCES_STORAGE_FACTORY

feature -- Access

	storage_for_basic: PREFERENCES_STORAGE_I
		do
	 		create {PREFERENCES_STORAGE_DEFAULT} Result.make_empty
	 	end

	storage_for_custom: PREFERENCES_STORAGE_I
		do
	 		create {PREFERENCES_STORAGE_DEFAULT} Result.make_empty
	 	end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
