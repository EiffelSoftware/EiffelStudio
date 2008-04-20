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

	written_type_id: INTEGER
			-- Type id where the feature is written in

	pattern_id: INTEGER
			-- Pattern id of the entry when `written_class_type' is not specified,
			-- otherwise the C pattern ID. The later is used for finalization.

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

	written_class: CLASS_C is
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in)
		end

	entry (class_type: CLASS_TYPE): ROUT_ENTRY is
			-- Entry for a routine
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
io.error.put_string (written_class.name)
io.error.put_new_line
end
			Result.set_written_type_id (written_class.meta_type (class_type).type_id)
				-- It is ok to call `written_class_type' since the above line is initializing it.
			Result.set_pattern_id (pattern_table.c_pattern_id (pattern_id, Result.written_class_type))
			if is_attribute then
				Result.set_is_attribute
			end
		end

feature -- update

	update (class_type: CLASS_TYPE) is
		do
			Precursor (class_type)
			set_written_type_id (written_class.meta_type (class_type).type_id)
				-- It is ok to call `written_class_type' since the above line is initializing it.
			set_pattern_id (pattern_table.c_pattern_id (pattern_id, written_class_type))
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
			Result := Encoder.feature_name (written_class_type.type_id, body_index)
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
