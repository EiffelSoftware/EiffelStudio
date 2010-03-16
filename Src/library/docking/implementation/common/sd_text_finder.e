note
	description: "Find texts that contain certain string, wildcard matcher based."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TEXT_FINDER [G -> STRING_GENERAL]

create
	make

feature -- Initialization

	make (a_texts: like texts)
			-- Set `texts' with `a_texts'.
		require
			a_texts_attached: a_texts /= Void
		do
			texts := a_texts
			init_wild_matcher

			create texts_found_internal.make (10)
			create found_indexs_in_texts_internal.make (10)
		ensure
			texts_not_void: texts = a_texts
			wild_matcher_not_void: wild_matcher /= Void
		end

	init_wild_matcher
			-- Initialize `wild_matcher'
		do
			create wild_matcher.make_empty
			wild_matcher.disable_case_sensitive
--			pcre_re.set_caseless (True)
--			pcre_re.set_empty_allowed (false)
--			pcre_re.set_multiline (false)
		end

feature -- Access

	texts: ARRAYED_LIST [G]
			-- Texts search in

	texts_found: like texts
			-- Texts found in `texts'
		require
			is_search_launched: is_search_launched
		do
			Result := texts_found_internal
		ensure
			texts_found_not_void: Result /= Void
		end

	found_indexs_in_texts : ARRAYED_LIST [INTEGER]
			-- Indexs of found texts in `texts'
		require
			is_search_launched: is_search_launched
		do
			Result := found_indexs_in_texts_internal
		ensure
			found_indexs_in_texts_not_void: Result /= Void
		end

feature -- Status report

	is_search_launched: BOOLEAN
			-- Is search_launched?

	last_searched: detachable G
			-- Last searched string

feature -- Behavior

	search (a_str: like last_searched)
			-- Launch searching
		require
			a_str_attached: a_str /= Void
		do
			search_perform (a_str)
			is_search_launched := true
			last_searched := a_str
		ensure
			is_search_launched: is_search_launched
			last_searched_not_void: last_searched /= Void
			texts_found_not_void: texts_found_internal /= Void
			found_indexs_in_texts_not_void : found_indexs_in_texts_internal /= Void
		end

feature {NONE} -- Implementation

	search_perform (a_str: STRING_GENERAL)
			-- Perform searching
		do
			texts_found_internal.wipe_out
			found_indexs_in_texts_internal.wipe_out

			wild_matcher.set_pattern (a_str.as_string_8)
--			pcre_re.compile (a_str.as_string_8)
			from
				texts.start
			until
--				texts.after or not pcre_re.is_compiled
				texts.after
			loop
				wild_matcher.set_text (texts.item.as_string_8)
--				pcre_re.match (texts.item.as_string_8)
				if wild_matcher.search_for_pattern then
					texts_found_internal.extend (texts.item)
					found_indexs_in_texts_internal.extend (texts.index)
				end
--				if pcre_re.has_matched then
--					texts_found_internal.extend (texts.item)
--					found_indexs_in_texts_internal.extend (texts.index)
--				end
				texts.forth
			end
		end

	texts_found_internal: like texts
			-- `texts_found'

	found_indexs_in_texts_internal: like found_indexs_in_texts
			-- `found_indexs_in_texts'

--	pcre_re: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression matcher

	wild_matcher: KMP_WILD
			-- Wild card matcher

invariant
	texts_not_void: texts /= Void
--	pcre_re_not_void: pcre_re /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
