indexing
	description: "Flags used to create instance of COR_RUNTIME_HOST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLR_HOST_STARTUP_FLAGS

feature -- Access

	concurrent_gc: INTEGER is 0x1
			-- Specifies that concurrent garbage collection should be used.
			-- Note: If the caller asks for the server build and concurrent
			-- garbage collection on a single-processor machine, the workstation
			-- build and non-concurrent garbage collection is run instead.

	single_domain: INTEGER is 0x2
			-- No assemblies are loaded as domain-neutral.

	multi_domain: INTEGER is 0x4
			-- All assemblies are loaded as domain-neutral.

	multi_domain_host: INTEGER is 0x6
			-- All strong-named assemblies are loaded as domain-neutral.

	safemode: INTEGER is 0x10
			-- Specifies that the exact version of the common language
			-- runtime passed will be loaded. The shim does not evaluate
			-- policy to determine the latest compatible version.

	setpreference: INTEGER is 0x100
			-- ???

feature -- Mask

	optimization_mask: INTEGER is 0x6;
			-- Mask for single_domain, multi_domain and multi_domain_host.

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

end -- class CLR_HOST_STARTUP_FLAGS
