indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Abstract description of an entry in a routine table (instance of
-- POLY_TABLE)

deferred class ENTRY

inherit
	COMPARABLE
		undefine
			is_equal
		end

	SHARED_WORKBENCH

	COMPILER_EXPORTER

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

feature -- comparison

	infix "<" (other: ENTRY): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result := type_id < other.type_id
		end

feature -- from ENTRY

	type_id: INTEGER
			-- Type id of the entry

	type: TYPE_I
			-- Result type fo the entry

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		do
			type_id := i;
		end;

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

feature -- for dead code removal

	is_attribute: BOOLEAN is
			-- is the feature_i associated an attribute ?
		do
		end

	feature_id: INTEGER
			-- feature id of the feature associated to the entry

	set_feature_id (i: INTEGER) is
		do
			feature_id := i
		end

feature -- Previously in POLY_UNIT

	class_id: INTEGER
			-- Id of the class associated to the current_unit

	type_a: TYPE_A
			-- Result type of the polymorphic entry

	set_class_id (i: INTEGER) is
			-- Assign `i' to `class_id'
		do
			class_id := i
		end

	set_type_a (t: TYPE_A) is
			-- Assign `t' to `type_a'.
		do
			type_a := t
		end;

feature -- previously in POLY_UNIT

	new_poly_table (routine_id: INTEGER): POLY_TABLE [ENTRY] is
			-- New associated polymophic unit table
		require
			valid_routine_id: routine_id /= 0
		deferred
		end;

	entry (class_type: CLASS_TYPE): ENTRY is
			-- Entry in a poly-table for final mode
		require
			class_type_not_void: class_type /= Void
		deferred
		end;

	feature_type (class_type: CLASS_TYPE): TYPE_I is
			-- Type id of the result type in `class_type'.
		require
			good_argument: class_type /= Void
		do
			Result := type_a.actual_type.type_i
			if not Result.is_formal then
				Result := Result.instantiation_in (class_type)
			end
		end

feature -- updates

	update (class_type: CLASS_TYPE) is
			-- Enlarged current entry to manage correctly polymorphism with generics.
		require
			class_type_not_void: class_type /= Void
		do
			set_type_id (class_type.type_id)
			set_type (feature_type (class_type))
		end

feature -- from ENTRY

	used: BOOLEAN is
			-- Is the entry used ?
		deferred
		end;

	static_feature_type_id: INTEGER is
			-- Type id of the Result type
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= type;
			if
				not ( class_type = Void or else class_type.is_basic
				--or else --class_type.is_expanded
				)
			then
				Result := class_type.associated_class_type.static_type_id;
			end;
		end;

	generated_static_feature_type_id (buffer: GENERATION_BUFFER) is
			-- Textual representation of type id of the Result type
		local
			class_type: CL_TYPE_I
		do
			class_type ?= type;
			if
				not ( class_type = Void or else class_type.is_basic
				--or else-class_type.is_expanded
				)
			then
				buffer.put_static_type_id (class_type.associated_class_type.static_type_id)
			else
				buffer.put_integer (-1)
			end
		end;

	feature_type_id: INTEGER is
			-- Type id of the Result type
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= type;
			if
				not ( class_type = Void or else class_type.is_basic
				--or else --class_type.is_expanded
				)
			then
				Result := class_type.type_id;
			end;
		end;

	is_generic : BOOLEAN is
			-- Is `type' a generic type?
		local
			gtype : GEN_TYPE_I
		do
			gtype ?= type;
			Result := (gtype /= Void) or type.is_formal
		end;

	generate_cid (buffer: GENERATION_BUFFER; final_mode: BOOLEAN) is
			-- Generate list of type id's of generic type
			-- separated by commas.
		require
			is_generic : is_generic
		local
			l_class_type: CLASS_TYPE
			l_type: TYPE_I
		do
				-- In order to generate proper type description for current entry we need to
				-- evaluate `type' in the context of `type_id', otherwise it is possible that
				-- we would not find the associated class type of `l_type' and therefore generate
				-- an incorrect type specification (Cf eweasel bug about storable).
			l_class_type := System.class_type_of_id (type_id)
			context.set_class_type (l_class_type)
			l_type := context.creation_type (type)
			l_type.generate_cid (buffer, final_mode, False)
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for type of current entry.
		require
			is_generic : is_generic
		do
			type.make_gen_type_byte_code (ba, False)
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		deferred
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
