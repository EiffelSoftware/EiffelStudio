note
	description: "EIS storage oberserver manager"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_STORAGE_OBSERVER_MANAGER

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create {attached ARRAYED_LIST [ES_EIS_STORAGE_OBSERVER]} observer_list.make (3)
		end

feature -- Element change

	add_observer (a_observer: ES_EIS_STORAGE_OBSERVER)
			-- Add an observer to be managed.
		require
			a_observer_not_void: a_observer /= Void
		do
			observer_list.extend (a_observer)
		end

	remove_observer (a_observer: ES_EIS_STORAGE_OBSERVER)
			-- Remove an observer from management.
		require
			a_observer_not_void: a_observer /= Void
		do
			observer_list.prune_all (a_observer)
		end

feature {NONE} -- Events

	on_tag_extended (a_tag: STRING_32)
			-- Notify observers that `a_tag' has been added to the storage
		require
			a_tag_not_void: a_tag /= Void
		do
			across
				observer_list as l_c
			loop
				l_c.item.on_tag_added (a_tag)
			end
		end

	on_tag_removed (a_tag: attached STRING_32)
			-- Notify observers that `a_tag' has been removed from the storage
		require
			a_tag_not_void: a_tag /= Void
		do
			across
				observer_list as l_c
			loop
				l_c.item.on_tag_removed (a_tag)
			end
		end

	on_entry_registered (a_entry: EIS_ENTRY; a_component_id: STRING)
			-- Notify observers that `a_entry' has been registered.
		require
			a_entry_not_void: a_entry /= Void
			a_component_id_not_void: a_component_id /= Void
		do
			across
				observer_list as l_c
			loop
				l_c.item.on_entry_registered (a_entry, a_component_id)
			end
		end

	on_entry_deregistered (a_entry: EIS_ENTRY; a_component_id: STRING)
			-- Notify observers that `a_entry' has been deregistered.
		require
			a_entry_not_void: a_entry /= Void
			a_component_id_not_void: a_component_id /= Void
		do
			across
				observer_list as l_c
			loop
				l_c.item.on_entry_deregistered (a_entry, a_component_id)
			end
		end

feature {NONE} -- Access

	observer_list: ARRAYED_LIST [ES_EIS_STORAGE_OBSERVER];
			-- Observer list

invariant
	observer_list_not_void: observer_list /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
