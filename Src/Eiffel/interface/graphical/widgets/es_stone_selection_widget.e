indexing
	description: "[
			A EiffelStudio stone history widget.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STONE_SELECTION_WIDGET

inherit
	ES_STONABLE_WIDGET [EV_VERTICAL_BOX]

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

convert
	widget: {EV_WIDGET, attached EV_WIDGET}

feature {NONE} -- User interface initialization

	build_widget_interface (a_widget: attached EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_icon: EV_PIXMAP
			l_class_label: EV_LABEL
			l_cluster_label: EV_LABEL
			l_feature_label: EV_LABEL
			l_completion_widget: COMPLETABLE_TEXT_FIELD
			l_hbox: EV_HORIZONTAL_BOX
			l_width: INTEGER
		do
			a_widget.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create l_cluster_label.make_with_text (locale_formatter.translation (l_cluster) + ":")
			create l_class_label.make_with_text (locale_formatter.translation (l_class) + ":")
			create l_feature_label.make_with_text (locale_formatter.translation (l_feature) + ":")

			l_width := helpers.maximum_string_width (<<
					l_cluster_label.text,
					l_class_label.text,
					l_feature_label.text>>, l_class_label.font) + {ES_UI_CONSTANTS}.cell_horizontal_separator_height

				-- Cluster drop down list
			create l_icon.make_with_pixel_buffer (stock_pixmaps.folder_cluster_icon_buffer)

			l_cluster_label.set_minimum_width (l_width)
			l_cluster_label.align_text_right

			create cluster_drop_down.make (create {EV_COMBO_BOX}, agent is_valid_identifier (?, True), agent {attached STRING_32}.as_lower)
			cluster_drop_down.set_minimum_width (250)
			cluster_drop_down.widget.set_foreground_color (preferences.editor_data.cluster_text_color)
			register_action (cluster_drop_down.widget.change_actions, agent on_cluster_text_changed)
			auto_recycle (cluster_drop_down)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_hbox.extend (l_cluster_label)
			l_hbox.extend (l_icon)
			l_hbox.disable_item_expand (l_icon)
			l_hbox.extend (cluster_drop_down)
			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)

				-- Class drop down list
			create l_icon.make_with_pixel_buffer (stock_pixmaps.class_normal_icon_buffer)

			l_class_label.set_minimum_width (l_width)
			l_class_label.align_text_right

			create l_completion_widget
			register_kamikaze_action (l_completion_widget.focus_in_actions, agent (ia_widget: COMPLETABLE_TEXT_FIELD)
				do
					ia_widget.set_completion_possibilities_provider (class_completion_provider)
					ia_widget.possibilities_provider.set_code_completable (ia_widget)
					ia_widget.set_parent_window (helpers.widget_top_level_window (ia_widget, False))
				end (l_completion_widget))

			create class_drop_down.make (l_completion_widget, agent is_valid_identifier (?, False), agent {attached STRING_32}.as_upper)
			class_drop_down.set_minimum_width (250)
			class_drop_down.widget.set_foreground_color (preferences.editor_data.class_text_color)
			register_action (class_drop_down.widget.change_actions, agent on_class_text_changed)
			auto_recycle (class_drop_down)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_hbox.extend (l_class_label)
			l_hbox.extend (l_icon)
			l_hbox.disable_item_expand (l_icon)
			l_hbox.extend (class_drop_down)
			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)

				-- Feature drop down list
			create l_icon.make_with_pixel_buffer (stock_pixmaps.feature_routine_icon_buffer)

			l_feature_label.set_minimum_width (l_width)
			l_feature_label.align_text_right

			create feature_drop_down.make (create {EV_COMBO_BOX}, agent is_valid_identifier (?, False), agent {attached STRING_32}.as_lower)
			feature_drop_down.set_minimum_width (250)
			feature_drop_down.widget.set_foreground_color (preferences.editor_data.feature_text_color)
			register_action (feature_drop_down.widget.change_actions, agent on_feature_text_changed)
			auto_recycle (feature_drop_down)

			feature_drop_down.is_sensitive := False

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_hbox.extend (l_feature_label)
			l_hbox.extend (l_icon)
			l_hbox.disable_item_expand (l_icon)
			l_hbox.extend (feature_drop_down)
			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)
		end

feature {NONE} -- User interface elements

	cluster_drop_down: attached ES_FORMATTING_WRAPPED_WIDGET [EV_TEXT_FIELD]
			-- Cluster history combo box

	class_drop_down: attached ES_FORMATTING_WRAPPED_WIDGET [EV_TEXT_FIELD]
			-- Class history combo box

	feature_drop_down: attached ES_FORMATTING_WRAPPED_WIDGET [EV_TEXT_FIELD]
			-- Feature history combo box

	class_completion_provider: attached EB_METRIC_CRITERION_PROVIDER
		local
			l_names: SORTABLE_ARRAY [NAME_FOR_COMPLETION]
			l_name: EB_CLASS_FOR_COMPLETION
			l_classes: DS_HASH_SET [CLASS_I]
			i: INTEGER
		do
			if workbench.system_defined then
				l_classes := workbench.universe.all_classes
				create l_names.make (1, l_classes.count)
				from l_classes.start until l_classes.after loop
					create l_name.make (l_classes.item_for_iteration)
					--if l_classes.item_for_iteration.is_compiled then
						i := i + 1
						l_names.put (l_name, i)
					--end
					l_classes.forth
				end
				l_names.sort
			else
				create l_names.make (1, 0)
			end
			create Result.make (l_names)
		end

feature {NONE} -- Status report

	is_valid_identifier (a_text: attached STRING_32; a_accept_qualifier: BOOLEAN): BOOLEAN
		local
			l_parts: LIST [STRING_32]
			l_part: STRING_32
			l_count, i: INTEGER
			uc: CHARACTER_32
			c: CHARACTER_8
		do
			if not a_text.is_empty then
				if a_accept_qualifier then
					l_parts := a_text.split ('.')
					l_parts.compare_objects
					if not l_parts.has ("") then
						Result := True
						from l_parts.start until l_parts.after or Result loop
							l_part := l_parts.item
							if l_part /= Void then
								Result := is_valid_identifier (l_part, False)
							end
							l_parts.forth
						end
					end
				else
					Result := True
					from
						i := 1
						l_count := a_text.count
					until
						i > l_count or not Result
					loop
						uc := a_text.item (i)
						Result := uc.is_character_8
						if Result then
							c := uc.to_character_8
							Result := c.is_alpha or else c = '*'
							if not Result and then i > 1 then
								Result := c.is_digit or else c = '_'
							end
							i := i + 1
						end
					end
				end
			else
				Result := True
			end
		end

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := attached {CLUSTER_STONE} a_stone or else
				attached {CLASSI_STONE} a_stone
		end

feature -- Basic operations

	select_group_field (a_select: BOOLEAN)
			-- Sets focus to the groups field.
			--
			-- `a_select': True to select the entire field contents; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			select_field_internal (cluster_drop_down.widget, a_select)
		end

	select_class_field (a_select: BOOLEAN)
			-- Sets focus to the class field.
			--
			-- `a_select': True to select the entire field contents; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			select_field_internal (class_drop_down.widget, a_select)
		end

	select_feature_field (a_select: BOOLEAN)
			-- Sets focus to the feature field.
			--
			-- `a_select': True to select the entire field contents; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if feature_drop_down.is_sensitive then
				select_field_internal (feature_drop_down.widget, a_select)
			else
					-- There needs to be a class first so we select the class field.
				select_class_field (a_select)
			end
		end

feature {NONE} -- Basic operations

	select_field_internal (a_widget: attached EV_TEXT_COMPONENT; a_select: BOOLEAN)
			-- Sets focus to the field.
			--
			-- `a_select': True to select the entire field contents; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if cluster_drop_down.widget /= a_widget then
				cluster_drop_down.widget.deselect_all
			end
			if class_drop_down.widget /= a_widget then
				class_drop_down.widget.deselect_all
			end
			if feature_drop_down.widget /= a_widget and feature_drop_down.is_sensitive then
				feature_drop_down.widget.deselect_all
			end
			a_widget.set_focus
			if a_select then
				if a_widget.text_length > 0 then
					a_widget.select_all
				end
			else
				a_widget.deselect_all
				a_widget.set_caret_position (a_widget.text_length)
			end
		end

feature {NONE} -- Action handlers

	on_handle_default_key (a_widget: attached EV_TEXTABLE; a_accept_qualifier: BOOLEAN; a_key: EV_KEY): BOOLEAN
			-- Called when the combo text changes.
		require
			is_interface_usable: is_interface_usable
		local
			l_text: STRING
		do
			Result := True
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter or else a_key.code = {EV_KEY_CONSTANTS}.key_tab then
				l_text := a_widget.text
				if l_text.occurrences ('*') > 0 then
						-- Complete wildcard
					Result := False
				end
			end
		end

	on_cluster_text_changed
			-- Called when the cluster combo text changes.
		require
			is_interface_usable: is_interface_usable
		local
--			l_text: STRING_32
--			l_formatted_text: STRING_32
--			l_pos: INTEGER
		do
--			l_text := cluster_drop_down.text
--			if l_text /= Void and then not l_text.is_empty then
--				l_formatted_text := l_text.as_lower
--				if l_formatted_text /= Void and then not l_formatted_text.same_string (l_text) then
--					l_pos := cluster_drop_down.caret_position
--					cluster_drop_down.set_text (l_formatted_text)
--					cluster_drop_down.set_caret_position (l_pos)
--				end
--			end
		end

	on_class_text_changed
			-- Called when the class combo text changes.
		require
			is_interface_usable: is_interface_usable
		local
--			l_text: STRING_32
--			l_formatted_text: STRING_32
--			l_pos: INTEGER
--			l_color: EV_COLOR
		do
			feature_drop_down.is_sensitive := not class_drop_down.text.is_empty
		end

	on_feature_text_changed
			-- Called when the feature combo text changes.
		require
			is_interface_usable: is_interface_usable
		local
--			l_text: STRING_32
--			l_formatted_text: STRING_32
--			l_pos: INTEGER
		do
--			l_text := feature_drop_down.text
--			if l_text /= Void and then not l_text.is_empty then
--				l_formatted_text := l_text.as_lower
--				if l_formatted_text /= Void and then not l_formatted_text.same_string (l_text) then
--					l_pos := feature_drop_down.caret_position
--					feature_drop_down.set_text (l_formatted_text)
--					feature_drop_down.set_caret_position (l_pos)
--				end
--			end
		end

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		local
			l_group_text: detachable STRING_32
			l_class_text: detachable STRING_32
			l_feature_text: detachable STRING_32
		do
			if attached {CLUSTER_STONE} stone as l_cluster_stone then
				create l_group_text.make_from_string (l_cluster_stone.group.name)
			elseif attached {CLASSI_STONE} stone as l_class_stone then
				create l_group_text.make_from_string (l_class_stone.group.name)
				create l_class_text.make_from_string (l_class_stone.class_name)
				if attached {FEATURE_STONE} stone as l_feature_stone then
					create l_feature_text.make_from_string (l_feature_stone.feature_name)
				end
			end
			if l_group_text = Void then
				create l_group_text.make_empty
			end
			cluster_drop_down.text := l_group_text
			if l_class_text = Void then
				create l_class_text.make_empty
			end
			class_drop_down.text := l_class_text
			if l_feature_text = Void then
				create l_feature_text.make_empty
			end
			feature_drop_down.text := l_feature_text
		end

feature {NONE} -- Factory

	create_widget: attached EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	l_cluster: STRING = "Cluster"
	l_class: STRING = "Class"
	l_feature: STRING = "Feature"

;indexing
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
