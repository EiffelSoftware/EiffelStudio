note
	description: "[
			The class represents a HTTP header, and it provides simple routine
			to build it.
			
			You will also find some helper features to help coding most common usages
			
			Please, have a look at constants classes such as
				HTTP_MIME_TYPES
				HTTP_HEADER_NAMES
				HTTP_STATUS_CODE
				HTTP_REQUEST_METHODS
			(or HTTP_CONSTANTS which groups them for convenience)
			
			Note the return status code is not part of the HTTP header
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_HEADER

inherit
	ITERABLE [READABLE_STRING_8]

	HTTP_HEADER_MODIFIER

create
	make,
	make_with_count,
	make_from_array,
	make_from_header,
	make_from_raw_header_data

convert
	make_from_array ({ARRAY [TUPLE [key: READABLE_STRING_8; value: READABLE_STRING_8]]}),
	string: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization

	make
			-- Initialize current
		do
			make_with_count (3)
		end

	make_with_count (n: INTEGER)
			-- Make with a capacity of `n' header entries
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} headers.make (n)
		end

	make_from_array (a_headers: ARRAY [TUPLE [key: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Create HEADER from array of pair (key,value)
		do
			if a_headers.is_empty then
				make_with_count (0)
			else
				make_with_count (a_headers.count)
				append_array (a_headers)
			end
		end

	make_from_header (a_header: HTTP_HEADER)
			-- Create Current from existing HEADER `a_header'
		do
			make_with_count (a_header.headers.count)
			append_header_object (a_header)
		end

	make_from_raw_header_data (h: READABLE_STRING_8)
			-- Create Current from raw header data
        do
			make
			append_raw_header_data (h)
		end

feature -- Recycle

	recycle
			-- Recycle current object
		do
			headers.wipe_out
		end

feature -- Access

	count: INTEGER
			-- Number of header items.
		do
			Result := headers.count
		end

	is_empty: BOOLEAN
			-- Is empty?
		do
			Result := count = 0
		end

	headers: ARRAYED_LIST [READABLE_STRING_8]
			-- Header's lines.

	string: STRING_8
			-- String representation of the header entries.
		local
			n: like count
		do
			n := count
			if n = 0 then
				create Result.make_empty
			else
				create Result.make (n * 32)
				append_string_to (Result)
			end
		ensure
			result_has_ending_cr_lf: Result.count >= 2 implies Result.substring (Result.count - 1, Result.count).same_string ("%R%N")
			result_has_single_ending_cr_lf: Result.count >= 4 implies not Result.substring (Result.count - 3, Result.count).same_string ("%R%N%R%N")
		end

feature -- Conversion

	to_name_value_iterable: ITERABLE [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]
			-- Iterable representation of the header entries.
		local
			res: ARRAYED_LIST [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]
		do
			create res.make (headers.count)
			across
				headers as c
			loop
				if attached header_name_value (c.item) as tu then
					res.extend (tu)
				end
			end
			Result := res
		end

feature --

	append_string_to (a_result: STRING_8)
			-- Append current as string representation to `a_result'
		local
			l_headers: like headers
		do
			l_headers := headers
			if not l_headers.is_empty then
				across
					l_headers as c
				loop
					append_line_to (c.item, a_result)
				end
			end
		end

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [READABLE_STRING_8]
			-- Fresh cursor associated with current structure.
		do
			Result := headers.new_cursor
		end

feature -- Header: adding

	append_raw_header_data (h: READABLE_STRING_8)
			-- Append raw header data `h' to Current
        local
        	line : detachable STRING
			lines: LIST [READABLE_STRING_8]
        do
            lines := h.split ('%N')
			headers.grow (headers.count + lines.count)
            across
            	lines as c
            loop
            	line := c.item
            	if not line.is_empty then
            		if line [line.count] = '%R' then
						line.remove_tail (1)
            		end
					if not line.is_empty then
						add_header (line)
					end
            	end
			end
		end

	append_array (a_headers: ARRAY [TUPLE [key: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Append array of key,value headers
		do
			headers.grow (headers.count + a_headers.count)
			across
				a_headers as c
			loop
				add_header_key_value (c.item.key, c.item.value)
			end
		end

	append_header_object (h: HTTP_HEADER)
			-- Append headers from `h'
		do
			headers.grow (headers.count + h.headers.count)
			across
				h.headers as c
			loop
				add_header (c.item.string)
			end
		end

feature -- Header: merging

	put_raw_header_data (h: READABLE_STRING_8)
			-- Append raw header data `h' to Current
			-- Overwrite existing header with same name
        local
        	line : detachable STRING
			lines: LIST [READABLE_STRING_8]
        do
            lines := h.split ('%N')
			headers.grow (headers.count + lines.count)
            across
            	lines as c
            loop
            	line := c.item
            	if not line.is_empty then
            		if line [line.count] = '%R' then
						line.remove_tail (1)
            		end
					put_header (line)
            	end
			end
		end

	put_array (a_headers: ARRAY [TUPLE [key: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Append array of key,value headers
			-- Overwrite existing header with same name
		do
			headers.grow (headers.count + a_headers.count)
			across
				a_headers as c
			loop
				put_header_key_value (c.item.key, c.item.value)
			end
		end

	put_header_object (h: HTTP_HEADER)
			-- Append headers from `h'
			-- Overwrite existing header with same name
		do
			headers.grow (headers.count + h.headers.count)
			across
				h.headers as c
			loop
				put_header (c.item.string)
			end
		end

feature -- Removal

	remove_header_named (a_name: READABLE_STRING_8)
			-- Remove any header line related to name `a_name'.
		local
			lst: like headers
		do
			from
				lst := headers
				lst.start
			until
				lst.after
			loop
				if has_same_header_name (lst.item, a_name) then
						-- remove
					lst.remove
				else
					lst.forth
				end
			end
		ensure
			removed: not has_header_named (a_name)
		end

feature -- Header change: general

	add_header (h: READABLE_STRING_8)
			-- Add header `h'
			-- if it already exists, there will be multiple header with same name
			-- which can also be valid
		do
			headers.force (h)
		end

	put_header (h: READABLE_STRING_8)
			-- Add header `h' or replace existing header of same header name
		do
			force_header_by_name (header_name_colon (h), h)
		end

feature -- Redirection

	remove_location
			-- Remove any location header line.
		do
			remove_header_named ({HTTP_HEADER_NAMES}.header_location)
		end

feature {NONE} -- Implementation: Header change

	force_header_by_name (n: detachable READABLE_STRING_8; h: READABLE_STRING_8)
			-- Add header `h' or replace existing header of same header name `n'
		require
			h_has_name_n: (n /= Void and attached header_name_colon (h) as hn) implies n.same_string (hn)
		local
			l_headers: like headers
		do
			if n /= Void then
				from
					l_headers := headers
					l_headers.start
				until
					l_headers.after or l_headers.item.starts_with (n)
				loop
					l_headers.forth
				end
				if not l_headers.after then
					l_headers.replace (h)
				else
					add_header (h)
				end
			else
				add_header (h)
			end
		end

feature {NONE} -- Implementation: Header conversion

	append_line_to (a_line: READABLE_STRING_8; h: STRING_8)
			-- Append header line `a_line' to string `h'.
			--| this is used to build the header text
		require
			not_ending_with_new_line: not a_line.ends_with_general ("%N")
		do
			h.append_string (a_line)
			append_end_of_line_to (h)
		end

	append_end_of_line_to (h: STRING_8)
			-- Append the CRLN end of header line to string `h'.
		do
			h.append_character ('%R')
			h.append_character ('%N')
		end

feature {NONE} -- Implementation: Header queries

	header_name_colon (h: READABLE_STRING_8): detachable STRING_8
			-- If any, header's name with colon
			--| ex: for "Foo-bar: something", this will return "Foo-bar:"
		local
			s: detachable STRING_8
			i,n: INTEGER
			c: CHARACTER
		do
			from
				i := 1
				n := h.count
				create s.make (10)
			until
				i > n or c = ':' or s = Void
			loop
				c := h[i]
				inspect c
				when ':' then
					s.extend (c)
				when '-', 'a' .. 'z', 'A' .. 'Z' then
					s.extend (c)
				else
					s := Void
				end
				i := i + 1
			end
			Result := s
		end

	header_name_value (h: READABLE_STRING_8): detachable TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]
			-- If any, header's [name,value]
			--| ex: for "Foo-bar: something", this will return ["Foo-bar", "something"]
		local
			s: detachable STRING_8
			i,n: INTEGER
			c: CHARACTER
		do
			from
				i := 1
				n := h.count
				create s.make (10)
			until
				i > n or c = ':' or s = Void
			loop
				c := h[i]
				inspect c
				when ':' then
				when '-', 'a' .. 'z', 'A' .. 'Z' then
					s.extend (c)
				else
					s := Void
				end
				i := i + 1
			end
			if s /= Void then
				Result := [s, h.substring (i, n)]
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
