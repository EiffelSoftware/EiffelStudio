indexing
	description: "[
		Utility class for presisting and resurrecting stones from a session.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_PERSISTABLE_STONE_UTILITIES

inherit -- {NONE}
	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_raise: like raise_events)
			-- Initialize a session persistable stone helper.
			--
			-- `a_raise': True to raise value change events when applicable; False otherwise.
			--            See `raise_events' for more details.
		do
			set_raise_events (a_raise)
		ensure
			raise_events_set: raise_events = a_raise
		end

feature {NONE} -- Access

	frozen internal: !INTERNAL
			-- Shared access to an instance of {INTERNAL}
		once
			create Result
		end

feature -- Status report

	raise_events: BOOLEAN assign set_raise_events
			-- Indicates if events are raised during the setting of session data.
			-- Note: Typically this is not advisable because of performance reasons.

feature -- Status setting

	set_raise_events (a_raise: like raise_events)
			-- Sets status indicating if events should be raised when modifying a session.
		do
			raise_events := a_raise
		ensure
			raise_events_set: raise_events = a_raise
		end

feature {NONE} -- Query

	frozen session_id (a_base_id: !STRING; a_id: !STRING;): !STRING
			-- A tool's stone session identifier.
			--
			-- `a_id': Base ID for a tool session ID.
			-- `Result': A tool's session id.
		require
			not_a_base_id_is_empty: not a_base_id.is_empty
			not_a_id_is_empty: not a_id.is_empty
		do
			create Result.make (a_base_id.count + a_id.count + 1)
			Result.append (a_base_id)
			Result.append_character ('.')
			Result.append (a_id)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	frozen resurrect_stone (a_session: !SESSION_I; a_base_id: !STRING): ?STONE
			-- Resurrects a stone from previously persisted session data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to build a session id for the stone.
			-- `Result': A stone or Void if no stone could be resurrected.
		require
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		local
			l_type_name: ?STRING
			l_type_id: INTEGER
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				l_type_name ?= a_session.value (session_id (a_base_id, type_session_id))
				if l_type_name /= Void and then not l_type_name.is_empty then
					l_type_id := internal.dynamic_type_from_string (l_type_name)
					if {l_type: TYPE [STONE]} internal.new_instance_of (l_type_id) then
						Result := delegate_resurrect_stone (l_type, a_session, a_base_id)
						if Result /= Void and then not internal.type_of (Result).conforms_to (l_type) then
								-- Incompatible type
							Result := Void
						end
					end
				end
			end
		ensure
			is_suspended_unchanged: a_session.value_changed_event.is_suspended = old a_session.value_changed_event.is_suspended
			raise_events_unchanged: raise_events = old raise_events
		end

	frozen persist_stone (a_session: !SESSION_I; a_base_id: !STRING; a_stone: ?STONE) is
			-- Stores a stone's reference information in the given session, for later resurrection.
			--| Note: Do *not* store the stone object in the session! This will include too much data.
			--
			-- `a_session': The session object to store stone information into.
			-- `a_base_id': A base ID to use to build a session id for the stone.
			-- `a_stone': The stone to persist information about, in the supplied session.
		require
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				if raise_events or else a_session.value_changed_event.is_suspended then
					if a_stone /= Void and then {l_type: TYPE [STONE]} internal.type_of (a_stone) and then delegate_persist_stone (l_type, a_session, a_base_id, a_stone) then
							-- Stone was persisted, so update the necessary stone type information to reflect a persisted stone.
						a_session.set_value (l_type.generating_type, session_id (a_base_id, type_session_id))
					else
							-- No stone was persisted, wipe out the stone type so it's not attempted to be retrieved
						a_session.set_value (Void, session_id (a_base_id, type_session_id))
					end
				else
						-- Execute with suspended events
					a_session.value_changed_event.perform_suspended_action (agent persist_stone (a_session, a_base_id, a_stone))
				end
			end
		ensure
			is_suspended_unchanged: a_session.value_changed_event.is_suspended = old a_session.value_changed_event.is_suspended
			raise_events_unchanged: raise_events = old raise_events
		end

feature {NONE} -- Deletgation

	delegate_resurrect_stone (a_type: !TYPE [STONE]; a_session: !SESSION_I; a_base_id: !STRING): ?STONE
			-- Delegates resurrection of a stone from previously persisted session data.
			--
			-- `a_type': The type of stone to resurrect.
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to build a session id for the stone.
			-- `Result': A stone or Void if no stone could be resurrected.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		do
			if a_type.conforms_to ({FEATURE_STONE}) then
				Result := resurrect_feature_stone (a_session, a_base_id)
			elseif a_type.conforms_to ({CLASSC_STONE}) then
				Result := resurrect_classc_stone (a_session, a_base_id)
			elseif a_type.conforms_to ({CLASSI_STONE}) then
				Result := resurrect_classi_stone (a_session, a_base_id)
			end
		ensure
			result_type_conforms_to_a_type: Result /= Void implies internal.type_of (Result).conforms_to (a_type)
		end

	delegate_persist_stone (a_type: !TYPE [STONE]; a_session: !SESSION_I; a_base_id: !STRING; a_stone: ?STONE): BOOLEAN
			-- Delegates storage a stone's reference information in the given session, for later resurrection.
			--| Note: Do *not* store the stone object in the session! This will include too much data.
			--
			-- `a_type': The type of stone to persist.
			-- `a_session': The session object to store stone information into.
			-- `a_base_id': A base ID to use to build a session id for the stone.
			-- `a_stone': The stone to persist information about, in the supplied session.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
			a_type_match_a_stone_type: a_stone /= Void implies internal.type_of (a_stone).is_equal (a_type)
		do
			if {l_feature: FEATURE_STONE} a_stone then
				persist_feature_stone (a_session, a_base_id, l_feature)
				Result := True
			elseif {l_classc: CLASSC_STONE} a_stone then
				persist_classc_stone (a_session, a_base_id, l_classc)
				Result := True
			elseif {l_classi: CLASSI_STONE} a_stone then
				persist_classi_stone (a_session, a_base_id, l_classi)
				Result := True
			else
					-- No stone, use type to remove the information.
				if a_type.conforms_to ({FEATURE_STONE}) then
					persist_feature_stone (a_session, a_base_id, Void)
					Result := True
				elseif a_type.conforms_to ({CLASSC_STONE}) then
					persist_classc_stone (a_session, a_base_id, Void)
					Result := True
				end
			end
		end

feature {NONE} -- Specifics

	resurrect_classc_stone (a_session: !SESSION_I; a_base_id: !STRING): ?CLASSC_STONE
			-- Resurrects a class stone from previously stored session data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to persist stone information.
			-- `Result': A applicable stone for Current of Void if no applicable stone could be resurrected.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		local
			l_class_c: ?CLASS_C
			l_classi_stone: ?CLASSI_STONE
		do
			l_classi_stone := resurrect_classi_stone (a_session, a_base_id)
			if l_classi_stone /= Void then
				l_class_c := l_classi_stone.class_i.compiled_class
				if l_class_c /= Void then
					create Result.make (l_class_c)
				end
			end
		end

	persist_classc_stone (a_session: !SESSION_I; a_base_id: !STRING; a_stone: ?CLASSC_STONE)
			-- Stores a stone's reference information in the given session, for later resurrection.
			-- Note: Do *not* store the stone object in the session! This will include too much data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to persist stone information.
			-- `a_stone': The stone to persist information about, in the supplied session.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		do
			persist_classi_stone (a_session, a_base_id, a_stone)
		end

	resurrect_classi_stone (a_session: !SESSION_I; a_base_id: !STRING): ?CLASSI_STONE
			-- Resurrects a class stone from previously stored session data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to persist stone information.
			-- `Result': A applicable stone for Current of Void if no applicable stone could be resurrected.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING_8]
			l_group: CONF_GROUP
			l_group_name: ?STRING
			l_class_name: ?STRING
			l_class: ?CLASS_I
			l_file_name: ?STRING
		do
			l_group_name ?= a_session.value (session_id (a_base_id, group_name_session_id))
			if l_group_name /= Void and then not l_group_name.is_empty then
				l_groups := universe.conf_system.application_target.groups
				if l_groups.has (l_group_name) then
					l_group := l_groups.item (l_group_name)
					if l_group /= Void then
						l_class_name ?= a_session.value (session_id (a_base_id, class_name_session_id))
						if l_class_name /= Void and then not l_class_name.is_empty then
							l_class := universe.class_named (l_class_name, l_group)
							if l_class /= Void then
								l_file_name ?= a_session.value (session_id (a_base_id, location_session_id))
								if l_file_name /= Void and then l_class.file_name.string.is_equal (l_file_name) then
									create Result.make (l_class)
								end
							end
						end
					end
				end
			end
		end

	persist_classi_stone (a_session: !SESSION_I; a_base_id: !STRING; a_stone: ?CLASSI_STONE) is
			-- Stores a stone's reference information in the given session, for later resurrection.
			-- Note: Do *not* store the stone object in the session! This will include too much data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to persist stone information.
			-- `a_stone': The stone to persist information about, in the supplied session.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		do
			if a_stone /= Void then
				a_session.set_value (a_stone.file_name, session_id (a_base_id, location_session_id))
				a_session.set_value (a_stone.class_i.name, session_id (a_base_id, class_name_session_id))
				a_session.set_value (a_stone.class_i.group.name, session_id (a_base_id, group_name_session_id))
			else
				a_session.set_value (Void, session_id (a_base_id, location_session_id))
				a_session.set_value (Void, session_id (a_base_id, class_name_session_id))
				a_session.set_value (Void, session_id (a_base_id, group_name_session_id))
			end
		end

	resurrect_feature_stone (a_session: !SESSION_I; a_base_id: !STRING): ?FEATURE_STONE
			-- Resurrects a stone from previously stored session data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to persist stone information.
			-- `Result': A applicable stone for Current of Void if no applicable stone could be resurrected.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		local
			l_name: ?STRING
			l_class_stone: ?CLASSC_STONE
			l_class: CLASS_C
			l_feautre: E_FEATURE
		do
			l_name ?= a_session.value (session_id (a_base_id, feature_name_session_id))
			if l_name /= Void and then not l_name.is_empty then
				l_class_stone ?= resurrect_classc_stone (a_session, a_base_id)
				if l_class_stone /= Void then
					l_class := l_class_stone.e_class
					if l_class /= Void then
						l_feautre := l_class.feature_with_name (l_name)
						if l_feautre /= Void then
							create Result.make (l_feautre)
						end
					end
				end
			end
		end

	persist_feature_stone (a_session: !SESSION_I; a_base_id: !STRING; a_stone: ?FEATURE_STONE)
			-- Stores a stone's reference information in the given session, for later resurrection.
			-- Note: Do *not* store the stone object in the session! This will include too much data.
			--
			-- `a_session': The session object to retrieve stone information from.
			-- `a_base_id': A base ID to use to persist stone information.
			-- `a_stone': The stone to persist information about, in the supplied session.
		require
			system_is_defined: workbench.system_defined
			project_is_compiled: workbench.is_already_compiled
			a_session_is_interface_usable: a_session.is_interface_usable
			a_session_is_per_project: a_session.is_per_project
			not_a_base_id_is_empty: not a_base_id.is_empty
		do
			if a_stone /= Void then
				a_session.set_value (a_stone.feature_name, session_id (a_base_id, feature_name_session_id))
			else
				a_session.set_value (Void, session_id (a_base_id, feature_name_session_id))
			end
			persist_classc_stone (a_session, a_base_id, a_stone)
		end

feature {NONE} -- Constants

	type_session_id: !STRING = "type"
	location_session_id: !STRING = "location"
	type_id_session_id: !STRING = "type_id"
	feature_name_session_id: !STRING = "feature_name"
	class_name_session_id: !STRING = "class_name"
	group_name_session_id: !STRING = "group_name"

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
