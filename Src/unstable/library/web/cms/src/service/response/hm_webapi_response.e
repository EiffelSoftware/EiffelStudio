note
	description: "Summary description for Hyper media {HM_WEBAPI_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HM_WEBAPI_RESPONSE

inherit
	WEBAPI_RESPONSE

feature -- Element change

	add_self (a_href: READABLE_STRING_8)
		deferred
		end

	add_string_field (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL)
		deferred
		end

	add_boolean_field (a_name: READABLE_STRING_GENERAL; a_value: BOOLEAN)
		deferred
		end

	add_integer_64_field (a_name: READABLE_STRING_GENERAL; a_value: INTEGER_64)
		deferred
		end

	add_iterator_field (a_name: READABLE_STRING_GENERAL; a_value: ITERABLE [detachable ANY])
		deferred
		end

	add_table_iterator_field (a_name: READABLE_STRING_GENERAL; a_value: TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL])
		deferred
		end

	add_link (rel: READABLE_STRING_GENERAL; a_attname: detachable READABLE_STRING_8; a_att_href: READABLE_STRING_8)
		deferred
		end

	add_templated_link (rel: READABLE_STRING_GENERAL; a_attname: detachable READABLE_STRING_8; a_att_href: READABLE_STRING_8)
		deferred
		end

invariant

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
