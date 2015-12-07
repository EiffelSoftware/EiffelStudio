note
	description: "Represent a search result, include the URL, title and text snippets that describe the result"
	date: "$Date$"
	revision: "$Revision$"

class
	GCSE_PAGE_ITEM

inherit
	DEBUG_OUTPUT

feature -- Access

	html_formatted_url: detachable STRING_8
			-- Html formatted url of this result

	formatted_url: detachable STRING_8
			-- Formatted url of this result

	cache_id: detachable STRING_8
			-- Cache id of this result

	html_snippet: detachable STRING_8
			-- Html snippet of this request

	snippet: detachable STRING_8
			-- Snippet of this result

	display_link: detachable STRING_8
			-- Display link of this result

	link: detachable STRING_8
			-- link of this result

	html_title: detachable STRING_8
			-- html title of result

	title: detachable STRING_8
			-- title of result.

	kind: detachable STRING_8
			-- Kind of actual search result.

	page_map: detachable GCSE_PAGE_MAP
			-- Page map
			--! Not supported for now.

feature -- Element change

	set_html_formatted_url (a_html_formatted_url: like html_formatted_url)
			-- Assign `html_formatted_url' with `a_html_formatted_url'.
		do
			html_formatted_url := a_html_formatted_url
		ensure
			html_formatted_url_assigned: html_formatted_url = a_html_formatted_url
		end

	set_formatted_url (a_formatted_url: like formatted_url)
			-- Assign `formatted_url' with `a_formatted_url'.
		do
			formatted_url := a_formatted_url
		ensure
			formatted_url_assigned: formatted_url = a_formatted_url
		end

	set_cache_id (a_cache_id: like cache_id)
			-- Assign `cache_id' with `a_cache_id'.
		do
			cache_id := a_cache_id
		ensure
			cache_id_assigned: cache_id = a_cache_id
		end

	set_html_snippet (a_html_snippet: like html_snippet)
			-- Assign `html_snippet' with `a_html_snippet'.
		do
			html_snippet := a_html_snippet
		ensure
			html_snippet_assigned: html_snippet = a_html_snippet
		end

	set_snippet (a_snippet: like snippet)
			-- Assign `snippet' with `a_snippet'.
		do
			snippet := a_snippet
		ensure
			snippet_assigned: snippet = a_snippet
		end

	set_display_link (a_display_link: like display_link)
			-- Assign `display_link' with `a_display_link'.
		do
			display_link := a_display_link
		ensure
			display_link_assigned: display_link = a_display_link
		end

	set_link (a_link: like link)
			-- Assign `link' with `a_link'.
		do
			link := a_link
		ensure
			link_assigned: link = a_link
		end

	set_html_title (a_html_title: like html_title)
			-- Assign `html_title' with `a_html_title'.
		do
			html_title := a_html_title
		ensure
			html_title_assigned: html_title = a_html_title
		end

	set_title (a_title: like title)
			-- Assign `title' with `a_title'.
		do
			title := a_title
		ensure
			title_assigned: title = a_title
		end

	set_kind (a_kind: like kind)
			-- Assign `kind' with `a_kind'.
		do
			kind := a_kind
		ensure
			kind_assigned: kind = a_kind
		end

	set_page_map (a_map: like page_map)
			-- Assign `kind' with `a_kind'.
		do
			page_map := a_map
		ensure
			page_map_assigned: page_map = a_map
		end


feature -- Output

	debug_output: STRING_8
			-- <Precursor>
		do
			create Result.make_from_string ("%NPage Item details%N")
			if attached title as l_title then
				Result.append ("Title:")
				Result.append (l_title)
				Result.append_character ('%N')
			end
			if attached kind as l_kind then
				Result.append ("Kind:")
				Result.append (l_kind)
				Result.append_character ('%N')
			end
			if attached html_title as l_html_title then
				Result.append ("Html title:")
				Result.append (l_html_title)
				Result.append_character ('%N')
			end
			if attached link as l_link then
				Result.append ("Link:")
				Result.append (l_link)
				Result.append_character ('%N')
			end
			if attached display_link as l_display_link then
				Result.append ("Display link:")
				Result.append (l_display_link)
				Result.append_character ('%N')
			end
			if attached snippet as l_snippet then
				Result.append ("Snippet:")
				Result.append (l_snippet)
				Result.append_character ('%N')
			end
			if attached html_snippet as l_html_snippet then
				Result.append ("Html snippet:")
				Result.append (l_html_snippet)
				Result.append_character ('%N')
			end
			if attached cache_id as l_cache_id then
				Result.append ("Cache_id:")
				Result.append (l_cache_id)
				Result.append_character ('%N')
			end
			if attached formatted_url as l_formatted_url then
				Result.append ("Formatted url:")
				Result.append (l_formatted_url)
				Result.append_character ('%N')
			end
			if attached html_formatted_url as l_html_formatted_url then
				Result.append ("Html formatted url:")
				Result.append (l_html_formatted_url)
				Result.append_character ('%N')
			end

		end

note
	copyright: "2011-2015 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
