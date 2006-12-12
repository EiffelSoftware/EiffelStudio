indexing
	description: "[
				Records the scope of a file. 
				Eventually we want to support domains, and then this will be a bit more useful
					]"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_FILE_SCOPE_INFORMATION

create
	make_with_locale,
	make_with_language

feature -- Initialization

		make_with_locale (a_locale: I18N_LOCALE_ID ) is
				--
			require
				a_locale_not_void: a_locale /= Void
			do
				scope := 1
				locale := a_locale
			end


		make_with_language (a_language: I18N_LANGUAGE_ID) is
				--
			require
				language_not_void: a_language /= Void
			do
				scope := 2
				language := a_language
			end

feature -- Scope

	scope: INTEGER

	scope_locale_specific:INTEGER is 1
	scope_language_specific: INTEGER is 2
	--scope_domain_specific: INTEGER is 3 -- unused, poss. for future development.

feature
	-- Retrieval

	get_locale:I18N_LOCALE_ID is
			--
		require
			scope = scope_locale_specific
		do
			Result := locale
		end

	get_language: I18N_LANGUAGE_ID is
			--
		require
			scope = scope_language_specific
		do
			Result := language
		end



feature {NONE} -- Information

	locale: I18N_LOCALE_ID
	language: I18N_LANGUAGE_ID


end
