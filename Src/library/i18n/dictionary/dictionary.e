indexing
	description: "Abstract description of a container for translations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_DICTIONARY

inherit
	SHARED_I18N_PLURAL_TOOLS

feature -- Creation

	make (a_plural_form: INTEGER) is
			-- Create an empty dictionary with the given plural form
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


feature  -- Manipulation

	-- this should be restricted

	extend (a_entry: I18N_DICTIONARY_ENTRY) is
			-- add a_entry in the datastructure
		require
			a_entry_exists: a_entry /= Void
			no_duplicate: not has (a_entry.original_singular)
			-- not already in datastructure
		deferred
		end

feature -- Access

	has (original: STRING_GENERAL) : BOOLEAN is
			-- is there an entry with original?
		require
			original_exists: original /= Void
		deferred
		end

	has_plural (original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): BOOLEAN is
			-- does the dictionary have an entry with `original_singular', `original_plural'
			-- and does this entry have the `plural_number'-th plural translation
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
		deferred
		end

	get_singular (original: STRING_GENERAL): STRING_32 is
			-- get the translation of `original'
			-- in the singular form
		require
			original_exists: original /= Void
			translation_exists: has (original)
		deferred
		ensure
			result_exists: Result /= Void
		end

	get_plural (original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): STRING_32 is
			-- get the translation of `original_singular'
			-- in the given plural form
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
			translation_exists: has_plural (original_singular, original_plural, plural_number)
		deferred
		ensure
			result_exists: Result /= Void
		end

feature --Information

		plural_form: INTEGER --valid constant from I18N_PLURAL_TOOLS

		count: INTEGER is
				 deferred
				 ensure
				 	count_non_negative: Result >= 0
				 end
			-- number of entries in the dictionary

feature {NONE} --Helpers

		reduce (quantity: INTEGER): INTEGER is
				-- reduce a given plural forms to a smallest one
			do
				Result := reduction_agent.item([quantity.abs])
			ensure
				well_formed_result: Result < 4 and Result >= 0
			end

		reduction_agent: FUNCTION[ANY, TUPLE[INTEGER], INTEGER]

		nplural_max: INTEGER
		nplural_lower: INTEGER is 0;

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
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
