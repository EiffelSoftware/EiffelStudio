indexing
	description: "Representation for an routine entry in an instance of ROUT_TABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUT_ENTRY

inherit
	ATTR_ENTRY
		redefine
			 entry, is_attribute, update, used, is_deferred
		end

	SHARED_ID_TABLES
	SHARED_EXEC_TABLE
	SHARED_PATTERN_TABLE
	SHARED_GENERATION
	COMPILER_EXPORTER

feature -- Access

	body_index: INTEGER
			-- Body index

	access_type_id: INTEGER
			-- Type id where the feature is accessed through its routine id.

	pattern_id: INTEGER
			-- Pattern id of the entry when `access_class_type' is not specified,
			-- otherwise the C pattern ID. The later is used for finalization.

	access_in: INTEGER
			-- Id of the class where the associated feature can be access through its routine id.

	written_in: INTEGER
			-- Id of the class where the associated feature of the
			-- unit is written in

	is_attribute: BOOLEAN
			-- Is the entry associated with an attribute?

	is_deferred: BOOLEAN
			-- Is the entry associated with a deferred routine?

feature -- Comparison

	same_as (other: ROUT_ENTRY): BOOLEAN is
			-- Is `Current' similar to `other'?
		require
			other_not_void: other /= Void
		do
			Result := access_type_id = other.access_type_id and body_index = other.body_index
		end

feature -- Settings

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_access_type_id (i: INTEGER) is
			-- Assign `i' to `written_type_id'.
		do
			access_type_id := i
		end

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		require
			i_positive: i > 0
		do
			pattern_id := i
		ensure
			pattern_id_set: pattern_id = i
		end

	set_is_deferred (v: BOOLEAN) is
			-- Assign `v' to `is_deferred'.
		do
			is_deferred := v
		ensure
			is_deferred_set: is_deferred = v
		end

	set_access_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			access_in := i
		end

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i
		end

	set_is_attribute is
			-- Mark this entry an attribute.
		do
			is_attribute := True
		ensure
			is_attribute: is_attribute
		end

feature -- previously in ROUT_UNIT

	access_class: CLASS_C is

			-- Class where the feature can be accessed through its routine ID.
		do
			Result := System.class_of_id (access_in)
		end

	written_class: CLASS_C is
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in)
		end

	entry (class_type: CLASS_TYPE): ROUT_ENTRY is
			-- Entry for a routine
		local
			l_written_type_id: INTEGER
			l_access_type_id: INTEGER
		do
			create Result
			Result.set_type_id (class_type.type_id)
			Result.set_feature_id (feature_id)
			Result.set_type (feature_type (class_type))
			Result.set_body_index (body_index)
debug
io.error.put_string ("arg = ")
io.error.put_string (class_type.type.associated_class.name)
io.error.put_string ("   ")
io.error.put_string ("cur = ")
io.error.put_string (access_class.name)
io.error.put_new_line
end
			l_access_type_id := access_class.meta_type (class_type).type_id
			Result.set_access_type_id (l_access_type_id)
			if access_in /= written_in then
					-- We have a replicated feature so we need to generate
					-- the pattern info from the written in type.
				l_written_type_id := written_class.meta_type (class_type).type_id
			else
				l_written_type_id := l_access_type_id
			end
			Result.set_pattern_id (pattern_table.c_pattern_id_in (pattern_id, System.class_type_of_id (l_written_type_id)))

			if is_attribute then
				Result.set_is_attribute
			end
		end

feature -- update

	update (class_type: CLASS_TYPE) is
			-- Update `Current' for `class_type'.
		local
			l_written_type_id: INTEGER
		do
			Precursor (class_type)
			set_access_type_id (access_class.meta_type (class_type).type_id)
				-- It is ok to call `written_class_type' since the above line is initializing it.

			if access_in /= written_in then
					-- We have a replicated feature so we need to generate
					-- the pattern info from the written in type.
				l_written_type_id := written_class.meta_type (class_type).type_id
			else
				l_written_type_id := access_type_id
			end
			set_pattern_id (pattern_table.c_pattern_id_in (pattern_id, System.class_type_of_id (l_written_type_id)))
		end

feature -- from ROUT_ENTRY

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
			system_i: SYSTEM_I
		do
			if not is_deferred then
				system_i := System
				remover := system_i.remover
				Result := remover = Void or else		-- Workbench mode
					system_i.remover_off or else		-- Dead code removal disconnected
					-- is_marked or else
					remover.is_alive (body_index)		-- Final mode
			end
		end

	routine_name: STRING is
			-- Routine name to generate
		do
			Result := Encoder.feature_name (access_type_id, body_index)
		end

	access_class_type: CLASS_TYPE is
		do
			Result := System.class_type_of_id (access_type_id)
		end

	real_body_index: INTEGER is
			-- Real body index
		do
			Result := Execution_table.real_body_index (body_index, access_class_type)
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
