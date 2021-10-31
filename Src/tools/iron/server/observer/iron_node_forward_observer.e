note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_FORWARD_OBSERVER

inherit
	IRON_NODE_OBSERVER

feature {NONE} -- Observers

	observers: detachable ARRAYED_LIST [IRON_NODE_OBSERVER]

feature -- Observers: User events

	on_user_event (a_user: IRON_NODE_USER; a_title: READABLE_STRING_32; a_message: READABLE_STRING_32)
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.on_user_event (a_user, a_title, a_message)
				end
			end
		end

	on_user_updated (u: IRON_NODE_USER; flag_is_new: BOOLEAN)
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.on_user_updated (u, flag_is_new)
				end
			end
		end

feature -- Observers: Package events

	on_package_updated (p: IRON_NODE_PACKAGE; flag_is_new: BOOLEAN)
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.on_package_updated (p, flag_is_new)
				end
			end
		end

	on_version_package_updated  (p: IRON_NODE_VERSION_PACKAGE; flag_is_new: BOOLEAN)
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.on_version_package_updated (p, flag_is_new)
				end
			end
		end

	on_version_package_downloaded (p: IRON_NODE_VERSION_PACKAGE)
			-- <Precursor>
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.on_version_package_downloaded (p)
				end
			end
		end

feature -- Observers

	register_observer (o: IRON_NODE_OBSERVER)
		local
			obs: like observers
		do
			obs := observers
			if obs = Void then
				create obs.make (1)
				observers := obs
			end
			obs.force (o)
		end

	unregister_observer (o: IRON_NODE_OBSERVER)
		local
			obs: like observers
		do
			obs := observers
			if obs /= Void then
				obs.prune_all (o)
				if obs.is_empty then
					observers := Void
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
