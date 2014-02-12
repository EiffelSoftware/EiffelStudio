note
	description: "Truth values, with the boolean operations"
	external_name: "System.Boolean"
	assembly: "mscorlib"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class BOOLEAN

feature -- Access

	item: like Current

feature -- Settings

	set_item (i: like Current)
			-- Make `i' the item value.
		do
			item := i
		ensure
			item_set: item = i
		end

feature -- Basic operations

	conjuncted alias "and" (other: BOOLEAN): BOOLEAN
			-- Boolean conjunction with `other'
		do
		end

	conjuncted_semistrict alias "and then" (other: BOOLEAN): BOOLEAN
			-- Boolean semi-strict conjunction with `other'
		do
		end

	implication alias "implies" (other: BOOLEAN): BOOLEAN
			-- Boolean implication of `other'
			-- (semi-strict)
		do
		end

	negated alias "not": BOOLEAN
			-- Negation
		do
		end

	disjuncted alias "or" (other: BOOLEAN): BOOLEAN
			-- Boolean disjunction with `other'
		do
		end

	disjuncted_semistrict alias "or else" (other: BOOLEAN): BOOLEAN
			-- Boolean semi-strict disjunction with `other'
		do
		end

	disjuncted_exclusive alias "xor" (other: BOOLEAN): BOOLEAN
			-- Boolean exclusive or with `other'
		do
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
