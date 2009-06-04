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
		rename
			default as any_default
		redefine
			is_equal
		end

create {NONE}

convert
	to_cil: {SYSTEM_TYPE, detachable SYSTEM_TYPE}

feature -- Status report

	has_default: BOOLEAN
			-- Is current type a type that has a default value?
			-- I.e. a detachable type or an expanded type.
		local
			l_rt_type: detachable RT_CLASS_TYPE
		do
			l_rt_type := {ISE_RUNTIME}.type_of_generic (Current, 1)
			check l_rt_type_attached: l_rt_type /= Void end
				-- Currently on .NET we assume there is always a default value
			Result := True
		end

feature -- Conversion

	to_cil: SYSTEM_TYPE
			-- Extract associated .NET type from Current
		local
			l_rt_type: detachable RT_CLASS_TYPE
			l_type: detachable SYSTEM_TYPE
		do
			l_rt_type := {ISE_RUNTIME}.type_of_generic (Current, 1)
			check l_rt_type_attached: l_rt_type /= Void end
			l_type := {ISE_RUNTIME}.interface_type (l_rt_type.dotnet_type)
			check l_type_attached: l_type /= Void end
			Result := l_type
		end

	adapt alias "[]" (g: detachable G): detachable G
			-- Adapts `g' or calls necessary conversion routine to adapt `g'
		do
			Result := g
		ensure
			adapted: Result ~ g
		end

	attempt alias "#?" (obj: detachable ANY): detachable G
			-- Result of assignment attempt of `obj' to an entity of type G
		do
			if attached {G} obj as l_g then
				Result := l_g
			end
		ensure
			assigned_or_void: Result = obj or Result = default_detachable_value
		end

	default_detachable_value: detachable G
		do
		end

	default: G
		require
			has_default: has_default
		external
			"built_in"
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_rt_type: detachable RT_CLASS_TYPE
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
