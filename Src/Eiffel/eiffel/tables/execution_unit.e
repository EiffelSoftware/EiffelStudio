note
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

	make (cl_type: CLASS_TYPE)
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

	real_body_id: INTEGER
			-- Real body id
			--| To be redefined in EXT_EXECUTION_UNIT
		do
			Result := real_body_index
		end

	is_precompiled: BOOLEAN
			-- Is `index' coming from a precompiled library?
		do
			Result := real_body_id_counter.is_precompiled (real_body_id)
		end

	type_id: INTEGER
			-- `type_id' of `class_type'
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end

	class_type_id: INTEGER
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
		-- Id of the class where the associated feature of the unit is written in.

	access_in: INTEGER
		-- Id of the class where the associated feature's routine id is generated.

	real_pattern_id: INTEGER
			-- Pattern id associated with Current execution unit
		local
			l_written_type_id: INTEGER_32
			l_system: like system
		do
			l_system := System
			l_written_type_id := l_system.class_of_id (written_in).meta_type (class_type).type_id
			Result := l_system.pattern_table.c_pattern_id_in (pattern_id, l_system.class_type_of_id (l_written_type_id)) - 1
		end

	is_valid: BOOLEAN
			-- Is the execution unit still valid ?
		local
			written_class: CLASS_C
			f: FEATURE_AS
		do
			written_class := System.class_of_id (written_in)
			if
				written_class /= Void and then
				System.class_type_of_id (type_id) = class_type and then
				class_type.associated_class.inherits_from (written_class)
			then
				if access_in = written_in and then class_type.written_type (written_class).is_precompiled then
						-- If feature's routine id is generated from the written class and it is precompiled then
						-- it must be valid.
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
								-- an encapsulated feature or if the attribute is directly replicated, we need to check if
								-- encapsulation is still needed.
							Result := is_attribute_needed
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

	is_attribute_needed: BOOLEAN
			-- Check if an attribute is still needed?
		require
			is_encapsulated: is_encapsulated
		do
				-- Slow part, but we do not have any other way to find the
				-- associated feature with current information.
			if {l_encapsulated_feat: ENCAPSULATED_I} system.class_of_id (access_in).feature_table.feature_of_body_index (body_index) then
				Result := l_encapsulated_feat.generate_in > 0 or else l_encapsulated_feat.is_replicated_directly
			end
		end

	is_external: BOOLEAN
			-- Is current execution unit an external one ?
		do
			-- Do nothing
		end

	is_encapsulated: BOOLEAN
			-- Is current execution unit for an encapsulated call?
		do
			-- Do nothing
		end

	hash_code: INTEGER
			-- Hash code
		do
			Result := class_type_id * Mask + body_index
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to Current ?
		do
			Result := same_as (other)
		end

	same_as (other: EXECUTION_UNIT): BOOLEAN
			-- Is `other' similar to Current for EXECUTION_TABLE searches?
		require
			other_not_void: other /= Void
		do
			Result := class_type_id = other.class_type_id and then body_index = other.body_index
		ensure
			symmetric: Result implies other.same_as (Current)
		end

feature -- Setting

	set_class_type (t: CLASS_TYPE)
			-- Assign `t' to `class_type'.
		do
			class_type := t
		end

	set_body_index (i: like body_index)
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_index (i: like real_body_index)
			-- Assign `i' to `real_body_index'.
		do
			real_body_index := i
		end

	set_pattern_id (id: INTEGER)
			-- Assign `id' to `pattern_id'.
		require
			valid_id: id >= 0
		do
			pattern_id := id
		ensure
			pattern_id_set: pattern_id = id
		end

	set_written_in (id: INTEGER)
			-- Assign `id' to `written_in'.
		require
			valid_id: id >= 0
		do
			written_in := id
		ensure
			written_in_set: written_in = id
		end

	set_access_in (id: INTEGER)
			-- Assign `id' to `access_in'.
		require
			valid_id: id >= 0
		do
			access_in := id
		ensure
			access_in_set: access_in = id
		end

	set_type (a_type: TYPE_C)
			-- Assign `a_type' to `type'.
		require
			valid_type: a_type /= Void
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Generation

	compound_name: STRING
			-- Generate compound name
		do
			Result := Encoder.feature_name (class_type.type_id, body_index)
		end

	generate_declaration (buffer: GENERATION_BUFFER)
			-- Generate external declaration for the compound routine
		require
			good_argument: buffer /= Void
		do
			buffer.put_new_line
			buffer.put_string (once "extern ")
			type.generate (buffer)
			buffer.put_string (compound_name)
			buffer.put_three_character ('(', ')', ';')
		end

	generate (buffer: GENERATION_BUFFER)
			-- Generate compound pointer
		require
			good_argument: buffer /= Void
		do
			buffer.put_new_line
			buffer.put_string (once "(fnptr) ")
			buffer.put_string (compound_name)
			buffer.put_character (',')
		end

feature {NONE} -- Implementation

	Mask: INTEGER = 32768

invariant
	class_type_not_void: class_type /= Void

note
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
