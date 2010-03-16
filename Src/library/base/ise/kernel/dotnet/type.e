note
	description: "Representation of an Eiffel type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE [G]

inherit
	HASHABLE
		rename
			default as any_default
		redefine
			is_equal, out
		end

	DEBUG_OUTPUT
		rename
			default as any_default
		redefine
			is_equal, out
		end

create {NONE}
	-- Creation is done either by using manifest types
	-- or by calling ANY.generating_type.

convert
		-- Conversion useful for the transition period because of the
		-- modification in ANY:
		--    generating_type: STRING
		-- becomes:
		--    generating_type: TYPE [like Current]
	to_string_8: {STRING_8, STRING_GENERAL, READABLE_STRING_GENERAL, READABLE_STRING_8},
	to_string_32: {STRING_32, READABLE_STRING_32},
	to_cil: {SYSTEM_TYPE}

feature -- Access

	name: IMMUTABLE_STRING_8
			-- Name of Eiffel type represented by `Current', using Eiffel style guidelines
			-- as specified in OOSC2 (e.g. COMPARABLE, HASH_TABLE [FOO, BAR], ...)
		do
			if attached internal_name as l_name then
				Result := l_name
			else
				create Result.make_from_string (runtime_name)
				internal_name := Result
			end
		ensure
			name_not_void: Result /= Void
		end

	generic_parameter_type (i: INTEGER): TYPE [detachable ANY]
			-- `i'-th generic parameter of Eiffel type represented by `Current'
		require
			i_large_enough: i >= 1
			i_small_enough: i <= generic_parameter_count
		do
			Result := internal.type_of_type (type_id)
		ensure
			generic_parameter_not_void: Result /= Void
		end

	type_id: INTEGER
			-- Id of the Eiffel type represented by `Current'
		local
			l_class_type: detachable RT_CLASS_TYPE
		do
			l_class_type := {ISE_RUNTIME}.type_of_generic (Current, 1)
			check l_class_type_attached: l_class_type /= Void end
			l_class_type := internal.internal_pure_interface_type (l_class_type)
			check l_class_type_attached: l_class_type /= Void end
			Result := internal.dynamic_type_from_rt_class_type (l_class_type)
		ensure
			type_id_not_negative: Result >= 0
		end

	hash_code: INTEGER
			-- Hash code value
		do
			Result := type_id
		end

feature -- Measurement

	generic_parameter_count: INTEGER
			-- Number of generic parameters in Eiffel type represented by `Current'
		local
			l_class_type: detachable RT_CLASS_TYPE
		do
			l_class_type := {ISE_RUNTIME}.type_of_generic (Current, 1)
			check l_class_type_attached: l_class_type /= Void end
			l_class_type := internal.internal_pure_interface_type (l_class_type)
			if attached {RT_GENERIC_TYPE} l_class_type as l_gen_type then
				Result := l_gen_type.count
			end
		end

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
		do
			Result := type_id = other.type_id
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := name
		end

	debug_output: STRING
			-- <Precursor>
		do
			Result := name
		end

feature -- Features from STRING needed here for the transition period (see convert clause)

	plus alias "+" (other: STRING): STRING
			-- Append a copy of 's' at the end of a copy of the name of the
			-- Eiffel type represented by `Current', then return the Result.
			-- This feature from STRING is needed here for the
			-- transition period (see convert clause).
		obsolete
			"[070813] Use 'name + other' instead (or 'out + other' during the transition period)."
		require
			argument_not_void: other /= Void
		do
			Result := name + other
		ensure
			result_exists: Result /= Void
			definition: Result.is_equal (name + other)
		end

	same_string (other: STRING): BOOLEAN
			-- Do the name of the Eiffel type represented by `Current'
			-- and `other' have same character sequence?
			-- This feature from STRING is needed here for the
			-- transition period (see convert clause).
		obsolete
			"[070813] Use 'name.same_string (other)' instead (or 'out.same_string (other)' during the transition period)."
		require
			other_not_void: other /= Void
		do
			Result := name.same_string (other)
		ensure
			definition: Result = name.same_string (other)
		end

	is_case_insensitive_equal (other: STRING): BOOLEAN
			-- Is the name of the Eiffel type represented by `Current'
			-- made of same character sequence as `other' regardless
			-- of casing (possibly with a different capacity)?
			-- This feature from STRING is needed here for the
			-- transition period (see convert clause).
		obsolete
			"[070813] Use 'name.is_case_insensitive_equal (other)' instead (or 'out.is_case_insensitive_equal (other)' during the transition period)."
		require
			other_not_void: other /= Void
		do
			Result := name.is_case_insensitive_equal (other)
		ensure
			definition: Result = name.is_case_insensitive_equal (other)
		end

	as_lower: STRING
			-- New object with all letters of the name of the Eiffel type
			-- represented by `Current' in lower case.
			-- This feature from STRING is needed here for the
			-- transition period (see convert clause).
		obsolete
			"[070813] Use 'name.as_lower' instead (or 'out.as_lower' during the transition period)."
		do
			Result := name.as_lower
		ensure
			as_lower_not_void: Result /= Void
			definition: Result.is_equal (name.as_lower)
		end

	as_upper: STRING
			-- New object with all letters of the name of the Eiffel type
			-- represented by `Current' in upper case.
			-- This feature from STRING is needed here for the
			-- transition period (see convert clause).
		obsolete
			"[070813] Use 'name.as_upper' instead (or 'out.as_upper' during the transition period)."
		do
			Result := name.as_upper
		ensure
			as_upper_not_void: Result /= Void
			definition: Result.is_equal (name.as_upper)
		end

	to_string_8: STRING_8
		obsolete
			"Use `name' instead (or `out' during the transition period)."
		do
			Result := name
		ensure
			to_string_8_not_void: Result /= Void
		end

	to_string_32: STRING_32
			-- Name of type
		obsolete
			"[080717] Use 'name' instead (or 'out' during the transition period)."
		do
			Result := name
		ensure
			to_string_32_not_void: Result /= Void
		end

feature {NONE} -- Implementation: Access

	internal_name: detachable IMMUTABLE_STRING_8
			-- Storage for once per object `name'

feature {NONE} -- Implementation

	runtime_name: STRING
			-- Name of Eiffel type represented by `Current', using Eiffel style guidelines
			-- as specified in OOSC2 (e.g. COMPARABLE, HASH_TABLE [FOO, BAR], ...)
		do
			Result := internal.type_name_of_type (type_id)
		ensure
			name_not_void: Result /= Void
		end

	internal: INTERNAL
		once
			create Result
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
