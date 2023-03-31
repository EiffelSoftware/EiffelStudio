note
	description: "Precompiles are almost the same as libraries, except that on the first build they load the date as initial point for the incremental compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PRECOMPILE

inherit
	CONF_LIBRARY
		redefine
			is_precompile,
			process
		end

create {CONF_PARSE_FACTORY}
	make

feature -- Status

	is_precompile: BOOLEAN
			-- Is this a precompile?
		once
			Result := True
		end

feature -- Access

	eifgens_location: detachable CONF_DIRECTORY_LOCATION
			-- Location of the eifgens to use.

feature {CONF_ACCESS} -- Update

	set_eifgens_location (a_location: like eifgens_location)
			-- Set `eifgens_location' to `a_location'.
		do
			eifgens_location := a_location
		ensure
			eifgens_location_set: eifgens_location = a_location
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
			a_visitor.process_precompile (Current)
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
