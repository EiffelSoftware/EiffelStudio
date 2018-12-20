note
	description: "A factory that creates GUI components for automatic fixes."

class
	ES_FIX_FACTORY

feature -- Basic operations

	create_component (f: FIX [TEXT_FORMATTER]): detachable ES_FIX
			-- Create a new fix component (if possible) for the given fix `f`.
		do
				-- TODO: Handle other types of fixes by adding a factory class based on a visitor pattern,
				-- so that adding a new fix class does not pass unnoticed.
			if attached {FIX_FEATURE} f as ff then
				create {ES_FIX_FEATURE} Result.make (ff)
			elseif attached {FIX_PARENT} f as fp then
				create {ES_FIX_PARENT} Result.make (fp)
			elseif attached {CA_FIX} f as fc then
				create {ES_CA_FIX_EXECUTOR} Result.make (fc)
			end
		ensure
			instance_free: class
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 2018, Eiffel Software"
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
