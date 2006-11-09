indexing
	description: "[
		Provides objects with the ability to delay site though a common call siteing mechanism.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SITE [G -> ANY]

feature -- Initialization

	set_site (a_site: like site)
			-- Sites `site' with `a_site'.
		require
			is_valid_site: is_valid_site (a_site)
		do
			site := a_site
		ensure
			site_set: site = a_site
		end

feature -- Access

	site: G
			-- Access to sited object instance (Void if unsited)

feature -- Query

	is_valid_site (a_site: like site): BOOLEAN is
			-- Determines if `a_site' is a valid site object
		local
			l_ot: G
		do
			Result := a_site = Void
			if not Result then
					-- Prevents catcalls
				l_ot ?= a_site
				Result := l_ot /= Void
			end
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

end -- class {SITE}
