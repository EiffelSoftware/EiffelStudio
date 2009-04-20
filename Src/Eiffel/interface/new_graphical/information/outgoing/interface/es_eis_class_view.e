note
	description: "EIS list of a given class."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_CLASS_VIEW

inherit
	ES_EIS_COMPONENT_VIEW [CLASS_I]
		rename
			component as class_i
		redefine
			background_color_of_entry,
			create_new_entry,
			delete_selected_entries,
			entry_editable,
			component_editable,
			class_editor_token_for_location,
			feature_editor_token_for_location,
			on_name_changed,
			on_protocol_changed,
			on_source_changed,
			on_tags_changed,
			on_others_changed
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: attached CLASS_I; a_eis_grid: attached ES_EIS_ENTRY_GRID)
			-- Initialized with `a_conf_notable' and `a_eis_grid'.
		require
			a_eis_grid_not_destroyed: not a_eis_grid.is_destroyed
		do
			class_i := a_class
			eis_grid := a_eis_grid
				-- Allow new entry addition.
			new_entry_possible := True
		end

feature -- Operation

	create_new_entry
			-- Create new EIS entry in `class_i'.
		local
			l_class_modifier: ES_EIS_CLASS_MODIFIER
		do
			create l_class_modifier.make (class_i)
			if l_class_modifier.is_modifiable then
				l_class_modifier.prepare
				if l_class_modifier.is_ast_available then
					l_class_modifier.new_empty_class_entry
					l_class_modifier.commit

					if
						attached l_class_modifier.last_create_entry as lt_entry and then
						attached id_solution.id_of_class (class_i.config_class) as lt_id
					then
						storage.register_entry (lt_entry, lt_id, class_i.date)
						if extracted_entries = Void then
							create extracted_entries.make (1)
						end
						extracted_entries.force_last (lt_entry)
						refresh_grid_without_sorting
					end
				else
					prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
				end
			else
				prompts.show_error_prompt (interface_names.l_class_is_not_editable, Void, Void)
			end
		end

	delete_selected_entries
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
						if attached {EIS_ENTRY} l_selected_rows.item_for_iteration.data as lt_entry then
							if entry_editable (lt_entry) then
								remove_entry (lt_entry)
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

feature -- Querry

	component_editable: BOOLEAN
			-- Is component editable?
		do
			Result := not class_i.is_read_only
		end

feature {NONE} -- Access

	entry_editable (a_entry: attached EIS_ENTRY): BOOLEAN
			-- If `a_entry' is editable through current view?
		local
			l_type: NATURAL
			l_feature: E_FEATURE
			l_modifier: ES_EIS_CLASS_MODIFIER
		do
			if attached a_entry.id as lt_id then
				l_type := id_solution.most_possible_type_of_id (lt_id)
				if l_type = id_solution.class_type then
					if attached {CLASS_I} id_solution.class_of_id (lt_id) as lt_class then
						Result := (class_i = lt_class)
					end
				elseif l_type = id_solution.feature_type then
					l_feature := id_solution.feature_of_id (lt_id)
					if l_feature /= Void then
						Result := l_feature.written_class.lace_class = class_i
					end
				end
				if Result then
					create l_modifier.make (class_i)
					l_modifier.prepare
					Result := l_modifier.is_modifiable and then l_modifier.is_ast_available
				end
			end
		end

feature {NONE} -- Class modification

	modify_entry_in_feature (a_old_entry, a_new_entry: attached EIS_ENTRY; a_feature: attached E_FEATURE)
			-- Modify `a_old_entry' with `a_new_entry' in `a_feature'.
		require
			a_old_entry_editable: entry_editable (a_old_entry)
		local
			l_feature_modifier: ES_EIS_FEATURE_MODIFIER
		do
			create l_feature_modifier.make (a_feature, class_i)
			l_feature_modifier.prepare
			if l_feature_modifier.is_ast_available then
				l_feature_modifier.modify_feature_entry (a_old_entry, a_new_entry)
				l_feature_modifier.commit
			else
				prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
			end
		end

	modify_entry_in_class (a_old_entry, a_new_entry: attached EIS_ENTRY; a_class: attached CLASS_I)
			-- Modify `a_old_entry' with `a_new_entry' in `a_class'.
		require
			a_old_entry_editable: entry_editable (a_old_entry)
		local
			l_class_modifier: ES_EIS_CLASS_MODIFIER
		do
			create l_class_modifier.make (a_class)
			l_class_modifier.prepare
			if l_class_modifier.is_ast_available then
				l_class_modifier.modify_class_entry (a_old_entry, a_new_entry)
				l_class_modifier.commit
			else
				prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
			end
		end

	remove_entry (a_entry: attached EIS_ENTRY)
			-- Remove entry in component.
		require
			a_entry_editable: entry_editable (a_entry)
		do
			if attached {E_FEATURE} id_solution.feature_of_id (a_entry.id) as lt_feature then
				remove_entry_in_feature (a_entry, lt_feature)
				storage.deregister_entry (a_entry, component_id)
			elseif attached {CLASS_I} id_solution.class_of_id (a_entry.id) as lt_class then
				remove_entry_in_class (a_entry, lt_class)
				storage.deregister_entry (a_entry, component_id)
			end
		end

	remove_entry_in_feature (a_entry: attached EIS_ENTRY; a_feature: attached E_FEATURE)
			-- Remove entry in feature.
		require
			a_entry_editable: entry_editable (a_entry)
		local
			l_feature_modifier: ES_EIS_FEATURE_MODIFIER
		do
			create l_feature_modifier.make (a_feature, class_i)
			l_feature_modifier.prepare
			if l_feature_modifier.is_ast_available then
				l_feature_modifier.remove_feature_entry (a_entry, True)
				l_feature_modifier.commit
			else
				prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
			end
		end

	remove_entry_in_class (a_entry: attached EIS_ENTRY; a_class: attached CLASS_I)
			-- Remove entry in class.
		require
			a_entry_editable: entry_editable (a_entry)
		local
			l_class_modifier: ES_EIS_CLASS_MODIFIER
		do
			create l_class_modifier.make (a_class)
			l_class_modifier.prepare
			if l_class_modifier.is_ast_available then
				l_class_modifier.remove_class_entry (a_entry, True)
				l_class_modifier.commit
			else
				prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
			end
		end

	write_entry_in_feature (a_entry: attached EIS_ENTRY; a_feature: attached E_FEATURE)
			-- Write entry in feature.
		local
			l_feature_modifier: ES_EIS_FEATURE_MODIFIER
		do
			create l_feature_modifier.make (a_feature, class_i)
			l_feature_modifier.prepare
			if l_feature_modifier.is_modifiable then
				if l_feature_modifier.is_ast_available then
					l_feature_modifier.write_feature_entry (a_entry)
					l_feature_modifier.commit
				else
					prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
				end
			else
				prompts.show_error_prompt (interface_names.l_class_is_not_editable, Void, Void)
			end
		end

	write_entry_in_class (a_entry: attached EIS_ENTRY; a_class: attached CLASS_I)
			-- Write entry in class.
		local
			l_class_modifier: ES_EIS_CLASS_MODIFIER
		do
			create l_class_modifier.make (a_class)
			l_class_modifier.prepare
			if l_class_modifier.is_modifiable then
				if l_class_modifier.is_ast_available then
					l_class_modifier.write_class_entry (a_entry)
					l_class_modifier.commit
				else
					prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
				end
			else
				prompts.show_error_prompt (interface_names.l_class_is_not_editable, Void, Void)
			end
		end

feature {NONE} -- Location token

	class_editor_token_for_location (a_item: CLASS_I): attached ES_GRID_LIST_ITEM
			-- Create editor token for loaction accordingly.
		do
			if a_item.is_compiled then
				Result := class_feature_editor_token_for_location (a_item)
			else
				Result := Precursor {ES_EIS_COMPONENT_VIEW}(a_item)
			end
		end

	feature_editor_token_for_location (a_item: E_FEATURE; a_name: STRING): attached ES_GRID_LIST_ITEM
			-- Create editor token item for loaction accordingly.
		do
			if a_item /= Void then
				Result := class_feature_editor_token_for_location (a_item)
			elseif a_name /= Void then
				Result := Precursor {ES_EIS_COMPONENT_VIEW}(a_item, a_name)
			end
		end

	class_feature_editor_token_for_location (a_item: ANY): attached ES_GRID_LIST_ITEM
			-- Create editor token item for loaction accordingly.
		local
			l_editable_item: attached EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_list: ARRAYED_LIST [EB_GRID_LISTABLE_CHOICE_ITEM_ITEM]
			l_item_item: attached EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
			l_modifier: ES_EIS_CLASS_MODIFIER
			l_classc: CLASS_C
			l_written_in_features: LIST [E_FEATURE]
			l_class: CLASS_I
			l_feature: E_FEATURE
		do
			create l_modifier.make (class_i)
			l_modifier.prepare
			if class_i.is_compiled and then l_modifier.is_modifiable and then l_modifier.is_ast_available then
				l_classc := class_i.compiled_class
				l_written_in_features := l_classc.written_in_features

				l_editable_item := new_listable_item

					-- Fill entries of list
				create l_list.make (l_written_in_features.count + 1)
				token_writer.new_line
				token_writer.add_class (class_i)
				l_line := token_writer.last_line
				create l_e_com.make (l_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<class_pixmap_component (class_i), l_e_com>>))
				l_item_item.set_data (class_i)
				l_list.extend (l_item_item)
				l_class ?= a_item
				if l_class /= Void and then l_class.is_equal (class_i) then
					l_editable_item.set_list_item (l_item_item)
				else
					l_feature ?= a_item
				end

				from
					l_written_in_features.start
				until
					l_written_in_features.after
				loop
					if (attached {E_FEATURE} l_written_in_features.item_for_iteration as lt_feature and then not lt_feature.is_attribute and then not lt_feature.is_constant) then
						token_writer.new_line
						token_writer.add_sectioned_feature_name (lt_feature)
						l_line := token_writer.last_line
						create l_e_com.make (l_line.content, 0)
						create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<feature_pixmap_component (lt_feature), l_e_com>>))
						l_item_item.set_data (lt_feature)
						l_list.extend (l_item_item)
						if l_feature /= Void and then l_feature.is_equal (lt_feature) then
							l_editable_item.set_list_item (l_item_item)
						end
					end
					l_written_in_features.forth
				end
				l_editable_item.set_item_components (l_list)

				Result := l_editable_item
				if l_editable_item.item_components /= Void and then l_editable_item.item_components.index_set.count > 1 then
					l_editable_item.pointer_button_press_actions.force_extend (agent activate_item (l_editable_item))
					l_editable_item.set_selection_changing_action (agent on_location_changed (?, l_editable_item))
				end
			else
				create Result
			end
		end

feature {NONE} -- Implementation

	new_extractor: attached ES_EIS_EXTRACTOR
			-- Create extractor
		do
			create {ES_EIS_CLASS_EXTRACTOR}Result.make (class_i, True)
		end

	background_color_of_entry (a_entry: attached EIS_ENTRY): EV_COLOR
			-- Background color of `a_entry'
		do
			if
				attached a_entry.id as lt_id and then
				(lt_id.is_equal (component_id) or id_solution.most_possible_type_of_id (lt_id) = id_solution.feature_type)
			then
					-- Default background color without change
			else
				Result := colors.stock_colors.default_background_color
			end
		end

	component_id: attached STRING
			-- Component ID
		do
			if internal_component_id = Void then
				if attached computed_component_id as lt_id then
					Result := lt_id
				end
			else
				if attached internal_component_id as lt_id1 then
					Result := lt_id1
				end
			end
		end

	computed_component_id: detachable STRING
			-- Compute component id
		do
			Result := id_solution.id_of_class (class_i.config_class)
		end

	internal_component_id: detachable STRING;
			-- Buffered component ID

feature {NONE} -- Callbacks

	on_name_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On name changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: attached EIS_ENTRY
			l_done: BOOLEAN
		do
			if attached {EIS_ENTRY} a_item.row.data as lt_entry and then attached a_item.text as lt_name then
				if lt_entry.name /= Void and then lt_name.is_equal (lt_entry.name) then
						-- Do nothing when the name is not actually changed
				else
					if entry_editable (lt_entry) then
						if attached {E_FEATURE} id_solution.feature_of_id (lt_entry.id) as lt_feature then
							if attached lt_entry.twin as lt_new_entry then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_name (lt_name)
							modify_entry_in_feature (lt_entry, l_new_entry, lt_feature)
							l_done := True
						elseif attached {CLASS_I} id_solution.class_of_id (lt_entry.id) as lt_class then
							if attached lt_entry.twin as lt_new_entry1 then
								l_new_entry := lt_new_entry1
							end
							l_new_entry.set_name (lt_name)
							modify_entry_in_class (lt_entry, l_new_entry, lt_class)
							l_done := True
						end
							-- Modify the name in the entry when the modification is done
						if l_done then
							storage.deregister_entry (lt_entry, component_id)
							lt_entry.set_name (lt_name)
							storage.register_entry (lt_entry, component_id, class_i.date)
						end
					end
				end
			end
		end

	on_protocol_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On protocol changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: attached EIS_ENTRY
			l_done: BOOLEAN
		do
			if attached {EIS_ENTRY} a_item.row.data as lt_entry and then attached a_item.text as lt_protocol then
				if lt_entry.protocol /= Void and then lt_protocol.is_equal (lt_entry.protocol) then
						-- Do nothing when the protocol is not actually changed
				else
					if entry_editable (lt_entry) then
						if attached {E_FEATURE} id_solution.feature_of_id (lt_entry.id) as lt_feature then
							if attached lt_entry.twin as lt_new_entry then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_protocol (lt_protocol)
							modify_entry_in_feature (lt_entry, l_new_entry, lt_feature)
							l_done := True
						elseif attached {CLASS_I} id_solution.class_of_id (lt_entry.id) as lt_class then
							if attached lt_entry.twin as lt_new_entry1 then
								l_new_entry := lt_new_entry1
							end
							l_new_entry.set_protocol (lt_protocol)
							modify_entry_in_class (lt_entry, l_new_entry, lt_class)
							l_done := True
						end
							-- Modify the protocol in the entry when the modification is done
						if l_done then
							storage.deregister_entry (lt_entry, component_id)
							lt_entry.set_protocol (lt_protocol)
							storage.register_entry (lt_entry, component_id, class_i.date)
						end
					end
				end
			end
		end

	on_source_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On source changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: attached EIS_ENTRY
			l_done: BOOLEAN
		do
			if attached {EIS_ENTRY} a_item.row.data as lt_entry and then attached a_item.text as lt_source then
				if lt_entry.source /= Void and then lt_source.is_equal (lt_entry.source) then
						-- Do nothing when the source is not actually changed
				else
					if entry_editable (lt_entry) then
						if attached {E_FEATURE} id_solution.feature_of_id (lt_entry.id) as lt_feature then
							if attached lt_entry.twin as lt_new_entry then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_source (lt_source)
							modify_entry_in_feature (lt_entry, l_new_entry, lt_feature)
							l_done := True
						elseif attached {CLASS_I} id_solution.class_of_id (lt_entry.id) as lt_class then
							if attached lt_entry.twin as lt_new_entry1 then
								l_new_entry := lt_new_entry1
							end
							l_new_entry.set_source (lt_source)
							modify_entry_in_class (lt_entry, l_new_entry, lt_class)
							l_done := True
						end
							-- Modify the source in the entry when the modification is done
						if l_done then
							storage.deregister_entry (lt_entry, component_id)
							lt_entry.set_source (lt_source)
							storage.register_entry (lt_entry, component_id, class_i.date)
						end
					end
				end
			end
		end

	on_tags_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On tags changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: attached EIS_ENTRY
			l_tags: attached ARRAYED_LIST [STRING_32]
			l_done: BOOLEAN
		do
			if attached {EIS_ENTRY} a_item.row.data as lt_entry and then attached a_item.text as lt_tags then
					 -- |FIXME: Bad conversion, should not convert to string_8.
				if attached lt_tags.as_string_8 as lt_tags_str_8 then
					l_tags := parse_tags (lt_tags_str_8)
					l_tags.compare_objects
				end
				if lt_entry.tags /= Void and then lt_entry.tags.is_equal (l_tags) then
						-- Do nothing when the tags is not actually changed
				else
					if entry_editable (lt_entry) then
						if attached {E_FEATURE} id_solution.feature_of_id (lt_entry.id) as lt_feature then
							if attached {EIS_ENTRY} lt_entry.twin as lt_new_entry then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_tags (l_tags)
							modify_entry_in_feature (lt_entry, l_new_entry, lt_feature)
							l_done := True
						elseif attached {CLASS_I} id_solution.class_of_id (lt_entry.id) as lt_class then
							if attached lt_entry.twin as lt_new_entry1 then
								l_new_entry := lt_new_entry1
							end
							l_new_entry.set_tags (l_tags)
							modify_entry_in_class (lt_entry, l_new_entry, lt_class)
							l_done := True
						end
							-- Modify the tags in the entry when the modification is done
						if l_done then
							storage.deregister_entry (lt_entry, component_id)
							if not l_tags.is_empty then
								lt_entry.set_tags (l_tags)
							else
								lt_entry.set_tags (Void)
							end
							storage.register_entry (lt_entry, component_id, class_i.date)
						end
					end
				end
			end
		end

	on_others_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On others changed
			-- We modify neither the referenced EIS entry when the modification is done.
		local
			l_new_entry: attached EIS_ENTRY
			l_others: attached HASH_TABLE [STRING_32, STRING_32]
			l_done: BOOLEAN
		do
			if attached {EIS_ENTRY} a_item.row.data as lt_entry and then attached a_item.text as lt_others then
				l_others := parse_others (lt_others)
				l_others.compare_objects
				if lt_entry.others /= Void and then lt_entry.others.is_equal (l_others) then
						-- Do nothing when the others is not actually changed
				else
					if entry_editable (lt_entry) then
						if attached {E_FEATURE} id_solution.feature_of_id (lt_entry.id) as lt_feature then
							if attached lt_entry.twin as lt_new_entry then
								l_new_entry := lt_new_entry
							end
							l_new_entry.set_others (l_others)
							modify_entry_in_feature (lt_entry, l_new_entry, lt_feature)
							l_done := True
						elseif attached {CLASS_I} id_solution.class_of_id (lt_entry.id) as lt_class then
							if attached lt_entry.twin as lt_new_entry1 then
								l_new_entry := lt_new_entry1
							end
							l_new_entry.set_others (l_others)
							modify_entry_in_class (lt_entry, l_new_entry, lt_class)
							l_done := True
						end
							-- Modify the others in the entry when the modification is done
						if l_done then
							storage.deregister_entry (lt_entry, component_id)
							if not l_others.is_empty then
								lt_entry.set_others (l_others)
							else
								lt_entry.set_others (Void)
							end
							storage.register_entry (lt_entry, component_id, class_i.date)
						end
					end
				end
			end
		end

	on_location_changed (a_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM; a_grid_item: EB_GRID_LISTABLE_CHOICE_ITEM): BOOLEAN
			-- On selection changed
			-- We modify neither the referenced EIS entry when the modification is done.
		require
			a_item_not_void: a_item /= Void
			a_item_not_void: a_grid_item /= Void
		local
			l_classi: CLASS_I
			l_current_feature, l_feature: E_FEATURE
			l_current_class: CLASS_I
			l_class_modifier: ES_EIS_CLASS_MODIFIER
			l_feature_modifier: ES_EIS_FEATURE_MODIFIER
			l_grid_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_eis_entry: attached EIS_ENTRY
		do
			if attached {EIS_ENTRY} a_grid_item.row.data as lt_entry then
				l_eis_entry := lt_entry
				l_classi ?= a_item.data
				l_feature ?= a_item.data
				if l_classi /= Void and then l_classi.is_equal (class_i) then
					create l_class_modifier.make (class_i)
					if l_class_modifier.is_modifiable then
						l_class_modifier.prepare
						if l_class_modifier.is_ast_available then
							l_grid_item := a_grid_item.selected_item
							if l_grid_item /= Void then
								l_current_feature ?= l_grid_item.data
							end
							if attached {E_FEATURE} l_current_feature as lt_current_feature then
								l_class_modifier.write_class_entry (l_eis_entry)
								l_class_modifier.commit
								Result := True
									-- Remove the eis from current feature.
								remove_entry_in_feature (l_eis_entry, lt_current_feature)
									-- Change the id of the entry
								storage.deregister_entry (l_eis_entry, component_id)
								l_eis_entry.set_id (component_id)
								storage.register_entry (l_eis_entry, component_id, class_i.date)
							end
						else
							prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
						end
					else
						prompts.show_error_prompt (interface_names.l_class_is_not_editable, Void, Void)
					end
				elseif attached {E_FEATURE} l_feature as lt_feature and then lt_feature.written_class.lace_class.is_equal (class_i) then
					create l_feature_modifier.make (lt_feature, class_i)
					l_feature_modifier.prepare
					if l_feature_modifier.is_modifiable then
						if l_feature_modifier.is_ast_available then
							l_grid_item := a_grid_item.selected_item
							if l_grid_item /= Void then
								l_current_feature ?= l_grid_item.data
								l_current_class ?= l_grid_item.data
							end
							if l_current_class /= Void or l_current_feature /= Void then
								l_feature_modifier.write_feature_entry (l_eis_entry)
								l_feature_modifier.commit
								Result := True

								if attached {E_FEATURE} l_current_feature as lt_current_feature1 then
										-- Remove the eis from current feature.
									remove_entry_in_feature (l_eis_entry, lt_current_feature1)
								elseif attached {CLASS_I} l_current_class as lt_current_class then
									remove_entry_in_class (l_eis_entry, lt_current_class)
								end
										-- Change the id of the entry
								storage.deregister_entry (l_eis_entry, component_id)
								l_eis_entry.set_id (id_solution.id_of_feature (lt_feature))
								storage.register_entry (l_eis_entry, component_id, class_i.date)
							end
						else
							prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
						end
					else
						prompts.show_error_prompt (interface_names.l_class_is_not_editable, Void, Void)
					end
				end
			end
		end

note
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
