note
	description: "Summary description for {SCM_CHANGELIST_COLLECTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CHANGELIST_COLLECTION

inherit
	ITERABLE [SCM_CHANGELIST]

	SCM_CHANGELIST_OBSERVER

	DEBUG_OUTPUT

create
	make

convert
	changelists: {LIST [SCM_CHANGELIST]}

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL; nb: INTEGER)
		do
			create name.make_from_string_general (a_name)
			create changelists.make (nb)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	description: detachable IMMUTABLE_STRING_32

	changelist_count: INTEGER
		do
			Result := changelists.count
		end

	first_changelist: SCM_CHANGELIST
		do
			Result := changelists.first
		end

	count: INTEGER
		do
			across
				changelists as ic
			loop
				Result := Result + ic.item.count
			end
		end

	changelist (a_root_location: SCM_LOCATION): detachable SCM_CHANGELIST
		do
			across
				changelists as ic
			until
				Result /= Void
			loop
				if ic.item.root.same_as (a_root_location) then
					Result := ic.item
				end
			end
		end

	debug_output: STRING_32
		do
			create Result.make_from_string (name)
			Result.append_string_general (" list count=" + changelist_count.out)
			Result.append_string_general (" changes count=" + count.out)
		end

feature -- Element change

	put_changelist (a_chlst: SCM_CHANGELIST)
		do
			changelists.force (a_chlst)
			a_chlst.register_observer (Current)
		end

	remove_changelist (a_chlst: SCM_CHANGELIST)
		do
			changelists.prune_all (a_chlst)
			a_chlst.unregister_observer (Current)
		end

	extend_status (a_root: SCM_LOCATION; a_status: SCM_STATUS)
		local
			lst: like changelist
		do
			lst := changelist (a_root)
			if lst = Void then
				create lst.make_with_location (a_root)
				put_changelist (lst)
			end
			if not lst.has_status (a_status) then
				lst.extend_status (a_status)
			end
		end

	remove_status (a_root: SCM_LOCATION; a_status: SCM_STATUS)
		local
			lst: like changelist
		do
			lst := changelist (a_root)
			if lst /= Void and then lst.has_status (a_status) then
				lst.remove_status (a_status)
			end
		end

	remove_empty_changelists
		do
			from
				changelists.start
			until
				changelists.off
			loop
				if
					attached changelists.item_for_iteration as l_chlist and then
					l_chlist.count = 0
				then
					changelists.remove
					l_chlist.unregister_observer (Current)
				else
					changelists.forth
				end
			end
		end

	wipe_out
		do
			across
				changelists as ic
			loop
				remove_changelist (ic.item)
			end
			check changelist_count = 0 end
		end

	set_description (d: detachable READABLE_STRING_GENERAL)
		do
			if d = Void then
				description := Void
			else
				create description.make_from_string_general (d)
			end
		end

feature -- Events

	observers: detachable ARRAYED_LIST [SCM_CHANGELIST_COLLECTION_OBSERVER]

	register_observer (obs: SCM_CHANGELIST_COLLECTION_OBSERVER)
		local
			lst: like observers
		do
			lst := observers
			if lst = Void then
				create lst.make (1)
				observers := lst
			end
			lst.force (obs)
		end

	unregister_observer (obs: SCM_CHANGELIST_COLLECTION_OBSERVER)
		do
			if attached observers as lst then
				lst.prune_all (obs)
				if lst.is_empty then
					observers := Void
				end
			end
		end

	on_item_removed (a_changelist: SCM_CHANGELIST; a_item: SCM_STATUS)
			-- Item `a_item` was removed from associated `a_changelist`
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_item_removed (a_changelist, a_item)
				end
				if lst.count = 0 then
					remove_changelist (a_changelist)
				end
			end
		end

	on_item_added (a_changelist: SCM_CHANGELIST; a_item: SCM_STATUS)
			-- Item `a_item` was added to associated `a_changelist`
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_item_added (a_changelist, a_item)
				end
			end
		end

	on_changelist_reset (a_changelist: SCM_CHANGELIST)
			-- Associated `a_changelist` was reset.
			-- no more item.
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_changelist_reset (a_changelist)
				end
			end
		end

feature -- Cursor

	new_cursor: ITERATION_CURSOR [SCM_CHANGELIST]
			-- <Precursor>
		do
			Result := changelists.new_cursor
		end

feature {NONE} -- Implementation

	changelists: ARRAYED_LIST [SCM_CHANGELIST]

invariant
note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
