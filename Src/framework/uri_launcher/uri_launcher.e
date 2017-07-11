note
	description: "[
		The interface used to launch URIs in the platform's default browser.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	URI_LAUNCHER

inherit
	BRIDGE [URI_LAUNCHER_I]

feature -- Basic operations

	launch (a_uri: READABLE_STRING_GENERAL): BOOLEAN
			-- Launches a URI in the system's default web-browser.
			--
			-- `a_uri' : The URI to launch.
			-- `Result': True if the URI was launched; False otherwise.
		require
			a_uri_attached: a_uri /= Void
			not_a_uri_is_empty: not a_uri.is_empty
		do
			Result := bridge.launch (a_uri.to_string_32)
		end

	launch_with_default_app (a_uri: READABLE_STRING_GENERAL; a_default_app: READABLE_STRING_32): BOOLEAN
			-- Launches a URI in the system's default web-browser, or if that fails, then the supplied
			-- default application.
			--
			-- `a_uri'        : The URI to launch.
			-- `a_default_app': The default application to use in case of system default failure.
			-- `Result'       : True if the URI was launched; False otherwise.
		require
			a_uri_attached: a_uri /= Void
			not_a_uri_is_empty: not a_uri.is_empty
			a_default_app_attached: a_default_app /= Void
			not_a_default_app_is_empty: not a_default_app.is_empty
		do
			Result := bridge.launch_with_default_app (a_uri.to_string_32, a_default_app)
		end

feature {NONE} -- Factory

	new_bridge: attached URI_LAUNCHER_I
			-- <Precursor>
		do
			create {URI_LAUNCHER_IMP} Result
		end

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
