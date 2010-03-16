note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TOOLS

feature -- Initialization

	locale: I18N_LOCALE
			-- return current locale
			-- if void create
		do
			if current_locale /= Void then
				Result := current_locale
			else
				create locale_manager.make (Operating_environment.Current_directory_name_representation+
											Operating_environment.Directory_separator.out+"mo_files")
				current_locale := locale_manager.system_locale
				available_locales := locale_manager.available_locales
				Result := current_locale
			end
		end

	set_locale (a_locale: STRING_32)
			-- set current localeto a_locale if available
			-- else live it unchanged
		local
			l_locale_id: I18N_LOCALE_ID
		do
			create l_locale_id.make_from_string (a_locale)
			from
				available_locales.start
			until
				available_locales.after or else available_locales.item.name.is_equal (l_locale_id.name)
--				available_locales.item.is_equal (l_locale_id)
			loop
				available_locales.forth
			end
			if not available_locales.after then
				current_locale := locale_manager.locale (available_locales.item)
			end
		end




feature {NONE} -- Locale

	locale_manager: I18N_LOCALE_MANAGER
	current_locale: I18N_LOCALE
	available_locales: LIST[I18N_LOCALE_ID];

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
