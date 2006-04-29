indexing
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

convert
	to_cil: {SYSTEM_TYPE}

feature -- Conversion

	to_cil: SYSTEM_TYPE is
			-- Extract associated .NET type from Current
		do
			Result := {ISE_RUNTIME}.interface_type (
				{ISE_RUNTIME}.type_of_generic (Current, 1).dotnet_type)
		end

	adapted alias "[]" (g: G): G is
			-- Adapts `g' or calls necessary conversion routine to adapt `g'
		do
			Result := g
		ensure
			adapted: equal (Result, g)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := {ISE_RUNTIME}.type_of_generic (Current, 1).equals ({ISE_RUNTIME}.type_of_generic (other, 1))
		end

indexing
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
