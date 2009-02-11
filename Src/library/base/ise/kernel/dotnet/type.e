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

convert
	to_cil: {SYSTEM_TYPE, ?SYSTEM_TYPE}

feature -- Conversion

	to_cil: SYSTEM_TYPE
			-- Extract associated .NET type from Current
		local
			l_rt_type: ?RT_CLASS_TYPE
			l_type: ?SYSTEM_TYPE
		do
			l_rt_type := {ISE_RUNTIME}.type_of_generic (Current, 1)
			check l_rt_type_attached: l_rt_type /= Void end
			l_type := {ISE_RUNTIME}.interface_type (l_rt_type.dotnet_type)
			check l_type_attached: l_type /= Void end
			Result := l_type
		end

	adapt alias "[]" (g: ?G): ?G
			-- Adapts `g' or calls necessary conversion routine to adapt `g'
		do
			Result := g
		ensure
			adapted: Result ~ g
		end

	attempt alias "#?" (obj: ?ANY): ?G
			-- Result of assignment attempt of `obj' to an entity of type G
		do
			if {l_g: G} obj then
				Result := l_g
			end
		ensure
			assigned_or_void: Result = obj or Result = default_value
		end

	default_value: ?G
		do
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_rt_type: ?RT_CLASS_TYPE
		do
			l_rt_type := {ISE_RUNTIME}.type_of_generic (Current, 1)
			check l_rt_type_attached: l_rt_type /= Void end
			Result := l_rt_type.equals ({ISE_RUNTIME}.type_of_generic (other, 1))
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
