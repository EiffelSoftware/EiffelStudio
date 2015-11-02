note
	description: "Represent metadata describing the query for the current set of results."
	date: "$Date$"
	revision: "$Revision$"

class
	GCSE_PAGE

inherit

	DEBUG_OUTPUT

feature -- Access

	search_terms: detachable STRING_8
			-- search term

	title: detachable STRING_8
			-- Search title.

	total_results: INTEGER
			-- Search total results.

	count: INTEGER
			-- Rows per page.

	start_index: INTEGER
			-- Page index.

feature -- Element change

	set_search_terms (a_search_terms: like search_terms)
			-- Assign `search_terms' with `a_search_terms'.
		do
			search_terms := a_search_terms
		ensure
			search_terms_assigned: search_terms = a_search_terms
		end

feature -- Change element

	set_title (a_title: like title)
			-- Set title with `a_title'
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_total_results (a_total_results: like total_results)
			-- Set total_results with `a_total_results'.
		do
			total_results := a_total_results
		ensure
			total_results_set: total_results = a_total_results
		end

	set_count (a_count: like count)
			-- Set count with `a_count'.
		do
			count := a_count
		ensure
			count_set: count = a_count
		end

	set_start_index (a_start_index: like start_index)
			-- Set start_index with `a_start_index'.
		do
			start_index := a_start_index
		ensure
			start_index_set: start_index = a_start_index
		end

feature -- Status report

		debug_output: STRING_8
				-- <Precursor>
			do
				create Result.make_from_string ("%NPage details%N")
				if attached title as l_title then
					Result.append ("Title:")
					Result.append (l_title)
					Result.append_character ('%N')
				end
				if attached search_terms as l_search_tearm then
					Result.append ("Search Tearm:")
					Result.append (l_search_tearm)
					Result.append_character ('%N')
				end

				Result.append ("Count:")
				Result.append (count.out)
				Result.append_character ('%N')
				Result.append ("Total Result:")
				Result.append (count.out)
				Result.append_character ('%N')
				Result.append ("Count:")
				Result.append (total_results.out)
				Result.append_character ('%N')
				Result.append ("Start index:")
				Result.append (start_index.out)
				Result.append_character ('%N')

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
