indexing
	description: "[
		A specialized stonable tool shim for persisting and resurecting set stones.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_PERSISTABLE_STONABLE_TOOL [G -> ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_WIDGET]]

inherit
	ES_STONABLE_TOOL [G]
		redefine
			initialize,
			internal_recycle,
			set_stone,
			on_tool_instantiated
		end

	SESSION_EVENT_OBSERVER
		undefine
			out
		redefine
			on_session_value_changed
		end

--inherit {NONE}
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			out
		end

feature {NONE} -- Initialization

	initialize
			-- Called when Current has been sited
		do
			Precursor {ES_STONABLE_TOOL}
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		local
			l_session: like internal_stone_session
		do
			l_session := internal_stone_session
			if l_session /= Void and then l_session.is_interface_usable and then l_session.is_connected (Current) then
					-- Disconnect session observer.
				l_session.disconnect_events (Current)
			end

			Precursor {ES_STONABLE_TOOL}
		end

feature {NONE} -- Access

	stone_session: ?SESSION_I
			-- The session data object used to store and retrieve stone information
		require
			is_interface_usable: is_interface_usable
			service_available: session_manager.is_service_available
		do
			Result := internal_stone_session
			if Result = Void then
				Result ?= session_manager.service.retrieve_per_window (window, True)
				internal_stone_session := Result
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature -- Element change

	set_stone (a_stone: like stone)
			-- <Precursor>
		local
			l_old_stone: like stone
			l_old_is_processing_persistance: like is_processing_persistance
		do
			l_old_stone := stone

			Precursor {ES_STONABLE_TOOL} (a_stone)

			if not is_processing_persistance and then l_old_stone /= stone and then is_stone_persistable then
					-- Store changed stone in the session.
				if {l_session: !like stone_session} stone_session then
					l_old_is_processing_persistance := is_processing_persistance
					is_processing_persistance := True

					persist_stone (l_session, stone)
					l_session.value_changed_event.perform_suspended_action (agent (a_ia_session: !like stone_session; a_ia_store: BOOLEAN)
							-- HACK: Using an inline agents to circumvent a compiled bug with agent Tuple Boolean conversion with a target type ANY.
						do
							a_ia_session.set_value (a_ia_store, tool_session_id (stone_session_id))
						end (l_session, stone /= Void))

					is_processing_persistance := l_old_is_processing_persistance
				end
			end
		rescue
			is_processing_persistance := l_old_is_processing_persistance
		end

feature {NONE} -- Status report

	is_stone_persistable: BOOLEAN
			-- Indicates if the set stone information is persisted between projects
		require
			is_interface_usable: is_interface_usable
		do
			Result := session_manager.is_service_available and then stone_session /= Void
		ensure
			service_available: Result implies session_manager.is_service_available
			stone_session_attached: Result implies stone_session /= Void
		end

	is_processing_persistance: BOOLEAN
			-- Indicates if stone persistance is currently being processed

feature -- Query

	frozen tool_session_id (a_id: !STRING): !STRING
			-- A tool's stone session identifier.
			--
			-- `a_id': Base ID for a tool session ID.
			-- `Result': A tool's session id.
		require
			not_a_id_is_empty: not a_id.is_empty
		local
			l_count, i: INTEGER
			l_result: STRING
		do
			l_count := a_id.count
			i := a_id.last_index_of ('.', l_count)
			if i > 1 and i < l_count then
				l_result := a_id.substring (1, i - 1) + "." + generating_type.as_lower + "." + a_id.substring (i + 1, l_count)
			else
				l_result := a_id + "." + generating_type.as_lower
			end
			check l_result /= Void end
			Result := l_result
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Helpers

	frozen session_manager: !SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to session manager service.
		once
			check is_interface_usable: is_interface_usable end
			create Result
		end

	frozen persistance_utilities: !ES_PERSISTABLE_STONE_UTILITIES
			-- Access to persistance utilties for stone persistance
		do
			if {l_utils: like persistance_utilities} internal_persistance_utilities then
				Result := l_utils
			else
				Result := create_persistance_utilities
				internal_persistance_utilities := Result
			end
		end

feature {NONE} -- Basic operations

	resurrect_stone (a_session: !SESSION_I): ?STONE
			-- Resurrects a stone from previously stored session data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `Result': A applicable stone for Current of Void if no applicable stone could be resurrected.
		require
			is_interface_usable: is_interface_usable
			is_stone_persistable: is_stone_persistable
			a_session_is_interface_usable: a_session.is_interface_usable
		do
			if workbench.system_defined and then workbench.is_in_stable_state then
				Result := persistance_utilities.resurrect_stone (a_session, tool_session_id (stone_session_id))
				if Result /= Void and then not is_stone_usable (Result) then
					Result := Void
				end
			end
		ensure
			result_is_stone_usable: Result /= Void implies is_stone_usable (Result)
		end

	persist_stone (a_session: !SESSION_I; a_stone: ?STONE)
			-- Stores a stone's reference information in the given session, for later resurrection.
			-- Note: Do *not* store the stone object in the session! This will include too much data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_stone': The stone to persist information about, in the supplied session.
		require
			is_interface_usable: is_interface_usable
			is_stone_persistable: is_stone_persistable
			a_session_is_interface_usable: a_session.is_interface_usable
			a_stone_is_stone_usable: a_stone /= Void implies is_stone_usable (a_stone)
		do
			if workbench.system_defined and then workbench.is_in_stable_state then
				persistance_utilities.persist_stone (a_session, tool_session_id (stone_session_id), a_stone)
			end
		end

feature -- Action handlers

	on_tool_instantiated
			-- <Precursor>
		local
			l_stone: ?STONE
		do
			Precursor {ES_STONABLE_TOOL}

			if is_stone_persistable and then stone = Void then
					-- Store stone in the project window session
				if {l_session: !like stone_session} stone_session then
						-- Resurrect stone and set if necessary.
					l_stone := resurrect_stone (l_session)
					if l_stone /= Void and l_stone /= stone then
						set_stone (l_stone)
					end

						-- Register to recieve notification of changes to the session value.
					l_session.connect_events (Current)
				end
			end
		end

feature {SESSION_I} -- Event handlers

	on_session_value_changed (a_session: SESSION_I; a_id: STRING_8)
			-- <Precursor>
		local
			l_stone: ?STONE
		do
			Precursor {SESSION_EVENT_OBSERVER} (a_session, a_id)

			if not is_processing_persistance and then a_id.is_equal (tool_session_id (stone_session_id)) then
					-- The session value changed
				if {l_session: SESSION_I} a_session then
						-- Resurrect stone and set.
					l_stone := resurrect_stone (l_session)
					if l_stone /= stone and then (l_stone = Void or else is_stone_usable (l_stone)) then
							-- Set persistance state, so the stone is no re-persisted.
						is_processing_persistance := True
						set_stone_with_query (l_stone)
						is_processing_persistance := False
					end
				end
			end
		ensure then
			is_processing_persistance_unchanged: is_processing_persistance = old is_processing_persistance
		end

feature {NONE} -- Factory

	create_persistance_utilities: !ES_PERSISTABLE_STONE_UTILITIES
			-- Creates a stone persistance utility.
		do
			create Result.make (False)
		ensure
			not_result_raise_events: not Result.raise_events
		end

feature -- Constants

	stone_session_id: !STRING = "com.eiffel.stone"

feature {NONE} -- Internal implementation cache

	internal_stone_session: ?SESSION_I
			-- Cached version of `stone_session'
			-- Note: Do not use directly!

	internal_persistance_utilities: ?ES_PERSISTABLE_STONE_UTILITIES
			-- Cached version of `persistance_utilities'
			-- Note: Do not use directly!

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
