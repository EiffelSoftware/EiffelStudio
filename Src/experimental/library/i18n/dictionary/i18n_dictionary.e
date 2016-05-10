note
	description: "Abstract description of a container for translations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_DICTIONARY

inherit
	SHARED_I18N_PLURAL_TOOLS

	I18N_DICTIONARY_ID_BUILDER
		export
			{NONE} all
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a_plural_form: INTEGER)
			-- Initialize an empty dictionary with the given plural form.
			--
			-- `a_plural_form': Plural form to use in the dictionary
		require
			valid_plural_form: plural_tools.valid_plural_form (a_plural_form)
		do
			plural_form := a_plural_form
				--populate agent & nplural_max
			reduction_agent := plural_tools.get_reduction_agent (a_plural_form)
			nplural_max := plural_tools.get_nplural (a_plural_form)
		ensure
			plural_form_set: a_plural_form = plural_form
			reduction_agent_set: reduction_agent /= Void
		end

feature -- Element change

	extend (a_entry: I18N_DICTIONARY_ENTRY)
			-- Add entry to dictinary.
			--
			-- `a_entry': Entry which is added to dictionary
		require
			a_entry_not_void: a_entry /= Void
			no_duplicate: not has (a_entry.identifier)
		deferred
		end

feature -- Status report

	has (original: READABLE_STRING_GENERAL) : BOOLEAN
			-- Is there an entry with this original?
		require
			original_exists: original /= Void
		do
			Result := has_in_context (original, Void)
		end

	has_plural (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER): BOOLEAN
			-- Does the dictionary have an entry with `original_singular', `original_plural'
			-- and does this entry have the `plural_number'-th plural translation?
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
		do
			Result := has_plural_in_context (original_singular, original_plural, plural_number, Void)
		end

	has_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL) : BOOLEAN
			-- Is there an entry with this original?
		require
			original_exists: original /= Void
		deferred
		end

	has_plural_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER; a_context: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Does the dictionary have an entry with `original_singular', `original_plural'
			-- and does this entry have the `plural_number'-th plural translation?
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
		do
			Result := plural_in_context (original_singular, original_plural, plural_number, a_context) /= Void
		end

feature -- Access

	singular (original: READABLE_STRING_GENERAL): detachable STRING_32
			-- Translation of `original' in singular form
		require
			original_exists: original /= Void
		do
			Result := singular_in_context (original, Void)
		end

	plural (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER): detachable STRING_32
			-- Translation of `original_singular' in the given plural form
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
		do
			Result := plural_in_context (original_singular, original_plural, plural_number, Void)
		end

	singular_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- Translation of `original' in singular form
		require
			original_exists: original /= Void
		deferred
		end

	plural_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- Translation of `original_singular' in the given plural form
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
		deferred
		end

	plural_form: INTEGER
			-- valid constant from I18N_PLURAL_TOOLS

	count: INTEGER
			-- number of entries in the dictionary
		 deferred
		 ensure
		 	count_non_negative: Result >= 0
		 end

feature {NONE} -- Implementation

	reduce (quantity: INTEGER): INTEGER
			-- Reduce a given plural forms to a smallest one
		require
			reduction_agent_set: reduction_agent /= Void
		do
			Result := reduction_agent.item ([quantity.abs])
		ensure
			well_formed_result: Result < 4 and Result >= 0
		end

	reduction_agent: FUNCTION [INTEGER, INTEGER]
			-- Agent used to reduce plural forms

	nplural_max: INTEGER
	nplural_lower: INTEGER = 0;

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
