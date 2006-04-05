indexing
	description: "Representation for an routine entry in an instance of ROUT_TABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUT_ENTRY

inherit
	ENTRY
		redefine
			update, is_attribute
		end

	SHARED_ID_TABLES
	SHARED_EXEC_TABLE
	SHARED_PATTERN_TABLE
	SHARED_GENERATION
	COMPILER_EXPORTER

feature -- Access

	body_index: INTEGER
			-- Body index

	written_type_id: INTEGER
			-- Type id where the feature is written in

	pattern_id: INTEGER
			-- Pattern id of the entry
	
	is_attribute: BOOLEAN is False
			-- is the feature_i associated an attribute ?	

feature -- Comparison

	same_as (other: ROUT_ENTRY): BOOLEAN is
			-- Is `Current' similar to `other'?
		require
			other_not_void: other /= Void
		do
			Result := written_type_id = other.written_type_id and body_index = other.body_index
		end

feature -- Settings

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_written_type_id (i: INTEGER) is
			-- Assign `i' to `written_type_id'.
		do
			written_type_id := i
		end

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end

feature -- previously in ROUT_UNIT

	written_in: INTEGER
			-- Id of the class where the associated feature of the
			-- unit is written in

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i
		end

	written_class: CLASS_C is
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in)
		end

	new_poly_table (routine_id: INTEGER): ROUT_TABLE is
			-- New associated polymorhic table
		do
			create Result.make (routine_id)
		end

	entry (class_type: CLASS_TYPE): ROUT_ENTRY is
			-- Entry for a routine
		do
			create Result
			Result.set_type_id (class_type.type_id)
			Result.set_type (feature_type (class_type))
			Result.set_body_index (body_index)
debug
io.error.put_string ("arg = ")
io.error.put_string (class_type.type.base_class.name)
io.error.put_string ("   ")
io.error.put_string ("cur = ")
io.error.put_string (written_class.name)
io.error.put_new_line
end
			Result.set_written_type_id (written_class.meta_type (class_type).type_id)
		end

feature -- update

	update (class_type: CLASS_TYPE) is
		do
			Precursor {ENTRY} (class_type)
			set_written_type_id (written_class.meta_type (class_type).type_id)
		end

feature -- from ROUT_ENTRY

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
			system_i: SYSTEM_I
		do
			system_i := System
			remover := system_i.remover
			Result := 	remover = Void						-- Workbench mode
						or else system_i.remover_off		-- Dead code removal disconnected
						--or else is_marked
						or else remover.is_alive (body_index)	-- Final mode
		end

	routine_name: STRING is
			-- Routine name to generate
		do
			Result := Encoder.feature_name (written_class_type.static_type_id, body_index)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		do
				-- Dynamic type
			ba.append_short_integer (type_id - 1)
				-- Real body index
			ba.append_short_integer (real_body_index - 1)
				-- Pattern id
			ba.append_short_integer (pattern_id)
		end

	written_class_type: CLASS_TYPE is
		do
			Result := System.class_type_of_id (written_type_id)
		end

	real_body_index: INTEGER is
			-- Real body index
		do
			Result := Execution_table.real_body_index (body_index, written_class_type)
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

end -- class ROUT_ENTRY
