indexing
	description: "[
		A collection of managed session data, bound to a IDE/project context.
		
		The actual session handling implementation as described by the interface {SESSION_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SESSION

inherit
	SESSION_I

	SAFE_DISPOSABLE

create {SESSION_MANAGER_S}
	make,
	make_per_window

feature {NONE} -- Initialization

	make (a_per_project: BOOLEAN; a_manager: like manager)
			-- Initialize a global session
			--
			-- `a_per_project': True to initialize a per-project session.
			-- `a_manager': Session manager that owns Current.
		require
			a_manager_attached: a_manager /= Void
			a_manager_is_interface_usable: a_manager.is_interface_usable
		do
			create data.make_default
			create value_changed_events
			is_per_project := a_per_project
			manager := a_manager
		ensure
			is_per_project_set: is_per_project = a_per_project
			manager_set: manager = a_manager
		end

	make_per_window (a_per_project: BOOLEAN; a_window: EB_DEVELOPMENT_WINDOW; a_manager: like manager)
			-- Initialize a session bound to a window.
			--
			-- `a_per_project': True to initialize a per-project session.
			-- `a_window': Window to initialize a per-window session for.
			-- `a_manager': Session manager that owns Current.
		require
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
			a_manager_attached: a_manager /= Void
			a_manager_is_interface_usable: a_manager.is_interface_usable
		do
			make (a_per_project, a_manager)
			window_id := a_window.window_id
		ensure
			is_per_project_set: is_per_project = a_per_project
			is_per_window: is_per_window
			manager_set: manager = a_manager
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		do
			if a_disposing then
				if is_dirty and then manager.is_interface_usable then
					manager.store (Current)
				end
				data.wipe_out
				value_changed_events.dispose
			end
		end

feature -- Access

	kind: UUID
			-- Kind of session. See {SESSION_KINDS} for all representations.
		local
			l_kinds: SESSION_KINDS
		do
			create l_kinds
			if is_per_project then
				if is_per_window then
					Result := l_kinds.project_window
				else
					Result := l_kinds.project
				end
			else
				if is_per_window then
					Result := l_kinds.window
				else
					Result := l_kinds.environment
				end
			end
		end

	window_id: NATURAL_32
			-- Window identifier the session is attached to.

	manager: SESSION_MANAGER_S
			-- Session manager current belongs to

feature {SESSION_MANAGER_S} -- Access

	frozen session_object: ANY assign set_session_object
			-- Session object, used during serialization of data
		do
			Result := data
		end

feature {NONE} -- Access

	data: DS_HASH_TABLE [ANY, STRING_8]
			-- Table containing session data
			-- Key: Session data id
			-- Value: Session data

feature -- Element change

	set_value (a_value: ANY; a_id: STRING_8)
			-- Sets a piece of sessions data.
			-- Note: Values cannot be of type {CELL} because they interfer with boxing and unboxing of expanded values,
			--       required to ensure the data is serialized/deserialized correctly.
			--
			-- `a_value': Data to set in sessions, or Void to remove it.
			-- `a_id': An id to index and store the session data with.
		local
			l_value: ANY
		do
			l_value := value (a_id)
			if not equal (l_value, a_value) then
				is_dirty := True
				data.force (box_value (a_value), a_id)
				value_changed_events.publish ([a_id, a_value])
			end
		end

feature {SESSION_MANAGER_S} -- Element change

	set_session_object (a_object: like session_object)
			-- Set the session object, used during deserialization.
			-- Note: Implementers should remember to fire the change events for the set properties
			--
			-- `a_object': The new session object to set.
		local
			l_old_data: like data
			l_data: like data
			l_cursor: DS_HASH_TABLE_CURSOR [ANY, STRING_8]
			l_value: ANY
			l_old_value: ANY
			l_id: STRING_8
			l_change_events: like value_changed_events
		do
			l_old_data := data

			l_data ?= a_object
			check
				l_data_attached: l_data /= Void
			end

			if l_data /= Void then
				l_change_events := value_changed_events
				data := l_data.twin

				if l_old_data.is_empty then
						-- Notify subscribers of all new changes
					l_cursor := l_data.new_cursor
					from l_cursor.start until l_cursor.after loop
						l_change_events.publish ([l_cursor.key, unbox_value (l_cursor.item)])
						l_cursor.forth
					end
				else
						-- Detects changes and publishes the events
					l_cursor := l_data.new_cursor
					from l_cursor.start until l_cursor.after loop
						l_id := l_cursor.key
						l_value := unbox_value (l_cursor.item)
						if l_old_data.has (l_id) then
							l_old_value := unbox_value (l_old_data.item (l_id))
							if not equal (l_value, l_old_value) then
									-- The value changed
								l_change_events.publish ([l_id, l_value])
							end

								-- Remove old data so we can publish a events for removed data
							l_old_data.remove (l_id)
						end
						l_cursor.forth
					end

						-- Publish events for removed data
					l_cursor := l_old_data.new_cursor
					from l_cursor.start until l_cursor.after loop
						l_change_events.publish ([l_cursor.key, Void])
						l_cursor.forth
					end
				end
			end
		end

feature -- Query

	value (a_id: STRING_8): ANY assign set_value
			-- Retrieve a piece of sessions data, indexed by an ID.
			--
			-- `a_id': An id to retrieve session data for
		local
			l_data: like data
		do
			l_data := data
			if l_data.has (a_id) then
				Result := unbox_value (l_data.item (a_id))
			end
		end

	value_or_default (a_id: STRING_8; a_default_value: ANY): ANY
			-- Retrieve a piece of sessions data, indexed by an ID.
			--
			-- `a_id': An id to retrieve session data for
		local
			l_data: like data
		do
			l_data := data
			if l_data.has (a_id) then
				Result := unbox_value (l_data.item (a_id))
			else
				Result := a_default_value
			end
		ensure then
			default_value_set: not data.has (a_id) implies Result = a_default_value
		end

	is_valid_session_value (a_value: ANY): BOOLEAN
			-- Determines if `a_valud' is a valid session value
		local
			l_internal: like internal
			l_codes: like type_codes
			l_id: INTEGER
		do
			Result := a_value = Void
			if not Result then
				l_codes := type_codes
				l_internal := internal
				l_id := l_internal.dynamic_type (a_value)
					-- Supporting basic types, reference types inheriting {SESSION_DATA_I} or other type wrapped in a {CELL} (for expanded)
				Result := l_codes.has (l_id) or else {l_session_data: !SESSION_DATA_I} a_value or else {l_cell_data: !CELL [ANY]} a_value
			end
		end

feature -- Status report

	is_dirty: BOOLEAN
			-- Indicates if the session has modifications

	is_per_project: BOOLEAN
			-- Indicates if the session is a per-project session object

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := not is_zombie
		end

feature {SESSION_MANAGER_S} -- Status setting

	reset_is_dirty
			-- Resets dirty state of session
		do
			is_dirty := False
		end

feature {NONE} -- Helpers

	frozen internal: INTERNAL
			-- Shared access to an instance of {INTERNAL}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Events

	value_changed_events: EVENT_TYPE [TUPLE [a_id: STRING_8; a_value: ANY]]
			-- Events fired when a value, indexed by an id, in the session object changes.

feature {NONE} -- Conversion

	box_value (a_value: ANY): ANY
			-- Boxes a a value so built-in expanded types can be corrected serialized/deserialized.
			--
			-- `a_value': A value to box.
			-- `Result': A boxed (reference encapsulated) reference to `a_value' or `a_value' is no boxing is required.
		local
			l_internal: like internal
			l_codes: like type_codes
			l_id: INTEGER
			l_cell: CELL [ANY]
		do
			l_codes := type_codes
			l_internal := internal
			l_id := l_internal.dynamic_type (a_value)
			if l_codes.has (l_id) then
				inspect l_codes.item (l_id)
				when {INTERNAL}.boolean_type then
					create {CELL [BOOLEAN]} Result.put (({BOOLEAN}) #? a_value)
				when {INTERNAL}.character_8_type then
					create {CELL [CHARACTER_8]} Result.put (({CHARACTER_8}) #? a_value)
				when {INTERNAL}.character_32_type then
					create {CELL [CHARACTER_32]} Result.put (({CHARACTER_32}) #? a_value)
				when {INTERNAL}.integer_8_type then
					create {CELL [INTEGER_8]} Result.put (({INTEGER_8}) #? a_value)
				when {INTERNAL}.integer_16_type then
					create {CELL [INTEGER_16]} Result.put (({INTEGER_16}) #? a_value)
				when {INTERNAL}.integer_32_type then
					create {CELL [INTEGER_32]} Result.put (({INTEGER_32}) #? a_value)
				when {INTERNAL}.integer_64_type then
					create {CELL [INTEGER_64]} Result.put (({INTEGER_64}) #? a_value)
				when {INTERNAL}.natural_8_type then
					create {CELL [NATURAL_8]} Result.put (({NATURAL_8}) #? a_value)
				when {INTERNAL}.natural_16_type then
					create {CELL [NATURAL_16]} Result.put (({NATURAL_16}) #? a_value)
				when {INTERNAL}.natural_32_type then
					create {CELL [NATURAL_32]} Result.put (({NATURAL_32}) #? a_value)
				when {INTERNAL}.natural_64_type then
					create {CELL [NATURAL_64]} Result.put (({NATURAL_64}) #? a_value)
				when {INTERNAL}.real_32_type then
					create {CELL [REAL_32]} Result.put (({REAL_32}) #? a_value)
				when {INTERNAL}.real_64_type then
					create {CELL [REAL_64]} Result.put (({REAL_64}) #? a_value)
				when {INTERNAL}.pointer_type then
					create {CELL [POINTER]} Result.put (({POINTER}) #? a_value)
				end
			else
				l_cell ?= a_value
				if l_cell /= Void then
						-- Need to box, to ensure unboxing performs correct unboxing. See `unbox_value' implementation
						-- for information.
					create {CELL [CELL [ANY]]} Result.put (l_cell)
				else
					Result := a_value
				end
			end
		ensure
			result_attached: a_value /= Void implies Result /= Void
		end

	unbox_value (a_value: ANY): ANY
			-- Unboxes a value, boxed by `box_value', to it original form.
			--
			-- `a_value': A boxed value, or a possible boxed value.
			-- `Result': The unboxed, orginal form of the passed value or `a_value' if the value was not boxed by `box_value'.
		local
			l_cell: CELL [ANY]
		do
			l_cell ?= a_value
			if l_cell /= Void then
				Result := l_cell.item
			else
				Result := a_value
			end
		end

feature {NONE} -- Conversion type tables

	frozen type_codes: DS_HASH_TABLE [INTEGER, INTEGER]
			-- Table of abstract type codes, indexed by a respective dynamic type id of a built-in expanded type.
		once
			create Result.make (14)
			Result.put_last ({INTERNAL}.boolean_type, type_code_of_type ({BOOLEAN}))
			Result.put_last ({INTERNAL}.character_8_type, type_code_of_type ({CHARACTER_8}))
			Result.put_last ({INTERNAL}.character_32_type, type_code_of_type ({CHARACTER_32}))
			Result.put_last ({INTERNAL}.integer_8_type, type_code_of_type ({INTEGER_8}))
			Result.put_last ({INTERNAL}.integer_16_type, type_code_of_type ({INTEGER_16}))
			Result.put_last ({INTERNAL}.integer_32_type, type_code_of_type ({INTEGER_32}))
			Result.put_last ({INTERNAL}.integer_64_type, type_code_of_type ({INTEGER_64}))
			Result.put_last ({INTERNAL}.natural_8_type, type_code_of_type ({NATURAL_8}))
			Result.put_last ({INTERNAL}.natural_16_type, type_code_of_type ({NATURAL_16}))
			Result.put_last ({INTERNAL}.natural_32_type, type_code_of_type ({NATURAL_32}))
			Result.put_last ({INTERNAL}.natural_64_type, type_code_of_type ({NATURAL_64}))
			Result.put_last ({INTERNAL}.real_32_type, type_code_of_type ({REAL_32}))
			Result.put_last ({INTERNAL}.real_64_type, type_code_of_type ({REAL_64}))
			Result.put_last ({INTERNAL}.pointer_type, type_code_of_type ({POINTER}))
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen type_code_of_type (a_type: TYPE [ANY]): INTEGER is
			-- Retrieves a dynamic type code for a type's type.
			--
			-- `a_type': Type to retrieve a dynamic type id for.
			-- `Result': Dynamic type id of the actualy type's type.
		require
			a_type_attached: a_type /= Void
		do
			Result := internal.generic_dynamic_type (a_type, 1)
		end

invariant
	manager_attached: manager /= Void
	manager_is_zombie: not is_zombie implies manager.is_interface_usable
	data_attached: data /= Void
	value_changed_events_attached: value_changed_events /= Void

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
