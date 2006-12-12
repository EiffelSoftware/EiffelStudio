indexing
	description: "External C functions used by the POSIX implementation of I18N_HOST_LOCALE"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_UNIX_C_FUNCTIONS

feature {I18N_LOCALE} -- Initialization

	set_locale ( a_pointer : POINTER) is
			-- set the locale to the locale
			-- represented by the string pointed by `a_pointer'
			-- to get default locale, give pointer to ""
		require
			valid_a_pointer: a_pointer /= default_pointer
		external "C (EIF_POINTER)| %"posix_locale.h%""
		end

feature -- nl_langinfo

	get_locale_info (a_int: INTEGER): POINTER is
			--
		external "C (EIF_INTEGER): EIF_POINTER| %"posix_locale.h%""
		end

feature -- Available locales

	c_is_available (a_pointer : POINTER) : BOOLEAN is
			-- see: `is_available'
		external "C (EIF_POINTER): EIF_BOOLEAN| %"posix_locale.h%""
		alias "is_available"
		end

feature -- Informations

	c_locale_name : POINTER is
			-- see: `locale_name'
		external "C (): EIF_POINTER| %"posix_locale.h%""
		alias "locale_name"
		end

end
