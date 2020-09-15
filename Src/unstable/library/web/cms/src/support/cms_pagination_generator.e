note
	description: "Pagination class to generate html pagination links and header summary."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGINATION_GENERATOR

create
	make

feature {NONE} -- Initialization

	make (a_resource: READABLE_STRING_8; a_count: NATURAL_64; a_page_size: NATURAL)
			-- Create an object with a pages of size `a_page_size'.
			-- If `a_page_size' is zero, use default pagination size.
		require
			a_page_size > 0
		do
			create resource.make (a_resource)
			set_page_size (a_page_size)
			set_upper (a_count)
			set_current_page_index (1)

			maximum_ith_page_links := 7
			page_parameter_id := "page"
			size_parameter_id := "size"
			set_first_text_id ("<<")
			set_prev_text_id ("<")
			set_next_text_id (">")
			set_last_text_id (">>")
		end

feature -- Access

	resource: URI_TEMPLATE
			-- Resource associated with current pager.

	page_size: NATURAL
			-- Number of items per page.

	upper: NATURAL_64
			-- number of items.
			-- if zero, no upper limit.

	current_page_index: INTEGER
			-- Current page index.

	current_page_offset: NATURAL_64
			-- Lower index - 1 for current page.
		do
			if current_page_index > 1 then
				Result := (current_page_index - 1).to_natural_32 * page_size
			else
				Result := 0
			end
		end

feature -- Status report			

	has_upper_limit: BOOLEAN
			-- Upper limit known?
		do
			Result := upper > 0
		end

	pages_count: INTEGER
			-- Number of pages.
			-- If upper is
		require
			has_upper_limit: has_upper_limit
		do
			Result := (upper // page_size.as_natural_64).to_integer_32
			if upper \\ page_size.to_natural_64 > 0 then
				Result := Result + 1
			end
		end

feature -- Parameters			

	page_parameter_id: READABLE_STRING_8
			-- Parameter id for page value.

	size_parameter_id: READABLE_STRING_8
			-- Parameter id for size value.

	maximum_ith_page_links: INTEGER
			-- Maximum number of numeric ith page link.
			-- ex: max = 6 gives "1 2 3 4 5 6 ... > >>".

	label_first: IMMUTABLE_STRING_32
	label_previous: IMMUTABLE_STRING_32
	label_next: IMMUTABLE_STRING_32
	label_last: IMMUTABLE_STRING_32

feature -- Element change

	set_page_size (a_size: NATURAL)
			-- Set `page_size' to `a_size'.
		do
			page_size := a_size
		end

	set_upper (a_upper: NATURAL_64)
			-- Set pages count, or upper limit `upper' to `a_size'.
		do
			upper := a_upper
		end

	set_current_page_index (a_page_index: like current_page_index)
			-- Set Current page index to `a_page_index'.
		do
			current_page_index := a_page_index
		end

	set_page_parameter_id (a_id: READABLE_STRING_8)
			-- Set "page" query parameter to `a_id'.
		do
			page_parameter_id := a_id
		end

	set_size_parameter_id (a_id: READABLE_STRING_8)
			-- Set "size" query parameter to `a_id'.
		do
			size_parameter_id := a_id
		end

	get_setting_from_request (req: WSF_REQUEST)
			-- Get various pager related settings from request `req' query paramenters.
			-- Using `page_parameter_id' and `size_parameter_id' value for parameter names.
		do
				-- Size
			if
				attached {WSF_STRING} req.query_parameter (size_parameter_id) as l_size and then
				attached l_size.value as l_value and then
				l_value.is_natural
			then
				set_page_size (l_value.to_natural_32)
			else
					-- Keep default size
			end

				-- Page
			if
				attached {WSF_STRING} req.query_parameter (page_parameter_id) as l_page and then
				l_page.is_integer
			then
				set_current_page_index (l_page.integer_value)
			else
				set_current_page_index (1)
			end
		end

	set_first_text_id (s: READABLE_STRING_GENERAL)
			-- Set label for "First" link to `s'.
			-- default: "<<"
		do
			create label_first.make_from_string_general (s)
		end

	set_prev_text_id (s: READABLE_STRING_GENERAL)
			-- Set label for "Prev" link to `s'.
			-- default: "<"
		do
			create label_previous.make_from_string_general (s)
		end

	set_next_text_id (s: READABLE_STRING_GENERAL)
			-- Set label for "Next" link to `s'.
			-- default: ">"
		do
			create label_next.make_from_string_general (s)
		end

	set_last_text_id (s: READABLE_STRING_GENERAL)
			-- Set label for "Last" link to `s'.
			-- default: ">>"
		do
			create label_last.make_from_string_general (s)
		end

	set_maximum_ith_page_links (nb: INTEGER)
			-- Set `maximum_ith_page_links' to `nb'.
		do
			maximum_ith_page_links := nb
		end

feature -- Conversion

	pagination_links: ARRAYED_LIST [CMS_LOCAL_LINK]
			-- CMS local links related to Current paginations.
		local
			lnk: CMS_LOCAL_LINK
			tb: HASH_TABLE [detachable ANY, STRING_8]
			curr, max: INTEGER
			i,j: INTEGER
		do
			create Result.make (maximum_ith_page_links)

			curr := current_page_index
			if has_upper_limit then
				max := pages_count
			else
				max := curr + page_size.to_integer_32
			end

			create tb.make (2)
			tb.force (page_size, size_parameter_id.to_string_8)
			tb.force (1, page_parameter_id.to_string_8)
			if curr > 1 then
				create lnk.make (label_first, resource.expanded_string (tb))
				Result.force (lnk)
			end

			if curr > 1 then
				tb.force (curr - 1, "page")
				create lnk.make (label_previous, resource.expanded_string (tb))
				Result.force (lnk)
			end
			from
				if curr >= maximum_ith_page_links // 2 then
					i := curr - (maximum_ith_page_links // 2)
				else
					i := 1
				end
				j := 0
			until
				j >= maximum_ith_page_links or (has_upper_limit and then i > max)
			loop
				tb.force (i, "page")
				create lnk.make (i.out, resource.expanded_string (tb))
				lnk.set_is_active (i = curr)
				Result.force (lnk)
				j := j + 1
				i := i + 1
			end
			if not has_upper_limit or else i < max then
				tb.force (i, "page")
				create lnk.make ("...", resource.expanded_string (tb))
				Result.force (lnk)
			end

			if curr < max then
				tb.force (curr + 1, "page")
				create lnk.make (label_next, resource.expanded_string (tb))
				Result.force (lnk)
			end

			if upper > 0 and curr /= max then
				tb.force (max, "page")
				create lnk.make (label_last, resource.expanded_string (tb))
				Result.force (lnk)
			end
		end

feature -- Convertion

	append_to_html (a_response: CMS_RESPONSE; a_output: STRING)
			-- Append html pager to `a_output' in the context of `a_response'.
			-- note: First, [Prev], [Next], Last.
		local
			lnk: CMS_LOCAL_LINK
		do
			a_output.append ("<ul class=%"pagination%">%N")
			across
				pagination_links as ic
			loop
				lnk := ic.item
				if not lnk.is_forbidden then
					if lnk.is_active then
						a_output.append ("<li class=%"active%">")
					elseif lnk.title.same_string (label_previous) then
						a_output.append ("<li class=%"previous%">")
					elseif lnk.title.same_string (label_next) then
						a_output.append ("<li class=%"next%">")
					else
						a_output.append ("<li>")
					end
					a_response.append_cms_link_to_html (lnk, Void, a_output)
					a_output.append ("</li>")
				end
			end
			a_output.append ("</ul>")
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
