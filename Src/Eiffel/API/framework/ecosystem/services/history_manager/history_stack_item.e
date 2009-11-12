note
	description: "[
		Abstract inferface for tools/UI where stones can set and synchronized.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	HISTORY_STACK_ITEM [G -> ANY]

inherit
	HISTORY_STACK_ITEM_I

feature {NONE} -- Initialization

	make (a_data: attached G; a_description: attached like description)
			-- Initializes a history stack item using a piece of data and a description.
			--
			-- `a_data': The history item's context data.
			-- `a_description': A textual description of the history item.
		require
			a_data_is_valid_data: is_valid_data (a_data)
		do
			is_applied := True
			data := a_data
			create {IMMUTABLE_STRING_32} description.make_from_string (a_description)
		ensure
			a_data_set: data = a_data
			a_description_set: description.same_string (a_description)
		end

feature -- Access

	description: attached READABLE_STRING_32
			-- <Precursor>

	data: attached G
			-- <Precursor>

feature -- Status report

	is_applied: BOOLEAN
			-- <Precursor>

	is_valid_data (a_data: attached ANY): BOOLEAN
			-- <Precursor>
		do
			Result := attached {G} a_data as l_data
		ensure then
			result_ensures_conformance: attached {G} a_data as l_result
		end

feature {HISTORY_CONTAINER_I} -- Basic operations

	undo
			-- <Precursor>
		do
			internal_undo
			is_applied := False
		end

	redo
			-- <Precursor>
		do
			internal_redo
			is_applied := True
		end

feature {HISTORY_OWNER_I} -- Basic operations

	apply: detachable HISTORY_STACK_ITEM_I
			-- <Precursor>
		do
			Result := internal_apply
			is_applied := True
		end

feature {NONE} -- Basic operations	

	internal_apply: detachable HISTORY_STACK_ITEM_I
			-- Perform an action to revert to a previous state.
			--
			-- `Result': A redo item or Void
		require
			is_interface_usable: is_interface_usable
			not_is_applied: not is_applied
		deferred
		ensure
			is_applied: is_applied
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			not_result_is_applied: Result /= Void implies not Result.is_applied
		end

	internal_undo
			-- Perform an undo action.
		require
			is_interface_usable: is_interface_usable
			is_applied: is_applied
		deferred
		ensure
			is_applied_unchaged: is_applied = old is_applied
		end

	internal_redo
			-- Perform an redo action.
		require
			is_interface_usable: is_interface_usable
			not_is_applied: not is_applied
		deferred
		ensure
			is_applied_unchaged: is_applied = old is_applied
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
