note
	description: "Text replacer which replaces placeholders in a string with new texts provided by text fragments"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_REPLACER

feature -- Text replacement

	new_text (a_text: STRING): STRING
			-- New text for `a_text' with all replacements defined in `text_fragments' applied
		require
			a_text_attached: a_text /= Void
			text_available: is_new_text_available
		local
			l_next_start_index: INTEGER
			l_fragment_start_index: INTEGER
			l_sorted_fragments: PART_SORTED_TWO_WAY_LIST [EB_TEXT_FRAGMENT]
			l_actual_fragments: ARRAYED_LIST [EB_TEXT_FRAGMENT]
			l_cache: like text_fragment_cache
			l_fragment: EB_TEXT_FRAGMENT
			l_cached_fragment: EB_TEXT_FRAGMENT
			l_decorated_fragment: EB_TEXT_FRAGMENT_DECORATOR
		do
			create l_sorted_fragments.make
			l_sorted_fragments.append (text_fragments)
			l_sorted_fragments.sort

			l_next_start_index := 1
			l_cache := text_fragment_cache
			create Result.make (a_text.count)
			create l_actual_fragments.make (l_sorted_fragments.count)

			from
				l_sorted_fragments.start
			until
				l_sorted_fragments.after
			loop
				l_fragment := l_sorted_fragments.item

					-- Check cache, if some replacement is aleady in cache, use the cached one, otherwise, put the replacement into cache.
				l_cached_fragment := l_cache.item (l_fragment.normalized_text)
				if l_cached_fragment /= Void then
					create l_decorated_fragment.make (l_fragment.text, l_cached_fragment)
					l_decorated_fragment.set_location (l_fragment.location)
					l_fragment := l_decorated_fragment
				else
					l_cache.put (l_fragment, l_fragment.normalized_text)
				end

					-- Apply replacement.
				l_fragment_start_index := l_fragment.location
				if l_next_start_index < l_fragment_start_index then
					Result.append (a_text.substring (l_next_start_index, l_fragment_start_index - 1))
				end
				Result.append (l_fragment.new_text)
				l_next_start_index := l_fragment_start_index + l_fragment.text_count
				l_sorted_fragments.forth
			end
			if l_next_start_index <= a_text.count then
				Result.append (a_text.substring (l_next_start_index, a_text.count))
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Access

	text_fragments: LIST [EB_TEXT_FRAGMENT]
			-- Text fragments where replacements are defined
		do
			if text_fragments_internal = Void then
				create {LINKED_LIST [EB_TEXT_FRAGMENT]} text_fragments_internal.make
			end
			Result := text_fragments_internal
		ensure
			result_attached: Result /= Void
		end

	text_fragment_cache: HASH_TABLE [EB_TEXT_FRAGMENT, STRING]
			-- Text fragment cache [text fragment, normalized text fragment name].
			-- Cache is used to avoid duplicated calculation for replacements.
			-- For example, if we want to replace all "$file_name" in string "$file_name, $file_name",
			-- after analysis the string, we get two fragments, and the normalized name of both fragments is "$file_name",
			-- so after calculating the replacement and apply the first replacement, we put the fragment in to cache,
			-- when it comes to replace the second fragment, we just read the cache and apply replacement directly without another calculation.
		do
			if text_fragment_cache_internal = Void then
				create text_fragment_cache_internal.make (10)
			end
			Result := text_fragment_cache_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_new_text_available: BOOLEAN
			-- Is `new_text' available?
			-- If all fragments in `text_fragments' have been prepared, then `new_text' is available.
			-- Call `prepare_replacement' to prepare.
			-- When `new_text' is not needed anymore, call `dispose_replacement'.
		do
			Result := text_fragments.for_all (agent (a_fragment: EB_TEXT_FRAGMENT): BOOLEAN do Result := a_fragment.is_replacement_prepared end)
		end

feature -- Synchronize status

	prepare_replacement
			-- Prepare `text_fragments'.
			-- Should be called before the first time you call `new_text' after every change in `text_fragments'.
		do
			text_fragments.do_all (agent (a_fragment: EB_TEXT_FRAGMENT) do a_fragment.safe_prepare_before_replacement end)
		end

	dispose_replacement
			-- Dispose `text_fragments'.
			-- Should be called after the last time you call `new_text'.
		do
			text_fragments.do_all (agent (a_fragment: EB_TEXT_FRAGMENT) do a_fragment.safe_dispose_after_replacement end)
		end

feature{NONE} -- Implementation

	text_fragments_internal: like text_fragments
			-- Implementation of `text_fragments'

	text_fragment_cache_internal: like text_fragment_cache
			-- Implementation of `text_fragment_cache'

end
