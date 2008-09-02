indexing
	description: "Views for configuration components. targets and clusters."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_CONF_VIEW

inherit
	ES_EIS_COMPONENT_VIEW [!CONF_NOTABLE]
		rename
			component as conf_notable
		redefine
			background_color_of_entry,
			create_new_entry,
			delete_selected_entries,
			entry_editable,
			component_editable,
			on_name_changed,
			on_protocol_changed,
			on_source_changed,
			on_tags_changed,
			on_others_changed
		end

	CONF_ACCESS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_conf_notable: !CONF_NOTABLE; a_eis_grid: !ES_EIS_ENTRY_GRID) is
			-- Initialized with `a_conf_notable' and `a_eis_grid'.
		require
			a_eis_grid_not_destroyed: not a_eis_grid.is_destroyed
			a_notable_is_valid: valid_notable (a_conf_notable)
		do
			conf_notable := a_conf_notable
			eis_grid := a_eis_grid
				-- Allow new entry addition.
			new_entry_possible := True
		end

feature -- Querry

	valid_notable (a_notable: !CONF_NOTABLE): BOOLEAN is
			-- Is `a_notable' a supported component?
		do
			Result := {lt_target: CONF_TARGET}a_notable or else {lt_cluster: CONF_CLUSTER}a_notable
		end

	component_editable: BOOLEAN is
			-- Is component editable?
		local
			l_lib: CONF_LIBRARY
		do
			if {lt_target: CONF_TARGET}conf_notable then
				l_lib := lt_target.system.application_target_library
				if l_lib /= Void then
					Result := not l_lib.is_readonly
				else
					Result := not lt_target.system.is_readonly
				end
			elseif {lt_cluster: CONF_CLUSTER}conf_notable then
				Result := not lt_cluster.is_readonly
			end
		end

feature -- Operation

	create_new_entry is
			-- Create new EIS entry in `a_conf_notable'.
		local
			l_entry: !EIS_ENTRY
			l_added: BOOLEAN
		do
			if component_editable then
				create l_entry.make ("Unnamed", Void, Void, Void, component_id, Void)
				if {lt_target: CONF_TARGET}conf_notable then
					if {lt_sys: CONF_SYSTEM}lt_target.system then
						write_entry (l_entry, lt_target, lt_sys)
						l_added := last_entry_modified
						if not l_added then
							prompts.show_error_prompt (interface_names.l_item_is_not_writable (lt_target.name), Void, Void)
						end
					end
				elseif {lt_cluster: CONF_CLUSTER}conf_notable then
					if {lt_sys1: CONF_SYSTEM}lt_cluster.target.system and then not lt_cluster.is_readonly then
						write_entry (l_entry, lt_cluster, lt_sys1)
						l_added := last_entry_modified
					else
						prompts.show_error_prompt (interface_names.l_item_is_not_writable (lt_cluster.name), Void, Void)
					end
				end

				if l_added then
					storage.register_entry (l_entry, component_id)
					if extracted_entries = Void then
						create extracted_entries.make (1)
					end
					extracted_entries.force_last (l_entry)
					refresh_grid_without_sorting
				end
			else
				prompts.show_error_prompt (interface_names.l_item_selected_is_not_writable, Void, Void)
			end
		end

	delete_selected_entries is
			-- <precursor>
		local
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_request: ES_DISCARDABLE_QUESTION_PROMPT
			l_cancelled, l_removed: BOOLEAN
		do
			if component_editable then
				create l_request.make_standard_with_cancel (interface_names.l_confirm_delete_selected_items,
					interface_names.l_always_delete_without_asking,
					preferences.dialog_data.confirm_delete_eis_entries_string)
				l_request.set_title (interface_names.t_eiffelstudio_question)
				l_request.show_on_active_window
				if l_request.dialog_result = dialog_buttons.cancel_button then
					l_cancelled := True
				end

				if not l_cancelled then
					l_selected_rows := eis_grid.selected_rows
					from
						l_selected_rows.start
					until
						l_selected_rows.after
					loop
						if {lt_entry: EIS_ENTRY}l_selected_rows.item_for_iteration.data then
							if entry_editable (lt_entry) and then {lt_system: CONF_SYSTEM}system_of_conf_notable (conf_notable) then
								remove_entry (lt_entry, conf_notable, lt_system)
								extracted_entries.remove (l_selected_rows.item_for_iteration.index)
								l_removed := True
							end
						end
						l_selected_rows.forth
					end
					if l_removed then
						refresh_grid_without_sorting
					end
				end
			else
				prompts.show_error_prompt (interface_names.l_item_selected_is_not_writable, Void, Void)
			end
		end

feature {NONE} -- Conf modification

	write_entry (a_entry: !EIS_ENTRY; a_conf_notable: !CONF_NOTABLE; a_system: !CONF_SYSTEM) is
			-- Add `a_entry' in `a_conf_notable' without saving.
			-- `a_conf_notable' to add the entry
			-- `a_system' to save the configure file.
		require
			a_entry_editable: entry_editable (a_entry)
		local
			l_for_conf: BOOLEAN
		do
			last_entry_modified := False
			l_for_conf := eis_output.is_for_conf
			eis_output.set_is_for_conf (True)
			eis_output.process (a_entry)
			a_conf_notable.add_note (eis_output.last_output_conf)
			eis_output.set_is_for_conf (l_for_conf)

			a_system.store
			last_entry_modified := a_system.store_successful
		end

	modify_entry_in_conf (a_old_entry, a_new_entry: !EIS_ENTRY; a_conf: CONF_NOTABLE; a_system: !CONF_SYSTEM) is
			-- Modify `a_old_entry' into `a_new_entry' in `a_conf'
		require
			a_old_entry_editable: entry_editable (a_old_entry)
		local
			l_notes: ARRAYED_LIST [HASH_TABLE [STRING, STRING]]
			l_found: BOOLEAN
			l_for_conf: BOOLEAN
		do
			last_entry_modified := False
			l_notes := a_conf.notes
			l_for_conf := eis_output.is_for_conf
			eis_output.set_is_for_conf (True)
			from
				l_notes.start
			until
				l_notes.after or l_found
			loop
				if {lt_entry: EIS_ENTRY}eis_entry_from_conf_note (l_notes.item_for_iteration, component_id) then
					if lt_entry.same_entry (a_old_entry) then
						eis_output.process (a_new_entry)
						a_conf.replace_note (l_notes.item_for_iteration, eis_output.last_output_conf)
						l_found := True
					end
				end
				l_notes.forth
			end
			eis_output.set_is_for_conf (l_for_conf)
			if l_found then
				a_system.store
				last_entry_modified := a_system.store_successful
			end
		end

	remove_entry (a_entry: !EIS_ENTRY; a_conf_notable: !CONF_NOTABLE; a_system: !CONF_SYSTEM) is
			-- Remove `a_entry' from `a_conf_notable' and save in `a_system'
		require
			a_entry_editable: entry_editable (a_entry)
		local
			l_notes: ARRAYED_LIST [HASH_TABLE [STRING, STRING]]
			l_found: BOOLEAN
		do
			last_entry_modified := False
			l_notes := conf_notable.notes
			from
				l_notes.start
			until
				l_notes.after or l_found
			loop
				if {lt_entry: EIS_ENTRY}eis_entry_from_conf_note (l_notes.item_for_iteration, component_id) then
					if lt_entry.same_entry (a_entry) then
						conf_notable.remove_note (l_notes.item_for_iteration)
						l_found := True
					end
				end
				l_notes.forth
			end
			if l_found then
				a_system.store
				last_entry_modified := a_system.store_successful
			end
		end

	entry_editable (a_entry: !EIS_ENTRY): BOOLEAN is
			-- If `a_entry' is editable through current view?
		local
			l_type: NATURAL
			l_cluster: CONF_CLUSTER
			l_target: CONF_TARGET
			l_lib: CONF_LIBRARY
		do
			if {lt_id: STRING}a_entry.id then
				l_type := id_solution.most_possible_type_of_id (lt_id)
				if l_type = id_solution.target_type and then lt_id.is_equal (component_id) then
					l_target := id_solution.target_of_id (lt_id)
					if l_target /= Void then
						l_lib := l_target.system.application_target_library
						if l_lib /= Void then
							Result := not l_lib.is_readonly
						else
							Result := not l_target.system.is_readonly
						end
					end
				elseif l_type = id_solution.group_type and then lt_id.is_equal (component_id) then
					l_cluster ?= id_solution.group_of_id (lt_id)
					if l_cluster /= Void then
						Result := not l_cluster.is_readonly
					end
				end
			end
		end

	last_entry_modified: BOOLEAN
			-- Has last entry been modified in the configure file?

feature {NONE} -- Callbacks

	on_name_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On name changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: !EIS_ENTRY
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data and then {lt_name: STRING_32}a_item.text then
				if lt_entry.name /= Void and then lt_name.is_equal (lt_entry.name) then
						-- Do nothing when the name is not actually changed
				else
					if entry_editable (lt_entry) then
						if {lt_system: CONF_SYSTEM}system_of_conf_notable (conf_notable) then
							if {lt_new_entry: EIS_ENTRY}lt_entry.twin then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_name (lt_name)
							modify_entry_in_conf (lt_entry, l_new_entry, conf_notable, lt_system)
								-- Modify the name in the entry when the modification is done
							if last_entry_modified then
								storage.deregister_entry (lt_entry, component_id)
								lt_entry.set_name (lt_name)
								storage.register_entry (lt_entry, component_id)
							end
						end
					end
				end
			end
		end

	on_protocol_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On protocol changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: !EIS_ENTRY
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data and then {lt_protocol: STRING_32}a_item.text then
				if lt_entry.protocol /= Void and then lt_protocol.is_equal (lt_entry.protocol) then
						-- Do nothing when the protocol is not actually changed
				else
					if entry_editable (lt_entry) then
						if {lt_system: CONF_SYSTEM}system_of_conf_notable (conf_notable) then
							if {lt_new_entry: EIS_ENTRY}lt_entry.twin then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_protocol (lt_protocol)
							modify_entry_in_conf (lt_entry, l_new_entry, conf_notable, lt_system)
								-- Modify the protocol in the entry when the modification is done
							if last_entry_modified then
								storage.deregister_entry (lt_entry, component_id)
								lt_entry.set_protocol (lt_protocol)
								storage.register_entry (lt_entry, component_id)
							end
						end
					end
				end
			end
		end

	on_source_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On source changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: !EIS_ENTRY
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data and then {lt_source: STRING_32}a_item.text then
				if lt_entry.source /= Void and then lt_source.is_equal (lt_entry.source) then
						-- Do nothing when the source is not actually changed
				else
					if entry_editable (lt_entry) then
						if {lt_system: CONF_SYSTEM}system_of_conf_notable (conf_notable) then
							if {lt_new_entry: EIS_ENTRY}lt_entry.twin then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_source (lt_source)
							modify_entry_in_conf (lt_entry, l_new_entry, conf_notable, lt_system)
								-- Modify the source in the entry when the modification is done
							if last_entry_modified then
								storage.deregister_entry (lt_entry, component_id)
								lt_entry.set_source (lt_source)
								storage.register_entry (lt_entry, component_id)
							end
						end
					end
				end
			end
		end

	on_tags_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On tags changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: !EIS_ENTRY
			l_tags: !ARRAYED_LIST [!STRING_32]
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data and then {lt_tags: STRING_32}a_item.text then
					 -- |FIXME: Bad conversion, should not convert to string_8.
				if {lt_tags_str_8: STRING}lt_tags.as_string_8 then
					l_tags := parse_tags (lt_tags_str_8)
					l_tags.compare_objects
				end
				if lt_entry.tags /= Void and then lt_entry.tags.is_equal (l_tags) then
						-- Do nothing when the tags is not actually changed
				else
					if entry_editable (lt_entry) then
						if {lt_system: CONF_SYSTEM}system_of_conf_notable (conf_notable) then
							if {lt_new_entry: EIS_ENTRY}lt_entry.twin then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_tags (l_tags)
							modify_entry_in_conf (lt_entry, l_new_entry, conf_notable, lt_system)
								-- Modify the tags in the entry when the modification is done
							if last_entry_modified then
								storage.deregister_entry (lt_entry, component_id)
								if not l_tags.is_empty then
									lt_entry.set_tags (l_tags)
								else
									lt_entry.set_tags (Void)
								end
								storage.register_entry (lt_entry, component_id)
							end
						end
					end
				end
			end
		end

	on_others_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On others changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: !EIS_ENTRY
			l_others: !HASH_TABLE [STRING_32, STRING_32]
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data and then {lt_others: STRING_32}a_item.text then
				l_others := parse_others (lt_others)
				l_others.compare_objects
				if lt_entry.others /= Void and then lt_entry.others.is_equal (l_others) then
						-- Do nothing when the others is not actually changed
				else
					if entry_editable (lt_entry) then
						if {lt_system: CONF_SYSTEM}system_of_conf_notable (conf_notable) then
							if {lt_new_entry: EIS_ENTRY}lt_entry.twin then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_others (l_others)
							modify_entry_in_conf (lt_entry, l_new_entry, conf_notable, lt_system)
								-- Modify the others in the entry when the modification is done
							if last_entry_modified then
								storage.deregister_entry (lt_entry, component_id)
								if not l_others.is_empty then
									lt_entry.set_others (l_others)
								else
									lt_entry.set_others (Void)
								end
								storage.register_entry (lt_entry, component_id)
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	system_of_conf_notable (a_notable: !CONF_NOTABLE): ?CONF_SYSTEM is
			-- Get system from `a_notable'
		do
			if {lt_target: CONF_TARGET}a_notable then
				Result := lt_target.system
			elseif {lt_cluster: CONF_CLUSTER}a_notable then
				Result := lt_cluster.target.system
			end
		ensure
			valid_a_notable_implies_not_void: valid_notable (a_notable) implies Result /= Void
		end

	new_extractor: !ES_EIS_EXTRACTOR is
			-- Create extractor
		do
			create {ES_EIS_CONF_EXTRACTOR}Result.make (conf_notable)
		end

	background_color_of_entry (a_entry: !EIS_ENTRY): EV_COLOR is
			-- Background color of `a_entry'
		do
			if
				{lt_id: STRING}a_entry.id and then
				(lt_id.is_equal (component_id) or id_solution.most_possible_type_of_id (lt_id) = id_solution.feature_type)
			then
					-- Default background color without change
			else
				Result := colors.stock_colors.default_background_color
			end
		end

	component_id: !STRING
			-- Component ID
		do
			if internal_component_id = Void then
				if {lt_id: STRING}computed_component_id then
					Result := lt_id
				end
			else
				if {lt_id1: STRING}internal_component_id then
					Result := lt_id1
				end
			end
		end

	computed_component_id: ?STRING
			-- <Precursor>
		do
			if {lt_cluster: CONF_CLUSTER}conf_notable then
				Result := id_solution.id_of_group (lt_cluster)
			elseif {lt_target: CONF_TARGET}conf_notable then
				Result := id_solution.id_of_target (lt_target)
			end
		ensure
			Result_not_void: Result /= Void
		end

	internal_component_id: ?STRING;
			-- Buffered component ID

invariant
	conf_notable_is_valid: valid_notable (conf_notable)

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
