note
	description: "Summary description for {CRITERIA_MANIFEST_VALUE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CRITERIA_MANIFEST_VALUE [G]

inherit
	CRITERIA [G]

create
	make_true, make_false,
	make_name_value

feature {NONE} -- Initialization

	make_true
		do
			weight := 1
			name := Void
			value := Void
		end

	make_false
		do
			make_true
			is_not := True
		end

	make_name_value (n,v: READABLE_STRING_GENERAL)
		do
			weight := 1
			create name.make_from_string_general (n)
			create value.make_from_string_general (v)
		end

feature -- Status report

	meet (d: G): BOOLEAN
		do
			Result := True
		end

feature -- Access

	is_not: BOOLEAN

	name,value: detachable IMMUTABLE_STRING_32

	weight: REAL

feature -- Visitor

	accept (a_visitor: CRITERIA_VISITOR [G])
			-- <Precursor>
		do
			a_visitor.visit_manifest_value (Current)
		end

invariant
	name /= Void implies value /= Void

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
