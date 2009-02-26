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
			scope := scope_locale_specific
			locale := a_locale
		end


	make_with_language (a_language: I18N_LANGUAGE_ID)
			--
		require
			language_not_void: a_language /= Void
		do
			scope := scope_language_specific
			language := a_language
		end

feature -- Scope

	scope: INTEGER

	scope_locale_specific:INTEGER = 1
	scope_language_specific: INTEGER = 2
	--scope_domain_specific: INTEGER is 3 -- unused, poss. for future development.

feature -- Retrieval

	get_locale: attached I18N_LOCALE_ID
			--
		require
			scope = scope_locale_specific
		local
			l_locale: like locale
		do
			l_locale := locale
			check l_locale /= Void end -- Implied by precondition
			Result := l_locale
		end

	get_language: attached I18N_LANGUAGE_ID
			--
		require
			scope = scope_language_specific
		local
			l_lang: like language
		do
			l_lang := language
			check l_lang /= Void end -- Implied by precondition
			Result := l_lang
		end

feature {NONE} -- Information

	locale: detachable I18N_LOCALE_ID
	language: detachable I18N_LANGUAGE_ID;

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
