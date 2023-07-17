note
	description: "Representation of an Eiffel type."
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE [G]

inherit
	PART_COMPARABLE
		rename
			default as any_default,
			is_less as is_strictly_conforming_to alias "<",
			is_less_equal as is_conforming_to alias "<="
		redefine
			is_conforming_to, is_equal, out
		end

--	DEBUG_OUTPUT
--		rename
--			default as any_default
--		redefine
--			is_equal, out
--		end

create {NONE}
	-- Creation is done either by using manifest types
	-- or by calling ANY.generating_type.

convert
		-- Conversion useful for the transition period because of the
		-- modification in ANY:
		--    generating_type: STRING
		-- becomes:
		--    generating_type: TYPE [like Current]
	to_string_8: {STRING_8}

feature -- Access

	name: STRING_8
			-- Name of Eiffel type represented by `Current', using Eiffel style guidelines
			-- as specified in OOSC2 (e.g. COMPARABLE, HASH_TABLE [FOO, BAR], ...)
		do
			if attached internal_name as l_name then
				Result := l_name
			else
				Result := runtime_name
				internal_name := Result
			end
		ensure
			name_not_void: Result /= Void
		end

	name_32: STRING_32
			-- Fake function for the purpose of mini_base
		do
			Result := name.as_string_32
		end

	generic_parameter_type (i: INTEGER): TYPE [detachable ANY]
			-- `i'-th generic parameter of Eiffel type represented by `Current'
		require
			i_large_enough: i >= 1
			i_small_enough: i <= generic_parameter_count
		external
			"built_in"
		ensure
			generic_parameter_not_void: Result /= Void
		end

	type_id: INTEGER
			-- Id of the Eiffel type represented by `Current'
		external
			"built_in"
		ensure
			type_id_not_negative: Result >= 0
		end

	hash_code: INTEGER
			-- Hash code value
		do
			Result := type_id
		end

	as_frozen: frozen TYPE [frozen G]
			-- Frozen variant of actual generic parameter
		do
			Result := {frozen G}
		end

feature -- Measurement

	generic_parameter_count: INTEGER
			-- Number of generic parameters in Eiffel type represented by `Current'
		external
			"built_in"
		ensure
			generic_parameter_count_not_negative: Result >= 0
		end

feature -- Status report

	has_default: BOOLEAN
			-- Is current type a type that has a default value?
			-- I.e. a detachable type or an expanded type.
		external
			"built_in"
		end

	is_expanded: BOOLEAN
			-- Is current type an expanded type?
		external
			"built_in"
		end

	is_attached: BOOLEAN
			-- Is current type attached?
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

	is_strictly_conforming_to alias "<" (other: like Current): BOOLEAN
			-- Does type represented by `Current' conform to type represented by `other' and differ from it?
		do
			Result := type_id /= other.type_id and then is_conforming_to (other)
		end

	is_conforming_to alias "<=" (other: like Current): BOOLEAN
			-- Does type represented by `Current' conform to type represented by `other'?
		do
			Result := conforms_to (other)
		end

feature -- Conversion

	adapt alias "[]" (g: detachable G): detachable G
			-- Adapts `g' or calls necessary conversion routine to adapt `g'
		do
			Result := g
		ensure
			adapted: Result ~ g
		end

	attempted alias "/" (obj: detachable separate ANY): detachable G
			-- If possible, `obj' understood as an object of type `G';
			-- If not, default detachable value of type `G'..
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

	to_string_8: STRING_8
		obsolete
			"Use `name' instead (or `out' during the transition period)."
		do
			Result := name
		ensure
			to_string_8_not_void: Result /= Void
		end

feature {NONE} -- Implementation: Access

	internal_name: detachable STRING_8
			-- Storage for once per object `name'

feature {NONE} -- Implementation

	runtime_name: STRING
			-- Name of Eiffel type represented by `Current', using Eiffel style guidelines
			-- as specified in OOSC2 (e.g. COMPARABLE, HASH_TABLE [FOO, BAR], ...)
		external
			"built_in"
		ensure
			name_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
