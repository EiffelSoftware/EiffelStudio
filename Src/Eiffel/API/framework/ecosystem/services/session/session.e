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

	EVENT_OBSERVER_CONNECTION [!SESSION_EVENT_OBSERVER]
		redefine
			safe_dispose
		end

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
			create value_changed_event
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

	safe_dispose (a_disposing: BOOLEAN)
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		do
			Precursor {EVENT_OBSERVER_CONNECTION} (a_disposing)

			if a_disposing then
				if is_dirty and then manager.is_interface_usable then
					manager.store (Current)
				end
				data.wipe_out
				value_changed_event.dispose
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

feature {SESSION_MANAGER_S, SESSION_I} -- Access

	extension_name: ?STRING_8 assign set_extension_name
			-- Optional extension name for specialized categories

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
			l_old_value: ANY
		do
			l_old_value := value (a_id)
			if l_old_value /= a_value then
				if {l_old_data: !SESSION_DATA_I} l_old_value then
						-- Remove current session as the owner of the data
					l_old_data.set_session (Void)
				end

				if a_value /= Void then
					data.force (box_value (a_value), a_id)

					if {l_data: !SESSION_DATA_I} a_value and then l_data.session /= Current then
							-- Set current session as owner of the data
						l_data.set_session (Current)
					end
				else
						-- The value is Void so it should be removed.
					data.remove (a_id)
				end
				if not equal (l_old_value, a_value) then
						-- The two values are considered the same so do not publish the changed event
					value_changed_event.publish ([Current, a_id])
					is_dirty := True
				end
			end
		end

feature {SESSION_MANAGER_S, SESSION_I} -- Element change

	set_extension_name (a_name: like extension_name)
			-- <Precursor>
		do
			if a_name /= Void then
				extension_name := a_name.twin
			else
				extension_name := Void
			end
		end

feature {SESSION_MANAGER_S} -- Element change

	set_session_object (a_object: like session_object)
			-- <Precursor>
		local
			l_old_data: like data
			l_data: like data
			l_cursor: DS_HASH_TABLE_CURSOR [ANY, STRING_8]
			l_value: ANY
			l_old_value: ANY
			l_id: STRING_8
			l_change_events: like value_changed_event
		do
			l_old_data := data

			l_data ?= a_object
			check
				l_data_attached: l_data /= Void
			end

			if l_data /= Void then
				l_change_events := value_changed_event
				data := l_data.twin

				l_data.do_all (agent (a_ia_value: ANY)
						-- Set session as owner on new, loaded data.
					do
						if {l_session_data: !SESSION_DATA_I} a_ia_value then
							l_session_data.set_session (Current)
						end
					end)

				if l_old_data.is_empty then
						-- Notify subscribers of all new changes
					l_cursor := l_data.new_cursor
					from l_cursor.start until l_cursor.after loop
						l_change_events.publish ([Current, l_cursor.key])
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
								l_change_events.publish ([Current, l_id])
							end

								-- Remove old data so we can publish a events for removed data
							l_old_data.remove (l_id)
						else
								-- The value changed because the old data did not have the current session item.
							l_change_events.publish ([Current, l_id])
						end
						l_cursor.forth
					end

						-- Publish events for removed data
					l_cursor := l_old_data.new_cursor
					from l_cursor.start until l_cursor.after loop
						if {l_session_data: !SESSION_DATA_I} l_cursor.item then
								-- Remove session as owner of the data
							l_session_data.set_session (Void)
						end
						l_change_events.publish ([Current, l_cursor.key])
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
					-- Supporting basic types; {STRING_GENERAL}, reference types inheriting {SESSION_DATA_I} or other type wrapped in a {CELL} (for expanded)
				Result := l_codes.has (l_id) or else
					{l_string: !STRING_GENERAL} a_value or else
					{l_session_data: !SESSION_DATA_I} a_value or else
					({TUPLE}) #? a_value /= Void or else -- TUPLE cannot be used with explict attachment mark (6.1.7.1179)
					{l_cell: !CELL [ANY]} a_value or else
					{l_array: !ARRAY [ANY]} a_value
			end
		end

feature -- Status report

	is_dirty: BOOLEAN
			-- Indicates if the session has modifications

	is_per_project: BOOLEAN
			-- Indicates if the session is a per-project session object

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

feature {SESSION_DATA_I, SESSION_I} -- Basic operations

	notify_value_changed (a_value: !SESSION_DATA_I)
			-- Used by complex session data objects to notify the session that an inner value has changed.
			--
			-- `a_value': The changed session data value.
		local
			l_cursor: DS_HASH_TABLE_CURSOR [ANY, STRING_8]
		do
				-- Locate value
			l_cursor := data.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_value)
			if not l_cursor.after then
					-- Post notification
				is_dirty := True
				value_changed_event.publish ([Current, l_cursor.key])
			end
		end

feature -- Events

	value_changed_event: EVENT_TYPE [TUPLE [session: SESSION_I; id: STRING_8]]
			-- Events fired when a value, indexed by an id, in the session object changes.
			--
			-- `session': The session where the change occured.
			-- `id': The session data identifier index that the value changed for

feature {SESSION_MANAGER_S} -- Action Handlers

	on_begin_store
			-- Called to notify the session that a store is about to take place.
		do
			data.do_all (agent (a_value: ANY)
					-- Iterate the values and notify any session data of commencing storage.
				do
					if {l_data: !SESSION_DATA_I} a_value and {l_session: !SESSION_I} Current then
						l_data.set_session (Void)
						l_data.on_begin_store (l_session)
					end
				end)
		end

	on_end_store
			-- Called to notify the session that a store is complete.
		do
			data.do_all (agent (a_value: ANY)
					-- Iterate the values and notify any session data of commencing storage.
				require
					a_value_attached: a_value /= Void
				do
					if {l_data: !SESSION_DATA_I} a_value then
						l_data.set_session (Current)
						l_data.on_end_store
					end
				end)
		end

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
			if a_value /= Void then
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

	frozen type_code_of_type (a_type: TYPE [ANY]): INTEGER
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
	value_changed_events_attached: value_changed_event /= Void

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
