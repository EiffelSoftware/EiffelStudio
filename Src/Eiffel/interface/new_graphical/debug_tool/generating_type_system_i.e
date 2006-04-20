indexing
	description: "Objects that helps to manage ANY.generating_type feature ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATING_TYPE_SYSTEM_I

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

feature -- Access

	generating_type_feature_name: STRING is "generating_type"

	generating_type_feature_i (c: CLASS_C): FEATURE_I is
			-- Generating_type feature related to class `c'.
		do
			Result := c.feature_of_rout_id (generating_type_feature.rout_id_set.first)
		end
		
	generating_type_class: CLASS_C is
			-- Class that provides the `generating_type' interface
		do
			Result := Eiffel_system.system.any_class.compiled_class
		end

	generating_type_feature: FEATURE_I is
			-- feature_i that corresponds to {ANY}.generating_type.
		do
			if
				internal_generating_type_feature.item = Void
			then
				internal_generating_type_feature.put (
					generating_type_class.feature_named (generating_type_feature_name))
			end
			Result := internal_generating_type_feature.item
		end

	internal_generating_type_feature: CELL [FEATURE_I] is
			-- Last computed `generating_type_feature'.
		once
			create Result.put (Void)
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

end -- class GENERATING_TYPE_SYSTEM_I
