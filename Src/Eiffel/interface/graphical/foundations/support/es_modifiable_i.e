indexing
	description: "[
		An ESF interface for implementing "dirty" state preservation on objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_MODIFIABLE_I

inherit
	USABLE_I

feature -- Status report

	is_dirty: BOOLEAN
			-- Indicates if Current contains uncommited modifications.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {NONE} -- Status report

	is_performing_save_modified_operation: BOOLEAN
			-- Indicates if a query-save-modification call currently being invoked

feature {NONE} -- Status setting

	set_is_dirty (a_dirty: like is_dirty)
			-- Sets Current's dirty state.
			--
			-- `a_dirty': True to change Current to be dirty, False to indicate its clean.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			is_dirty_set: is_dirty = a_dirty
		end

feature -- Query

	query_save_modified: BOOLEAN
			-- Performs a query, generally involving some user interaction, determining if an action can be performed
			-- given a dirty state.
			--
			--| Note: Implemented to perform user-interaction.
		require
			is_interface_usable: is_interface_usable
			is_dirty: is_dirty
		do
			Result := True
		ensure
			is_performing_save_modified_operation_unchanged: is_performing_save_modified_operation = old is_performing_save_modified_operation
		end

feature -- Basic operations

	perform_query_save_modified (a_action: !PROCEDURE [ANY, TUPLE])
			-- Performs an action, on the condition and modifications are saved or discarded.
			--
			-- `a_action': A protected action to perform, which will only be executed if Current is unmodified for the user
			--             chooses to continue, through an implementation of `query_save_modified'.
		require
			is_interface_usable: is_interface_usable
		local
			l_performing: like is_performing_save_modified_operation
		do
			l_performing := is_performing_save_modified_operation
			if l_performing or else (not is_dirty or else query_save_modified) then
				is_performing_save_modified_operation := True
				a_action.call (Void)
				is_performing_save_modified_operation := l_performing
			end
		ensure
			is_performing_save_modified_operation_unchanged: is_performing_save_modified_operation = old is_performing_save_modified_operation
		rescue
			is_performing_save_modified_operation := l_performing
		end

feature -- Events

	dirty_state_change_event: !EVENT_TYPE [TUPLE [is_dirty: BOOLEAN]]
			-- Actions called when the dirty state chages.
			--
			-- 'is_dirty': Reflects the dirty state.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
