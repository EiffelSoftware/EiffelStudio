note
	description: "[
		A configration modifier to convert a configration file to non-void-safe.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION_NON_VOID_SAFE_MODIFIER

inherit
	CONFIGURATION_MODIFIER

feature {NONE} -- Basic operations

	convert_void_safe_options (a_options: CONF_OPTION)
			-- <Precursor>
		local
			l_void_choice: CONF_VALUE_CHOICE
		do
				-- Conditionally set to avoid polluting the configuration file with defaults.
			a_options.unset_full_class_checking
			if a_options.is_full_class_checking then
				a_options.set_full_class_checking (False)
			end
			a_options.unset_is_attached_by_default
			if a_options.is_attached_by_default then
				a_options.set_is_attached_by_default (False)
			end
			l_void_choice := a_options.void_safety
			l_void_choice.unset
			if l_void_choice.index /= {CONF_OPTION}.void_safety_index_none then
				l_void_choice.put_index ({CONF_OPTION}.void_safety_index_none)
			end
		end

	convert_void_safe_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			l_new_path: STRING
		do
			if attached {CONF_FILE_LOCATION} a_library.location as l_location then
					-- Set the new path.
				l_new_path := file_helpers.unsafe_file_name (l_location.original_path)
				l_location.set_full_path (l_new_path)
			end
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
