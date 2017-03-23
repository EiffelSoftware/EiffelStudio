note
	description: "[
				A COMPARATOR used to compare any strings in a safe way
				
				note: you should use this STRING_COMPARATOR rather than COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_COMPARATOR

inherit
	COMPARATOR [READABLE_STRING_GENERAL]

create
	make,
	make_caseless

feature {NONE} -- Initialization

	make
			-- Strings will be compared with case sensitive.
		do
			default_create
		end

	make_caseless
			-- Strings will be compared caseless.	
		do
			make
			is_case_insensitive := True
		end

feature -- Status report

	is_case_insensitive: BOOLEAN
			-- Ignoring case when comparing strings?
			-- (Default: False)			

	less_than (u, v: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `u' considered less than `v'?
		local
			props: like character_properties
			i, n: INTEGER
			u_ch, v_ch: CHARACTER_32
			done: BOOLEAN
		do
			from
				props := character_properties
				i := 1
				n := u.count.min (v.count)
			until
				i > n or done
			loop
				if is_case_insensitive then
					u_ch := props.to_lower (u.item (i))
					v_ch := props.to_lower (v.item (i))
				else
					u_ch := u.item (i)
					v_ch := v.item (i)
				end

				if u_ch = v_ch then
					i := i + 1
				else
					Result := u_ch < v_ch
					done := True
				end
			end
			if not done then
				Result := u.count < v.count
			end
		end

feature {NONE} -- Implementation

	character_properties: CHARACTER_PROPERTY
			-- Access to Unicode character properties
		once
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
