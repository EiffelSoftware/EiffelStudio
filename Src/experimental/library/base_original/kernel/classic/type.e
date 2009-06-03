note
	description: "Representation of an Eiffel type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE [G]

inherit
	ANY
		redefine
			is_equal
		end

create {NONE}

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_internal: INTERNAL
		do
			create l_internal
			Result := l_internal.generic_dynamic_type (Current, 1) =
				l_internal.generic_dynamic_type (other, 1)
		end

feature -- Conversion

	adapt alias "[]" (g: G): G
			-- Adapts `g' or calls necessary conversion routine to adapt `g'
		do
			Result := g
		ensure
			adapted: equal (Result, g)
		end

	attempt alias "#?" (obj: ANY): G
			-- Result of assignment attempt of `obj' to entity of type G
		do
			Result ?= obj
		ensure
			assigned_or_void: Result = obj or Result = default_value
		end

	default_value: G
		do
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
