indexing
	description: "Execution unit of an Eiffel feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTION_UNIT

inherit
	HASHABLE
		redefine
			is_equal
		end

	SHARED_SERVER
		undefine
			is_equal
		end

	SHARED_TYPE_I
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_PATTERN_TABLE
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	SHARED_COUNTER
		undefine
			is_equal
		end

	SHARED_GENERATION
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (cl_type: CLASS_TYPE) is
			-- Initialization
		require
			cl_type_not_void: cl_type /= Void
		do
			class_type := cl_type
		ensure
			class_type_set: class_type = cl_type
		end

feature -- Access

	type: TYPE_C
			-- C type of the unit

	class_type: CLASS_TYPE
			-- Class type to which the unit belongs to

	body_index: INTEGER
			-- Second part of the unit description

	real_body_index: INTEGER
			-- Index of the unit in an array

	real_body_id: INTEGER is
			-- Real body id
			--| To be redefined in EXT_EXECUTION_UNIT
		do
			Result := real_body_index
		end

	is_precompiled: BOOLEAN is
			-- Is `index' coming from a precompiled library?
		do
			Result := real_body_id_counter.is_precompiled (real_body_id)
		end

	type_id: INTEGER is
			-- `type_id' of `class_type'
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end

	class_type_id: INTEGER is
			-- `id' of `class_type'
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.static_type_id
		end

	pattern_id: INTEGER
		-- Pattern id of feature corresponding to Current
		-- unit

	written_in: INTEGER
		-- Id of class in which the feature corresponding
		-- to Current execution unit is written.
		--|Note: for ATTRIBUTE_I it is the `generate_in' value.

	real_pattern_id: INTEGER is
			-- Pattern id associated with Current execution unit
		local
			written_type: CLASS_TYPE
			written_class: CLASS_C
		do
			written_class := System.class_of_id (written_in)
			written_type :=	class_type.written_type (written_class)
			Result := Pattern_table.c_pattern_id (pattern_id, written_type) - 1
		end

	is_valid: BOOLEAN is
			-- Is the execution unit still valid ?
		local
			written_type: CLASS_TYPE
			written_class: CLASS_C
			f: FEATURE_AS
		do
			written_class := System.class_of_id (written_in)
			if
				written_class /= Void and then
				System.class_type_of_id (type_id) = class_type
			then
				written_type :=	class_type.written_type (written_class)
				if written_type.is_precompiled then
					Result := True
				else
						-- Feature may have disappeared from system and
						-- we need to detect it.
					Result := Body_server.server_has (body_index)
					if
						Result and then
						System.execution_table.has_dead_function (body_index)
					then
						if is_encapsulated then
								-- If this was a unit for keeping access to
								-- an encapsulated feature, we need to check if
								-- encapsulation is still needed.
							Result := is_encapsulation_needed
						else
							f := Body_server.server_item (body_index)

								-- This is an attribute that was a function before, so
								-- it is not a valid `execution_unit' anymore if after
								-- all recompilation it is still an attribute.
								--
								-- Or if it is a deferred feature that was not
								-- deferred before
							Result := not f.is_attribute and then not f.is_deferred
						end
					end
				end
			end
		end

	is_encapsulation_needed: BOOLEAN is
			-- Check if an encapsulation is still needed?
		require
			is_encapsulated: is_encapsulated
		local
			feat_tbl: FEATURE_TABLE
			encapsulated_feat: ENCAPSULATED_I
			l_written_class: CLASS_C
		do
			l_written_class := system.class_of_id (written_in)
			check
				has_feature_table: l_written_class.has_feature_table
			end
				-- Load feature table associated to class id `written_in'.
			feat_tbl := l_written_class.feature_table

				-- Slow part, but we do not have any other way to find the
				-- associated feature with current information.
			encapsulated_feat ?= feat_tbl.feature_of_body_index (body_index)
			Result := encapsulated_feat /= Void and then encapsulated_feat.generate_in > 0
		end

	is_external: BOOLEAN is
			-- Is current execution unit an external one ?
		do
			-- Do nothing
		end

	is_encapsulated: BOOLEAN is
			-- Is current execution unit for an encapsulated call?
		do
			-- Do nothing
		end

	hash_code: INTEGER is
			-- Hash code
		do
			Result := class_type_id * Mask + body_index
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := class_type_id = other.class_type_id
						and then body_index = other.body_index
		end

feature -- Setting

	set_class_type (t: CLASS_TYPE) is
			-- Assign `t' to `class_type'.
		do
			class_type := t
		end

	set_body_index (i: like body_index) is
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_index (i: like real_body_index) is
			-- Assign `i' to `real_body_index'.
		do
			real_body_index := i
		end

	set_pattern_id (id: INTEGER) is
			-- Assign `id' to `pattern_id'.
		require
			valid_id: id >= 0
		do
			pattern_id := id
		ensure
			pattern_id_set: pattern_id = id
		end

	set_written_in (id: INTEGER) is
			-- Assign `id' to `pattern_id'.
		require
			valid_id: id >= 0
		do
			written_in := id
		ensure
			written_in_set: written_in = id
		end

	set_type (a_type: TYPE_C) is
			-- Assign `a_type' to `type'.
		require
			valid_type: a_type /= Void
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Generation

	compound_name: STRING is
			-- Generate compound name
		do
			Result := Encoder.feature_name (class_type.static_type_id, body_index)
		end

	generate_declaration (buffer: GENERATION_BUFFER) is
			-- Generate external declaration for the compound routine
		require
			good_argument: buffer /= Void
		do
			buffer.put_new_line
			buffer.put_string ("extern ")
			type.generate (buffer)
			buffer.put_string (compound_name)
			buffer.put_three_character ('(', ')', ';')
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generate compound pointer
		require
			good_argument: buffer /= Void
		do
			buffer.put_new_line
			buffer.put_string ("(fnptr) ")
			buffer.put_string (compound_name)
			buffer.put_character (',')
		end

feature -- Debug

	trace is
		do
			io.error.put_string (generator)
			io.error.put_string ("%NBody_index: ")
			io.error.put_integer (body_index)
			io.error.put_string ("%NIndex: ")
			io.error.put_integer (real_body_index)
			io.error.put_string ("%NPattern id: ")
			io.error.put_integer (pattern_id)
			io.error.put_string ("%Nwritten_in: ")
			io.error.put_integer (written_in)
			io.error.put_string ("%NType: ")
			type.trace
			io.error.put_new_line
		end

feature {NONE} -- Implementation

	Mask: INTEGER is 32768

invariant
	class_type_not_void: class_type /= Void

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
