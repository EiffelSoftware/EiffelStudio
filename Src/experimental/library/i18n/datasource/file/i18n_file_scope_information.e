note
	description: "[
				Records the scope of a file. 
				Eventually we want to support domains, and then this will be a bit more useful
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_FILE_SCOPE_INFORMATION

create
	make_with_locale,
	make_with_language

feature {NONE} -- Initialization

	make_with_locale (a_locale: I18N_LOCALE_ID )
			--
		require
			a_locale_not_void: a_locale /= Void
		do
			locale := a_locale
		end


	make_with_language (a_language: I18N_LANGUAGE_ID)
			--
		require
			language_not_void: a_language /= Void
		do
			language := a_language
		end

feature -- Scope

	scope: INTEGER
		do
			if locale /= Void then
				Result := scope_locale_specific
			elseif language /= Void then
				Result := scope_language_specific
			else
				check False end
			end
		end

	scope_locale_specific:INTEGER = 1
	scope_language_specific: INTEGER = 2
	--scope_domain_specific: INTEGER is 3 -- unused, poss. for future development.

feature -- Retrieval

	locale: detachable I18N_LOCALE_ID
	language: detachable I18N_LANGUAGE_ID

invariant
	one_set: (locale = Void and then language /= Void) or (locale /= Void and then language = Void)

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
