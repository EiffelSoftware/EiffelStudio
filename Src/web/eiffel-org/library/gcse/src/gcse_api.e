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
			query_paremeter := a_query_parameters
		ensure
			query_parameters_set: query_paremeter = a_query_parameters
		end

feature -- Access

	base_uri: STRING_8 = "https://www.googleapis.com/customsearch/v1"
			-- Google custom search base URI

	query_paremeter: GCSE_QUERY_PARAMETERS
			-- Google custom search parameters.

	last_result: detachable GCSE_RESPONSE

feature -- Status Reports

	errors: detachable LIST [READABLE_STRING_8]
			-- optional table of error codes


feature -- API

	search
		local
			l_parser: JSON_PARSER
			l_gcse_response: detachable GCSE_RESPONSE
		do
				-- Data format for the response.
				-- At the moment we are using the default value: json
				-- but it's possible to define atom response using the alt parameter.
			last_result := Void
			if attached get as l_response then
				if attached l_response.body as l_body then
					create l_parser.make_with_string (l_body)
					l_parser.parse_content
					if l_parser.is_parsed and then attached {JSON_OBJECT} l_parser.parsed_json_object as jv then
							-- Queries
						create l_gcse_response
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
			-- Reading Data
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
			-- full teamplte BaseUri?q={searchTerms}&num={count?}&start={startIndex?}&lr={language?}&
			-- safe={safe?}&cx={cx?}&cref={cref?}&sort={sort?}&filter={filter?}&gl={gl?}&cr={cr?}&
			-- googlehost={googleHost?}&c2coff={disableCnTwTranslation?}&hq={hq?}&hl={hl?}&siteSearch={siteSearch?}&
			-- siteSearchFilter={siteSearchFilter?}&exactTerms={exactTerms?}&excludeTerms={excludeTerms?}&linkSite={linkSite?}&
			-- orTerms={orTerms?}&relatedSite={relatedSite?}&dateRestrict={dateRestrict?}&lowRange={lowRange?}&highRange={highRange?}&
			-- searchType={searchType}&fileType={fileType?}&rights={rights?}&imgSize={imgSize?}&imgType={imgType?}&
			-- imgColorType={imgColorType?}&imgDominantColor={imgDominantColor?}&alt=json"

		do
			create Result.make_from_string (base_uri)
			Result.append ("?key=")
			Result.append (query_paremeter.secret)
			Result.append ("&cx=")
			Result.append (query_paremeter.cx)
			Result.append ("&q=")
			Result.append (query_paremeter.query)
				-- num
			if attached query_paremeter.num as l_num then
				Result.append ("&num=")
				Result.append (l_num)
			end
			if attached query_paremeter.start as l_start then
				Result.append ("&start=")
				Result.append (l_start)
			end
		end

	put_error (a_code: READABLE_STRING_GENERAL)
		local
			l_errors: like errors
			utf: UTF_CONVERTER
		do
			l_errors := errors
			if l_errors = Void then
				create {ARRAYED_LIST [STRING]} l_errors.make (1)
				errors := l_errors
			end
			l_errors.force (utf.utf_32_string_to_utf_8_string_8 (a_code))
		end

	item (a_item: JSON_OBJECT): GCSE_PAGE_ITEM
		do
			create Result
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("kind")) as l_kind then
				Result.set_kind (l_kind.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("title")) as l_title then
				Result.set_title (l_title.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("htmlTitle")) as l_htmltitle then
				Result.set_html_title (l_htmltitle.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("link")) as l_link then
				Result.set_link (l_link.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("displayLink")) as l_display_link then
				Result.set_display_link (l_display_link.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("snippet")) as l_snippet then
				Result.set_snippet (l_snippet.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("htmlSnippet")) as l_html_snippet then
				Result.set_html_snippet (l_html_snippet.item)
			end
			if attached {JSON_STRING} a_item.item (create {JSON_STRING}.make_from_string ("formattedUrl")) as l_formatted_url then
				Result.set_formatted_url (l_formatted_url.item)
			end
		end

	query_page (a_page_key: JSON_STRING; a_queries: JSON_OBJECT): detachable GCSE_PAGE
			-- Return a query page based for a query with page key `a_page_key', if any.
		do
			if attached {JSON_ARRAY} a_queries.item (a_page_key) as jquerypage and then attached {JSON_OBJECT} jquerypage.i_th (1) as jpage then
				create Result
				if attached {JSON_STRING} jpage.item (create {JSON_STRING}.make_from_string ("title")) as l_title then
					Result.set_title (l_title.item)
				end
				if attached {JSON_STRING} jpage.item (create {JSON_STRING}.make_from_string ("totalResults")) as l_results then
					Result.set_total_results (l_results.item.to_integer)
				end
				if attached {JSON_STRING} jpage.item (create {JSON_STRING}.make_from_string ("searchTerms")) as l_search_terms then
					Result.set_search_terms (l_search_terms.item)
				end
					-- TODO check if we should use INTEGER_64
				if attached {JSON_NUMBER} jpage.item (create {JSON_STRING}.make_from_string ("count")) as l_count then
					Result.set_count (l_count.integer_64_item.as_integer_32)
				end
				if attached {JSON_NUMBER} jpage.item (create {JSON_STRING}.make_from_string ("startIndex")) as l_index then
					Result.set_start_index (l_index.integer_64_item.as_integer_32)
				end
			end
		end

feature {NONE} -- JSON Keys

	queries_key: JSON_STRING
		do
			create Result.make_from_string ("queries")
		end

	next_page_key: JSON_STRING
		do
			create Result.make_from_string ("nextPage")
		end

	request_key: JSON_STRING
		do
			create Result.make_from_string ("request")
		end

	previous_page_key: JSON_STRING
		do
			create Result.make_from_string ("previousPage")
		end

	items_key: JSON_STRING
		do
			create Result.make_from_string ("items")
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
