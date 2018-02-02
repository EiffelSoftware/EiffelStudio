note
	description: "[
		Represent google custom search parameters
		Example url template
		  "template": "https://www.googleapis.com/customsearch/v1?q={searchTerms}&num={count?}&start={startIndex?}&lr={language?}&safe={safe?}&cx={cx?}&cref={cref?}&sort={sort?}&filter={filter?}&gl={gl?}&cr={cr?}&googlehost={googleHost?}&c2coff={disableCnTwTranslation?}&hq={hq?}&hl={hl?}&siteSearch={siteSearch?}&siteSearchFilter={siteSearchFilter?}&exactTerms={exactTerms?}&excludeTerms={excludeTerms?}&linkSite={linkSite?}&orTerms={orTerms?}&relatedSite={relatedSite?}&dateRestrict={dateRestrict?}&lowRange={lowRange?}&highRange={highRange?}&searchType={searchType}&fileType={fileType?}&rights={rights?}&imgSize={imgSize?}&imgType={imgType?}&imgColorType={imgColorType?}&imgDominantColor={imgDominantColor?}&alt=json"
	]"
	optional_parameters: "[
			Optional parameters
			c2coff	string	Enables or disables Simplified and Traditional Chinese Search.
					The default value for this parameter is 0 (zero), meaning that the feature is enabled. Supported values are:
					1: Disabled
					0: Enabled (default)
			cr	string	Restricts search results to documents originating in a particular country.
					You may use Boolean operators in the cr parameter's value.
					Google Search determines the country of a document by analyzing:
					the top-level domain (TLD) of the document's URL
					the geographic location of the Web server's IP address
					See the Country Parameter Values page for a list of valid values for this parameter.
			cref	string	The URL of a linked custom search engine specification to use for this request.
					Does not apply for Google Site Search
					If both cx and cref are specified, the cx value is used
			cx	string	The custom search engine ID to use for this request.
					If both cx and cref are specified, the cx value is used.
			dateRestrict	string	Restricts results to URLs based on date. Supported values include:
					d[number]: requests results from the specified number of past days.
					w[number]: requests results from the specified number of past weeks.
					m[number]: requests results from the specified number of past months.
					y[number]: requests results from the specified number of past years.
			exactTerms	string	Identifies a phrase that all documents in the search results must contain.
			excludeTerms	string	Identifies a word or phrase that should not appear in any documents in the search results.
			fileType	string	Restricts results to files of a specified extension. A list of file types indexable by Google can be found in Webmaster Tools Help Center.
			filter	string	Controls turning on or off the duplicate content filter.
					See Automatic Filtering for more information about Google's search results filters. Note that host crowding filtering applies only to multi-site searches.
					By default, Google applies filtering to all search results to improve the quality of those results.


					Acceptable values are:
					"0": Turns off duplicate content filter.
					"1": Turns on duplicate content filter.
					gl	string	Geolocation of end user.
			The gl parameter value is a two-letter country code. The gl parameter boosts search results whose country of origin matches the parameter value. See the Country Codes page for a list of valid values.
			Specifying a gl parameter value should lead to more relevant results. This is particularly true for international customers and, even more specifically, for customers in English- speaking countries other than the United States.
			googlehost	string	The local Google domain (for example, google.com, google.de, or google.fr) to use to perform the search.
			highRange	string
			Specifies the ending value for a search range.
			Use lowRange and highRange to append an inclusive search range of lowRange...highRange  to the query.
			hl	string	Sets the user interface language.
			Explicitly setting this parameter improves the performance and the quality of your search results.
			See the Interface Languages section of Internationalizing Queries and Results Presentation for more information, and Supported Interface Languages for a list of supported languages.
			hq	string	Appends the specified query terms to the query, as if they were combined with a logical AND operator.
			imgColorType	string	Returns black and white, grayscale, or color images: mono, gray, and color.

					Acceptable values are:
					"color": color
					"gray": gray
					"mono": mono
			imgDominantColor	string	Returns images of a specific dominant color.

					Acceptable values are:
					"black": black
					"blue": blue
					"brown": brown
					"gray": gray
					"green": green
					"pink": pink
					"purple": purple
					"teal": teal
					"white": white
					"yellow": yellow
			imgSize	string	Returns images of a specified size.

					Acceptable values are:
					"huge": huge
					"icon": icon
					"large": large
					"medium": medium
					"small": small
					"xlarge": xlarge
					"xxlarge": xxlarge
			imgType	string	Returns images of a type.

					Acceptable values are:
					"clipart": clipart
					"face": face
					"lineart": lineart
					"news": news
					"photo": photo
			linkSite	string	Specifies that all search results should contain a link to a particular URL
			lowRange	string	Specifies the starting value for a search range.
			Use lowRange and highRange to append an inclusive search range of lowRange...highRange to the query.
			lr	string	Restricts the search to documents written in a particular language (e.g., lr=lang_ja).

					Acceptable values are:
					"lang_ar": Arabic
					"lang_bg": Bulgarian
					"lang_ca": Catalan
					"lang_cs": Czech
					"lang_da": Danish
					"lang_de": German
					"lang_el": Greek
					"lang_en": English
					"lang_es": Spanish
					"lang_et": Estonian
					"lang_fi": Finnish
					"lang_fr": French
					"lang_hr": Croatian
					"lang_hu": Hungarian
					"lang_id": Indonesian
					"lang_is": Icelandic
					"lang_it": Italian
					"lang_iw": Hebrew
					"lang_ja": Japanese
					"lang_ko": Korean
					"lang_lt": Lithuanian
					"lang_lv": Latvian
					"lang_nl": Dutch
					"lang_no": Norwegian
					"lang_pl": Polish
					"lang_pt": Portuguese
					"lang_ro": Romanian
					"lang_ru": Russian
					"lang_sk": Slovak
					"lang_sl": Slovenian
					"lang_sr": Serbian
					"lang_sv": Swedish
					"lang_tr": Turkish
					"lang_zh-CN": Chinese (Simplified)
					"lang_zh-TW": Chinese (Traditional)

			orTerms	string	Provides additional search terms to check for in a document, where each document in the search results must contain at least one of the additional search terms.
			relatedSite	string	Specifies that all search results should be pages that are related to the specified URL.
			rights	string	Filters based on licensing. Supported values include: cc_publicdomain, cc_attribute, cc_sharealike, cc_noncommercial, cc_nonderived, and combinations of these.
			safe	string	Search safety level.

					Acceptable values are:
					"high": Enables highest level of SafeSearch filtering.
					"medium": Enables moderate SafeSearch filtering.
					"off": Disables SafeSearch filtering. (default)
			searchType	string	Specifies the search type: image.  If unspecified, results are limited to webpages.

			Acceptable values are:
					"image": custom image search.
			siteSearch	string	Specifies all search results should be pages from a given site.
			siteSearchFilter	string	Controls whether to include or exclude results from the site named in the siteSearch parameter.

					Acceptable values are:
					"e": exclude
					"i": include
					sort	string	The sort expression to apply to the results.
]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "GCSE parameters", "src=https://developers.google.com/custom-search/json-api/v1/reference/cse/list", "protocol=URI"

class
	GCSE_QUERY_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (a_secret_key,  a_cx, a_query: READABLE_STRING_8)
			-- Create an object GCSE_QUERY_PARAMETERS with secret key `a_secret_key' and a custom search engine id `a_cx'.
			-- and query `a_query'.
		do
				-- TODO
				-- At the moment the API only use cx as Google Custom Search id.
				-- Custom search engine ID - Use either cx or cref to specify the custom search engine you want to use to perform this search

			secret := a_secret_key
			cx := a_cx
			query := a_query
		ensure
			secret_set: secret.same_string (a_secret_key)
			cx_set: cx.same_string (a_cx)
			query_set: query.same_string (a_query)
		end

feature -- Access : Required Parameters

	secret: READABLE_STRING_8
			-- Required. The shared key between your site and Google Custom Search Engine.

	cx: READABLE_STRING_8
			-- Custom search engine id to perform this search.

	query: READABLE_STRING_8
			-- Search query, query parameter to specify your search expression.

feature -- Optional Parameters



	num	: INTEGER
			-- Number of search results to return.
			-- Valid values are integers between 1 and 10, inclusive.

	start: INTEGER
			--	The index of the first result to return.

feature -- Change Elements

	set_num (a_num: INTEGER)
		require
			valid_range: a_num >= 1 and then a_num <= 10
		do
			num := a_num
		ensure
			num_set: num = a_num
			valid_rage_set: num >= 1 and num <= 10
		end


	set_start (a_start: INTEGER)
		require
			valid_start: a_start >= 1
		do
			start := a_start
		ensure
			start_set: start = a_start
			valid_start_set: start >= 1
		end

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
