note
	description: "[
		A configration modifier to convert a configration file to void-safe.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION_VOID_SAFE_MODIFIER

inherit
	CONFIGURATION_MODIFIER
		redefine
			convert_system,
			convert_void_safe_target
		end

feature -- Status report

	is_safe_suffix_used: BOOLEAN assign set_is_safe_suffix_used
			-- Indicates if the '-safe' suffix should be used in reference libraries.

feature -- Status setting

	set_is_safe_suffix_used (a_used: BOOLEAN)
			-- Sets condition use of the '-safe' suffix in referenced libraries.
			--
			-- `a_used': True to use the '-safe' suffix; False otherwise.
		do
			is_safe_suffix_used := a_used
		ensure
			is_safe_suffix_used_set: is_safe_suffix_used = a_used
		end

feature -- Basic operations

	convert_system (a_system: CONF_SYSTEM)
			-- <Precursor>
		local
			l_target: detachable CONF_TARGET
		do
			l_target := a_system.library_target
			Precursor (a_system)
			if is_safe_suffix_used then
				a_system.set_name (file_helpers.safe_file_name (a_system.name))
				if l_target /= Void then
					a_system.set_library_target (l_target)
				end
			end
		end

feature {NONE} -- Basic operations

	convert_void_safe_target (a_target: CONF_TARGET)
			-- <Precursor>
		do
			Precursor (a_target)
			if is_safe_suffix_used then
				a_target.set_name (file_helpers.safe_file_name (a_target.name))
			end
		end

	convert_void_safe_options (a_options: CONF_OPTION)
			-- <Precursor>
		local
			l_void_choice: CONF_VALUE_CHOICE
		do
				-- Conditionally set to avoid polluting the configuration file with defaults.
			a_options.unset_full_class_checking
			if not a_options.is_full_class_checking then
				a_options.set_full_class_checking (True)
			end
			a_options.unset_is_attached_by_default
			if not a_options.is_attached_by_default then
				a_options.set_is_attached_by_default (True)
			end
			l_void_choice := a_options.void_safety
			l_void_choice.unset
			if l_void_choice.index /= {CONF_OPTION}.void_safety_index_all then
				l_void_choice.put_index ({CONF_OPTION}.void_safety_index_all)
			end
		end

	convert_void_safe_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			l_new_path: STRING
		do
			if is_safe_suffix_used then
				if attached {CONF_FILE_LOCATION} a_library.location as l_location then
						-- Set the new path.
					l_new_path := file_helpers.safe_file_name (l_location.original_path)
					l_location.set_full_path (l_new_path)
				end
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
