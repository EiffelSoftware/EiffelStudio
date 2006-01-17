indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXPORT_ADAPTATION 

inherit

	HASH_TABLE [EXPORT_I, INTEGER]
	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end
	SHARED_ERROR_HANDLER
		undefine
			copy, is_equal
		end

create

	make
	
feature 

	all_export: EXPORT_I
			-- Export for keyword all

	set_all_export (e: EXPORT_I) is
			-- Assign `e' to `all_export'.
		do
			all_export := e
		end

	new_export_for (feature_name_id: INTEGER): EXPORT_I is
			-- Export adatation for feature `feature_name_id'
		require
			good_argument: feature_name_id > 0
		do
			Result := item (feature_name_id)
			if Result = Void then
				Result := all_export
			end
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
