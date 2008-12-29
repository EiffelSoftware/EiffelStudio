note
	description: "Information about feature recently added to system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class MELTED_INFO

inherit
	HASHABLE
		rename
			hash_code as body_index
		redefine
			is_equal
		end

	SHARED_EXEC_TABLE
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (f: FEATURE_I; associated_class: CLASS_C)
			-- Initialization
		require
			feature_not_void: f /= Void
			class_not_void: associated_class /= Void
		do
			body_index := f.body_index
			pattern_id := f.pattern_id
			if {l_attr: ATTRIBUTE_I} f then
				written_in := l_attr.generate_in
			else
				written_in := f.written_in
			end
			result_type := f.type
		end

feature -- Update

	update_execution_unit (class_type: CLASS_TYPE)
			-- Update execution unit.
		local
			exec_unit: EXECUTION_UNIT
		do
			exec_unit := execution_unit (class_type)
		end

	melt (class_type: CLASS_TYPE; feat_tbl: FEATURE_TABLE)
			-- Melt the feature
		do
			associated_feature (class_type.associated_class, feat_tbl).melt (execution_unit (class_type))
		end

feature -- Access

	body_index: INTEGER
			-- Body index of feature to melt.

	pattern_id: INTEGER
			-- Pattern id of feature to melt.

	written_in: INTEGER
			-- Class where current feature is to melt.

	result_type: TYPE_A
			-- Return type of current feature to melt.

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to Current ?
		do
			Result := body_index = other.body_index
		end

feature {NONE} -- Implementation

	execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT
			-- Execution unit for Current.
		require
			class_type_not_void: class_type /= Void
		do
				-- Evaluation of execution unit
			Result := internal_execution_unit (class_type)

				-- Update Execution_table with new routine information
			Execution_table.update_with (Result)

				-- Get the updated EXECUTION_UNIT
			Result := Execution_table.last_unit
		end

	internal_execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT
			-- Create new EXECUTION_UNIT corresponding to Current type.
		require
			class_type_not_void: class_type /= Void
		deferred
		end

	associated_feature (class_c: CLASS_C; feat_tbl: FEATURE_TABLE): FEATURE_I
			-- Associated feature
		require
			class_c_not_void: class_c /= Void
			feat_tbl__not_void: feat_tbl /= Void
		deferred
		ensure
			Result_exists: Result /= Void
		end

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
