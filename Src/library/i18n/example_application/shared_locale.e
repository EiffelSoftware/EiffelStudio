indexing
	description: "Objects that ..."
	author		: "i18n-team (es-i18n@origo.ethz.ch)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TOOLS

feature -- Initialization

	locale: I18N_LOCALE is
			-- return current locale
			-- if void create
		do
			if current_locale /= Void then
				Result := current_locale
			else
				create locale_manager.make (Operating_environment.Current_directory_name_representation+
											Operating_environment.Directory_separator.out+"mo_files")
				current_locale := locale_manager.get_system_locale
				available_locales := locale_manager.available_locales
				Result := current_locale
			end
		end

	set_locale (a_locale: STRING_32) is
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
				current_locale := locale_manager.get_locale (available_locales.item)
			end
		end




feature {NONE} -- Locale

	locale_manager: I18N_LOCALE_MANAGER
	current_locale: I18N_LOCALE
	available_locales: LIST[I18N_LOCALE_ID]

end
