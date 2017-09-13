note
	description: "Handler for reporting obsolete feature calls according to a currently selected policy."
	date: "$Date$"
	revision: "$Revision$"

class OBSOLETE_CALL_HANDLER

inherit
	COMPILER_EXPORTER
	SHARED_ERROR_HANDLER

feature

	report (obsolete_feature: FEATURE_I; obsolete_class: CLASS_C; current_feature: detachable FEATURE_I; current_class: CLASS_C; location: detachable LOCATION_AS; is_warning_enabled: BOOLEAN)
			-- Report an obsolete feature call warning or error for `obsolete_feature` from `obsolete_class` in `current_feature` of `currect_class` at `location`.
			-- If `current_feature` is `Void`, then the issue is reported in the class invariant.
			-- The flag `is_warning_enabled` tells if the corresponding warning message is allowed. Otherwise (i.e., when it is disabled or not a warning), it is suppressed.
		local
			obsolete_warning: OBS_FEAT_WARN
		do
			if is_warning_enabled then
				create obsolete_warning.make_with_class (current_class)
				if attached current_feature then
					obsolete_warning.set_feature (current_feature)
				end
				obsolete_warning.set_obsolete_class (obsolete_class)
				obsolete_warning.set_obsolete_feature (obsolete_feature)
				if attached location then
					obsolete_warning.set_location (location)
				end
				error_handler.insert_warning (obsolete_warning)
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
