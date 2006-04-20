indexing
	description: "Information about invariant recently added to system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INV_MELTED_INFO

inherit
	MELTED_INFO

	SHARED_TYPE_I
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		do
			check
				has_invariant: feat_tbl.associated_class.invariant_feature /= Void
			end
			Result := feat_tbl.associated_class.invariant_feature
		end

feature {NONE} -- Implementation

	internal_execution_unit (class_type: CLASS_TYPE): INV_EXECUTION_UNIT is
			-- Create new EXECUTION_UNIT corresponding to Current type.
		do
			create Result.make (class_type)
			Result.set_body_index (body_index)
			Result.set_type (Void_c_type)
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
