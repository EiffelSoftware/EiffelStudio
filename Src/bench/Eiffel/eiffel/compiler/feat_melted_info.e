indexing
	description: "Information about external feature recently added to system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEAT_MELTED_INFO

inherit
	MELTED_INFO
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; associated_class: CLASS_C) is
			-- Initialization
		do
			Precursor {MELTED_INFO} (f, associated_class)
			is_encapsulated_call := f.can_be_encapsulated
			feature_name_id := f.feature_name_id
		end

feature {NONE} -- Implementation

	feature_name_id: INTEGER
			-- Name ID of current_feature

	is_encapsulated_call: BOOLEAN
			-- Is Current a feature encapsulation of something that we usually do
			-- not generate (eg attribute or constant)?

	internal_execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Create new EXECUTION_UNIT corresponding to Current type.
		do
			if is_encapsulated_call then
				create {ENCAPSULATED_EXECUTION_UNIT} Result.make (class_type)
			else
				create Result.make (class_type)
			end
			Result.set_body_index (body_index)
			Result.set_pattern_id (pattern_id)
			Result.set_written_in (written_in)

			Result.set_type (result_type.instantiation_in (class_type).c_type)
		end

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		do
			check
				consistency: feat_tbl.has_id (feature_name_id)
			end
			Result := feat_tbl.item_id (feature_name_id)
		end

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
