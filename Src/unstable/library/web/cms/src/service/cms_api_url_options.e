note
	description: "Summary description for {CMS_API_URL_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API_URL_OPTIONS

inherit
	CMS_API_OPTIONS

create
	make,
	make_from_manifest,
	make_for_url

convert
	make_from_manifest ({ ARRAY [TUPLE [key: STRING; value: detachable ANY]],
						  ARRAY [TUPLE [STRING_8, ARRAY [TUPLE [STRING_8, STRING_32]]]],
						  ARRAY [TUPLE [STRING_8, ARRAY [TUPLE [STRING_8, STRING_8]]]]
						})

feature {NONE} -- Initialization

	make_for_url (qs, a_fragment: detachable READABLE_STRING_8; is_absolute: BOOLEAN)
			-- Create options with a query string `qs`, a fragment `a_fragment`.
			-- If `is_absolute` is True, url will be absolute.
			-- See `{CMS_URL_UTILITIES}.url`
		do
			make (1)
			set_query_string (qs)
			set_fragment (a_fragment)
			set_absolute(is_absolute)
		end

feature -- Element change

	set_query_string (qs: detachable READABLE_STRING_8)
			-- Set the url query string to `qs`.
		do
			if qs = Void then
				table.remove ("query")
			else
				force (qs, "query")
			end
		end

	set_query_items (a_items: detachable ITERABLE [TUPLE [key, value: READABLE_STRING_GENERAL]])
			-- Set query items to `a_items`.
		do
			if a_items = Void then
				table.remove ("query")
			else
				force (a_items, "query")
			end
		end

	set_fragment (fr: detachable READABLE_STRING_8)
			-- Set the url fragment to `fr`.
		do
			if fr = Void then
				table.remove ("fragment")
			else
				force (fr, "fragment")
			end
		end

	set_absolute (is_abs: BOOLEAN)
			-- Set the url to be absolute is `is_abs` is True.
		do
			if is_abs then
				force (True, "absolute")
			else
				table.remove ("absolute")
			end
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
