indexing
	description: "Description of an attribute in an instance of CLASS_TYPE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATTR_DESC 

inherit
	COMPARABLE
		undefine
			is_equal
		end

	SHARED_LEVEL
		export
			{NONE} all
		end

	SK_CONST
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end
		
	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end
		
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Access

	feature_id: INTEGER
			-- Feature id of an attribute

	attribute_name_id: INTEGER
			-- Name ID corresponding to `attribute_name'.

	attribute_name: STRING is
			-- Attribute name
		require
			attribute_name_id_positive: attribute_name_id > 0
		do
			Result := names_heap.item (attribute_name_id)
		ensure
			attribute_name_not_void: Result /= Void
		end

	rout_id: INTEGER
			-- Attribute routine id

feature -- Settings

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'.
		do
			feature_id := i
		end

	set_attribute_name_id (an_id: INTEGER) is
			-- Assign `s' to `attribute_name'.
		require
			an_id_positive: an_id > 0
		do
			attribute_name_id := an_id
		ensure
			attribute_name_id_set: attribute_name_id = an_id
		end

	set_rout_id (i: INTEGER) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i
		end

feature -- Status report

	level: INTEGER is
			-- Comparison criteria
		deferred
		end

	sk_value: INTEGER is
			-- Skeleton characteristic value
		deferred
		end

	type_i: TYPE_I is
			-- Corresponding TYPE_I instance for current description.
		deferred
		end

	is_bits: BOOLEAN is
			-- Is the attribute a BIT one ?
		do
		end

	is_expanded: BOOLEAN is
			-- Is the attribute an expanded one ?
		do
		end

	has_formal: BOOLEAN is
			-- Is the attribute a formal generic one ?
		do
			-- Do nothing
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater then Current ?
		do
			Result := level < other.level
				or else (level = other.level and then rout_id < other.rout_id)
		end

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
		do
			Result := other.level = level and other.feature_id = feature_id and
				other.rout_id = rout_id
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- file `file'.
		require
			buffer_not_void: buffer /= Void
		deferred
		end

	generate_generic_code (buffer: GENERATION_BUFFER; is_final_mode: BOOLEAN; code, idx : INTEGER) is
			-- Generate full type code for current attribute description in
			-- `buffer'.
		require
			buffer_not_void: buffer /= Void
			has_type: type_i /= Void
		local
			l_type: TYPE_I
		do
			buffer.put_string ("static int16 g_atype")
			buffer.put_integer (code)
			buffer.put_character ('_')
			buffer.put_integer (idx)
			buffer.put_string (" [] = {0,")
				-- In order to generate proper type description for current entry we need to
				-- evaluate `type_i' in the context of `current_type' from BYTE_CONTEXT, otherwise
				-- it is possible that we would not find the associated class type of `l_type'
				-- and therefore generate an incorrect type specification (Cf eweasel bug about
				-- storable).
			l_type := context.creation_type (type_i)			
			l_type.generate_cid (buffer, is_final_mode, False)
			buffer.put_string ("-1};%N")
		end

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC is
			-- Instantiation in `class_type' of the current
			-- attribute description
		require
			good_argument: class_type /= Void
		do
			Result := Current
		ensure
			no_formal: not Result.has_formal
		end

feature -- Debug

	trace is
			-- Debug purpose
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
