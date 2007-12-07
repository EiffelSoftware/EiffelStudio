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
			is_valid_site: a_site /= Void implies is_valid_site (a_site)
		local
			l_entities: like siteable_entities
		do
			site := a_site
			if a_site /= Void then
				on_sited
			end

			l_entities := siteable_entities
			if not l_entities.is_empty then
				l_entities.do_all (agent (a_item: like Current)
					do
						if a_item.is_valid_site (site) then
							a_item.set_site (site)
						end
					end)
			end
		ensure
			site_set: site = a_site
		end

feature {NONE} -- Initialization

	on_sited
			-- Called when Current has been sited
		require
			site_attached: site /= Void
		do
		end

feature -- Access

	site: G assign set_site
			-- Access to sited object instance (Void if unsited)

feature {NONE} -- Access

	siteable_entities: ARRAYED_LIST [SITE [G]]
			-- List of siteable entities to automatically site when `Current' is sited
		do
			create Result.make (0)
		ensure
			result_attached: Result /= Void
		end

feature -- Query

	is_valid_site (a_site: ANY): BOOLEAN
			-- Determines if `a_site' is a valid site object
		local
			l_ot: G
		do
			l_ot ?= a_site
			Result := l_ot /= Void
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
