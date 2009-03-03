note
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
			-- Sites, or unsites, Current with a site object.
			--
			-- `a_site': The site object to site Current with or Void to unsite.
		require
			is_interface_usable: a_site /= Void implies
				(attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable)
			is_valid_site: a_site /= Void implies is_valid_site (a_site)
			not_is_sited: a_site /= Void implies not is_sited
		local
			l_site: like site
			l_old_site: detachable G
			l_sub_site: detachable SITE [G]
			l_entities: like siteable_entities
			l_cursor: CURSOR
		do
			l_old_site := site
			site := a_site
			if a_site /= Void and l_old_site /= site then
				on_sited
			end

			l_entities := siteable_entities
			if not l_entities.is_empty then
				l_site := site
				l_cursor := l_entities.cursor
				from l_entities.start until l_entities.after loop
					l_sub_site := l_entities.item_for_iteration
					check l_sub_site_attached: l_sub_site /= Void end
					if not l_sub_site.is_sited and then l_sub_site.is_valid_site (l_site) then
						l_sub_site.set_site (l_site)
					end
					l_entities.forth
				end
				l_entities.go_to (l_cursor)
			end
		ensure
			site_set: site = a_site
			siteable_entities_unmoved: siteable_entities.cursor ~ old siteable_entities.cursor
		end

feature {NONE} -- Initialization

	on_sited
			-- Called when Current has been sited with a valid site object.
			-- Note: This is only called when Current is sited with an object, not when Current is sited
			--       with Void.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies
				l_usable.is_interface_usable
			is_sited: is_sited
		do
		end

feature -- Access

	site: detachable G assign set_site
			-- Access to sited object instance (Void if unsited)
			--| Note: Use `set_site' instead of assigning directly in Current!

feature {NONE} -- Access

	siteable_entities: ARRAYED_LIST [SITE [G]]
			-- List of siteable entities to automatically site when Current is sited.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies
				l_usable.is_interface_usable
		do
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature -- Status report

	is_sited: BOOLEAN
			-- Indicates if Current has been sited
		do
			Result := site /= Void
		ensure
			site_attached: Result implies site /= Void
		end

	is_valid_site (a_site: detachable ANY): BOOLEAN
			-- Determines if an object is a valid site object.
			--
			-- `a_site': The site object to determine validity of.
			-- `Result': True if the site object is valid; False otherwise.
		do
			Result := attached {G} a_site
		ensure
			not_a_catcall: attached {G} a_site
		end

note
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

end -- class {SITE}
