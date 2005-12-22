indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TEXT_FINDER

feature -- Initialization

	make (a_texts: like texts) is
			--
		require
			a_texts_attached: a_texts /= Void
		do
			texts := a_texts
		ensure
			texts_not_void: texts = a_texts
		end

feature -- Access

	texts: ARRAYED_LIST [like last_searched]
			-- Texts search in.

	texts_found: like texts
			-- Texts found in `texts'
		require
			is_search_launched: is_search_launched
		do

		end

	found_indexs_in_texts : ARRAYED_LIST [INTEGER]
			-- Indexs of found texts in `texts'

feature -- Status report

	is_search_launched: BOOLEAN
			-- Is search_launched?

	last_searched: STRING
			-- Last searched string.

feature -- Behavior

	search (a_str: like last_searched) is
			-- Launch searching.
		require
			a_str_attached: a_str /= Void
		do
			create texts_found.make (0)
			create found_indexs_in_texts. make (0)
			is_search_launched := true
			last_searched := a_str
		ensure
			is_search_launched: is_search_launched
			last_searched_not_void: last_searched /= Void
			texts_found_not_void: texts_found /= Void
			found_indexs_in_texts_not_void : found_indexs_in_texts /= Void
		end

feature {NONE} -- Implementation

	texts_found_internal: like texts
			-- `texts_found'

invariant
	texts_not_void: texts /= Void


end
