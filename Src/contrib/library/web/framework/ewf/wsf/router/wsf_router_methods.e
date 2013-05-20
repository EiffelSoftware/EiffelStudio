note
	description: "[
					Object that is use in relation with WSF_ROUTER, to precise which request methods is accepted.
					For convenience, `make_from_iterable' is available, so that you can use <<"GET", "POST">> for instance
					but remember manifest string are evil ... 
					Since in HTTP you can use your own custom request method, this is not possible to catch any typo
					 ( for instance if you write "POST" instead of "P0ST" this is hard to find the error, 
					   but in one case it uses upper "o" and in the other case this is zero "0"
					 )
					   
					The recommanded way to use is for instance
					    create {WSF_ROUTER_METHODS}.make_get_post
					    create methods; methods.enable_get; methods.enable_post
					
					This sounds heavy, but this is much safer. 
					
					( note: in addition internally this first checks using reference comparison
					  and then compare string value, so it brings optimization for accepted request methods.
					)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTER_METHODS

obsolete
	"Use WSF_REQUEST_METHODS"

inherit
	WSF_REQUEST_METHODS
		redefine
			plus
		end

create
	default_create,
	make,
	make_from_iterable,
	make_from_string

convert
	to_array: {ARRAY [READABLE_STRING_8]},
	make_from_iterable ({ITERABLE [READABLE_STRING_8], ITERABLE [STRING_8], ARRAY [READABLE_STRING_8], ARRAY [STRING_8]}),
	make_from_string ({READABLE_STRING_8, STRING_8})

feature -- Basic operations

	add (a_other: like plus): like plus
		obsolete "Use `plus' or `alias +'"
		do
			Result := plus (a_other)
		end

	plus alias "+" (a_other: WSF_ROUTER_METHODS): WSF_ROUTER_METHODS
			-- Merge Current and a_other into Result
		do
			create Result.make_from_iterable (Current)
			Result.add_methods (a_other)
		end

;note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
