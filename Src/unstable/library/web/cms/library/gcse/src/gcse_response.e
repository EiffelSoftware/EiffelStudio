note
	description: "[
		Represent search request metadata
		URL: search template used for the current results.
		Queries: current, next and previous page.
		Context
		Search infromation
		Items: array of actual search results.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	GCSE_RESPONSE

	--! TODO
	--! All suppport for for url, context and search information.

feature -- Access

	current_page: detachable GCSE_PAGE
		-- Metadata describing the query for the current set of results.
		--		This role is always present in the response.	
		--		It is always an array with just one element.

	next_page: detachable GCSE_PAGE
		-- Metadata describing the query to use for the next page of results.
		-- 		This role is not present if the current results are the last page. Note: This API returns up to the first 100 results only.
		--		When present, it is always a array with just one element.

	previous_page: detachable GCSE_PAGE
		-- Metadata describing the query to use for the previous page of results.
		--		Not present if the current results are the first page.
		--		When present, it is always a array with just one element.

	items: detachable LIST [GCSE_PAGE_ITEM]
			-- Contains the actual search results. The search results include the URL, title and text snippets that describe the result.

feature -- Change Element

	set_current_page (a_page: GCSE_PAGE)
			-- Set `current_page' with `a_page'.
		do
			current_page := a_page
		ensure
			current_page_set: current_page = a_page
		end

	set_next_page (a_page: GCSE_PAGE)
			-- Set `next_page' with `a_page'.
		do
			next_page := a_page
		ensure
			next_page_set: next_page = a_page
		end

	set_previous_page (a_page: GCSE_PAGE)
			-- Set `previous_page' with `a_page'.
		do
			previous_page := a_page
		ensure
			previous_page_set: previous_page = a_page
		end

	add_item (a_item: GCSE_PAGE_ITEM)
			-- Add item `a_item' to the list of items.
		local
			l_items: like items
		do
			l_items := items
			if l_items = Void then
				create {ARRAYED_LIST[GCSE_PAGE_ITEM]}l_items.make (10)
				items := l_items
			end
			l_items.force (a_item)
		end


feature -- Acess: HTTP Response

	status: INTEGER
		-- HTTP status code.

	status_message: detachable READABLE_STRING_8
		--  associated textual phrase for the response status.

feature -- Change Element: HTTP Response

	set_status (a_status: like status)
			-- Set `status' with `a_status'.
		do
			status := a_status
		ensure
			status_set: status = a_status
		end

	set_status_nessage (a_message: like status_message)
			-- Set `status_message' with `a_message'.
		do
			status_message := a_message
		ensure
			status_message_set: status_message = a_message
		end

;note
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
