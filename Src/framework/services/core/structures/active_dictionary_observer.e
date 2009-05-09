note
	description: "[
		An observer for events implemented on a {ACTIVE_DICTIONARY_I} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_DICTIONARY_OBSERVER [G, K -> HASHABLE]

inherit
	EVENT_OBSERVER_I

feature {ACTIVE_DICTIONARY_I} -- Event handlers

	on_dictionary_item_extended (a_dictionary: ACTIVE_DICTIONARY_I [G, K]; a_item: G; a_key: K)
			-- Called when an item was added to an active dictionary {ACTIVE_DICTIONARY_I}.
			--
			-- `a_dictionary': A dictionary that raised the event.
			-- `a_item'      : The object item added to the dictionary.
			-- `a_key'       : An associated key used when extending the dictionary object.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_dictionary_attached: a_dictionary /= Void
			a_dictionary_is_interface_usable: a_dictionary.is_interface_usable
			a_item_attached: a_item /= Void
			is_interface_usable: attached {USABLE_I} a_item as l_usable implies l_usable.is_interface_usable
			a_key_attached: a_key /= Void
			is_interface_usable: attached {USABLE_I} a_key as l_usable implies l_usable.is_interface_usable
		do
		end

	on_dictionary_item_changed (a_dictionary: ACTIVE_DICTIONARY_I [G, K]; a_item: G; a_old_item: G; a_key: K)
			-- Called when an item was changed in the active dictionary {ACTIVE_DICTIONARY_I}.
			--
			-- `a_dictionary': A dictionary that raised the event.
			-- `a_item'      : The changed-to object item in the dictionary.
			-- `a_old_item'  : The changed-from object item replaced in the dictionary.
			-- `a_key'       : An associated key used when changing the dictionary object.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_dictionary_attached: a_dictionary /= Void
			a_dictionary_is_interface_usable: a_dictionary.is_interface_usable
			a_item_attached: a_item /= Void
			is_interface_usable: attached {USABLE_I} a_item as l_usable implies l_usable.is_interface_usable
			a_old_item_attached: a_old_item /= Void
			a_key_attached: a_key /= Void
			is_interface_usable: attached {USABLE_I} a_key as l_usable implies l_usable.is_interface_usable
		do
		end

	on_dictionary_item_pruned (a_dictionary: ACTIVE_DICTIONARY_I [G, K]; a_item: G; a_key: K)
			-- Called when an item was removed from an active dictionary {ACTIVE_DICTIONARY_I}.
			--
			-- `a_dictionary': A dictionary that raised the event.
			-- `a_item'      : The object item removed from the dictionary.
			-- `a_key'       : An associated key used when removing the dictionary object.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_dictionary_attached: a_dictionary /= Void
			a_item_attached: a_item /= Void
			a_key_attached: a_key /= Void
		do
		end

;note
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

end
