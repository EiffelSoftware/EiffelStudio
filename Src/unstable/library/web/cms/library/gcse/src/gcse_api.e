note
	description: "[
		Simple API to call Google Custome Search Engine
		Example call:
		GET https://www.googleapis.com/customsearch/v1?key=INSERT_YOUR_API_KEY&cx=017576662512468239146:omuauf_lfve&q=lectures
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Google Custom Search Engine", "src=https://developers.google.com/custom-search/json-api/v1/using_rest", "protocol=uri"

class
	GCSE_API

create
	make

feature {NONE} -- Initialization

	make (a_query_parameters: GCSE_QUERY_PARAMETERS)
			-- Create an object GCSE with query_parameters `a_query_parameters'
		do
			query_parameter := a_query_parameters
		ensure
			query_parameters_set: query_parameter = a_query_parameters
		end

feature -- Access

	base_uri: STRING_8 = "https://www.googleapis.com/customsearch/v1"
			-- Google custom search base URI.

	query_parameter: GCSE_QUERY_PARAMETERS
			-- Google custom search parameters.

	last_result: detachable GCSE_RESPONSE
			-- Search results.

feature -- Status Reports

	errors: detachable LIST [READABLE_STRING_8]
			-- optional list of error messages.

feature -- API

	search
			-- Search
		local
			l_parser: JSON_PARSER
			l_gcse_response: detachable GCSE_RESPONSE
		do
				-- Data format for the response.
				-- At the moment we are using the default value: json
				-- but it's possible to define atom response using the alt parameter.
			last_result := Void
			if attached get as l_response then
				create l_gcse_response
				l_gcse_response.set_status (l_response.status)
				l_gcse_response.set_status_nessage (l_response.status_message)

				if attached l_response.body as l_body then
					create l_parser.make_with_string (l_body)
					l_parser.parse_content
					if l_response.status = 200 and then l_parser.is_parsed and then attached {JSON_OBJECT} l_parser.parsed_json_object as jv then
							-- Queries
						if attached {JSON_OBJECT} jv.item (queries_key) as jqueries then
								-- Next Page
							if attached {GCSE_PAGE} query_page (next_page_key, jqueries) as l_page then
								l_gcse_response.set_next_page (l_page)
							end
								-- Current Page
							if attached {GCSE_PAGE} query_page (request_key, jqueries) as l_page then
								l_gcse_response.set_current_page (l_page)
							end
								-- Previous Page
							if attached {GCSE_PAGE} query_page (previous_page_key, jqueries) as l_page then
								l_gcse_response.set_previous_page (l_page)
							end
						end
						if attached {JSON_ARRAY} jv.item (items_key) as jitems then
							across jitems as ic loop
								if attached{JSON_OBJECT} ic.item as j_item  then
									l_gcse_response.add_item (item (j_item))
								end
							end
						end
					else
						put_error (l_body)
					end
				else
					put_error (l_response.status.out)
				end
			else
				put_error ("unknown")
			end
			last_result := l_gcse_response
		end

feature {NONE} -- REST API

	get: detachable RESPONSE
			-- Reading Data.
		local
			l_request: REQUEST
		do
			create l_request.make ("GET", new_uri)
			Result := l_request.execute
		end

feature {NONE} -- Implementation

	new_uri: STRING_8
			-- new uri (BaseUri?key=secret_value&cx=a_cx_id&q=a_query
			-- ?key=INSERT_YOUR_API_KEY&cx=017576662512468239146:omuauf_lfve&q=lectures
			-- full template BaseUri?q={searchTerms}&num={count?}&start={startIndex?}&lr={language?}&
			-- safe={safe?}&cx={cx?}&cref={cref?}&sort={sort?}&filter={filter?}&gl={gl?}&cr={cr?}&
			-- googlehost={googleHost?}&c2coff={disableCnTwTranslation?}&hq={hq?}&hl={hl?}&siteSearch={siteSearch?}&
			-- siteSearchFilter={siteSearchFilter?}&exactTerms={exactTerms?}&excludeTerms={excludeTerms?}&linkSite={linkSite?}&
			-- orTerms={orTerms?}&relatedSite={relatedSite?}&dateRestrict={dateRestrict?}&lowRange={lowRange?}&highRange={highRange?}&
			-- searchType={searchType}&fileType={fileType?}&rights={rights?}&imgSize={imgSize?}&imgType={imgType?}&
			-- imgColorType={imgColorType?}&imgDominantColor={imgDominantColor?}&alt=json"

		do
			create Result.make_from_string (base_uri)
			Result.append ("?key=")
			Result.append (query_parameter.secret)
			Result.append ("&cx=")
			Result.append (query_parameter.cx)
			Result.append ("&q=")
			Result.append (query_parameter.query)
				-- num
			if attached query_parameter.num as l_num then
				Result.append ("&num=")
				Result.append_integer (l_num)
			end
			if attached query_parameter.start as l_start then
				Result.append ("&start=")
				Result.append_integer (l_start)
			end
		end

	put_error (a_message: READABLE_STRING_GENERAL)
			-- put error message `a_message'.
		local
			l_errors: like errors
			utf: UTF_CONVERTER
		do
			l_errors := errors
			if l_errors = Void then
				create {ARRAYED_LIST [STRING]} l_errors.make (1)
				errors := l_errors
			end
			l_errors.force (utf.utf_32_string_to_utf_8_string_8 (a_message))
		end

	item (a_item: JSON_OBJECT): GCSE_PAGE_ITEM
			-- Google Result Metadata Item.
		do
			create Result
			if attached {JSON_STRING} a_item.item ("kind") as l_kind then
				Result.set_kind (l_kind.item)
			end
			if attached {JSON_STRING} a_item.item ("title") as l_title then
				Result.set_title (l_title.item)
			end
			if attached {JSON_STRING} a_item.item ("htmlTitle") as l_htmltitle then
				Result.set_html_title (l_htmltitle.unescaped_string_32)
			end
			if attached {JSON_STRING} a_item.item ("link") as l_link then
				Result.set_link (l_link.item)
			end
			if attached {JSON_STRING} a_item.item ("displayLink") as l_display_link then
				Result.set_display_link (l_display_link.item)
			end
			if attached {JSON_STRING} a_item.item ("snippet") as l_snippet then
				Result.set_snippet (l_snippet.unescaped_string_8)
			end
			if attached {JSON_STRING} a_item.item ("htmlSnippet") as l_html_snippet then
				Result.set_html_snippet (l_html_snippet.unescaped_string_32)
			end
			if attached {JSON_STRING} a_item.item ("formattedUrl") as l_formatted_url then
				Result.set_formatted_url (l_formatted_url.item)
			end
		end

	query_page (a_page_key: JSON_STRING; a_queries: JSON_OBJECT): detachable GCSE_PAGE
			-- Google result medata query. Return a query page based for a query with page key `a_page_key', if any.
		do
			if
				attached {JSON_ARRAY} a_queries.item (a_page_key) as jquerypage and then
				jquerypage.count > 0 and then
				attached {JSON_OBJECT} jquerypage.i_th (1) as jpage
			then
				create Result
				if attached {JSON_STRING} jpage.item ("title") as l_title then
					Result.set_title (l_title.item)
				end
				if attached {JSON_STRING} jpage.item ("totalResults") as l_results then
					Result.set_total_results (l_results.item.to_integer)
				end
				if attached {JSON_STRING} jpage.item ("searchTerms") as l_search_terms then
					Result.set_search_terms (l_search_terms.item)
				end
					-- TODO check if we should use INTEGER_64
				if attached {JSON_NUMBER} jpage.item ("count") as l_count then
					Result.set_count (l_count.integer_64_item.as_integer_32)
				end
				if attached {JSON_NUMBER} jpage.item ("startIndex") as l_index then
					Result.set_start_index (l_index.integer_64_item.as_integer_32)
				end
			end
		end

feature {NONE} -- JSON Keys

	queries_key: STRING = "queries"

	next_page_key: STRING = "nextPage"

	request_key: STRING = "request"

	previous_page_key: STRING = "previousPage"

	items_key: STRING = "items"

note
	copyright: "2011-2018 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
