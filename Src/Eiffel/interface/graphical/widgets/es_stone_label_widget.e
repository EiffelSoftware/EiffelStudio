note
	description: "[
		A widget to display linked label for groups/classes/features.
		
		Typically, with all options on, the label will display (group) (class) (feature) labels,
		which can be clicked to display a stone selection window.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STONE_LABEL_WIDGET

inherit
	ES_STONABLE_WIDGET [EV_HORIZONTAL_BOX]
		redefine
			on_before_initialize
		end

create
	make

convert
	widget: {EV_WIDGET, EV_HORIZONTAL_BOX}

feature {NONE} -- User interface initialization

	build_widget_interface (a_widget: attached EV_HORIZONTAL_BOX)
			-- <Precursor>
		do
			a_widget.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create groups_label.make_with_text (locale_formatter.translation (l_default_group))
			groups_label.set_foreground_color (preferences.editor_data.cluster_text_color)
			register_action (groups_label.select_actions, agent on_group_selected)
			a_widget.extend (groups_label)
			--a_widget.disable_item_expand (groups_label)
			if not is_group_shown then
				groups_label.hide
			end

			create class_label.make_with_text (locale_formatter.translation (l_default_class))
			class_label.set_foreground_color (preferences.editor_data.class_text_color)
			register_action (class_label.select_actions, agent on_class_selected)
			a_widget.extend (class_label)
			--a_widget.disable_item_expand (class_label)
			if not is_class_shown then
				class_label.hide
			end

			create feature_label.make_with_text (locale_formatter.translation (l_default_feature))
			feature_label.set_foreground_color (preferences.editor_data.feature_text_color)
			register_action (feature_label.select_actions, agent on_feature_selected)
			a_widget.extend (feature_label)
			--a_widget.disable_item_expand (feature_label)
			if not is_feature_shown then
				feature_label.hide
			end
		end

	on_before_initialize
			-- <Precursor>
		do
				-- Ensure all labels are shown by default
			is_group_shown := True
			is_class_shown := True
			is_feature_shown := True

			Precursor
		end

feature -- Access

	current_group: detachable CONF_GROUP
			-- The current group.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			if attached {CLUSTER_STONE} stone as l_cluster then
				Result := l_cluster.cluster_i
			elseif attached current_class as l_class then
				Result := l_class.group
			end
		end

	current_class: detachable CLASS_I
			-- The current class.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			if attached {CLASSI_STONE} stone as l_class then
				Result := l_class.class_i
			end
		end

	current_feature: detachable E_FEATURE
			-- The current feature.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			if attached {FEATURE_STONE} stone as l_feature then
				Result := l_feature.e_feature
			end
		end

feature -- Status report

	is_group_shown: BOOLEAN assign set_is_group_shown
			-- Indicates if the group label should be shown.

	is_class_shown: BOOLEAN assign set_is_class_shown
			-- Indicates if the class label should be shown.

	is_feature_shown: BOOLEAN assign set_is_feature_shown
			-- Indicates if the feature label should be shown.

feature {NONE} -- Status report

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := (is_class_shown and then attached {CLASSI_STONE} a_stone) or else
				(is_feature_shown and then attached {FEATURE_STONE} a_stone) or else
				(is_group_shown and then attached {CLUSTER_STONE} a_stone)
		end

feature -- Status setting

	set_is_group_shown (a_show: BOOLEAN)
			-- Sets show state of the groups label.
			--
			-- `a_show': True to show the groups label; False otherwise.
		require
			is_interface_usable: is_interface_usable
		do
			is_group_shown := a_show
			if is_initialized then
				if a_show then
					groups_label.show
				else
					groups_label.hide
				end
			end
		ensure
			is_group_shown_set: is_group_shown = a_show
			groups_label_is_displayed_set: is_initialized implies (groups_label.is_displayed = a_show or else groups_label.is_show_requested = a_show)
		end

	set_is_class_shown (a_show: BOOLEAN)
			-- Sets show state of the class' label.
			--
			-- `a_show': True to show the class' label; False otherwise.
		require
			is_interface_usable: is_interface_usable
		do
			is_class_shown := a_show
			if is_initialized then
				if a_show then
					class_label.show
				else
					class_label.hide
				end
			end
		ensure
			is_class_shown_set: is_class_shown = a_show
			classs_label_is_displayed_set: is_initialized implies (class_label.is_displayed = a_show or else class_label.is_show_requested = a_show)
		end

	set_is_feature_shown (a_show: BOOLEAN)
			-- Sets show state of the features label.
			--
			-- `a_show': True to show the features label; False otherwise.
		require
			is_interface_usable: is_interface_usable
		do
			is_feature_shown := a_show
			if is_initialized then
				if a_show then
					feature_label.show
				else
					feature_label.hide
				end
			end
		ensure
			is_feature_shown_set: is_feature_shown = a_show
			features_label_is_displayed_set: is_initialized implies (feature_label.is_displayed = a_show or else feature_label.is_show_requested = a_show)
		end

feature {NONE} -- Basic operations

	show_stone_selection_popup
			-- Displays the selection pop-up widget.
		local
			l_window: ES_POPUP_WIDGET_WINDOW
			l_widget: ES_STONE_SELECTION_WIDGET
		do
			create l_widget.make
			create l_window.make (l_widget, True, False)
			l_window.show_relative_to_widget (widget, 0, height, 0, 0)
		end

feature {NONE} -- User interface elements

	groups_label: attached EV_HIGHLIGHT_LINK_LABEL
			-- Group label.

	class_label: attached EV_HIGHLIGHT_LINK_LABEL
			-- Class label.

	feature_label: attached EV_HIGHLIGHT_LINK_LABEL
			-- Feature label.

	stone_selection_widget: attached ES_STONE_SELECTION_WIDGET
			-- Widget used to select a stone.
		require
			is_interface_usable: is_interface_usable
		attribute
			create Result.make
		end

	stone_selection_window: attached ES_POPUP_WIDGET_WINDOW
			-- Window used to display the stone selection widget.
		require
			is_interface_usable: is_interface_usable
		attribute
			create Result.make (stone_selection_widget, False, True)
			Result.is_focus_sensitive := False
		end

feature {NONE} -- Action handler

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		do
			if attached {CLASSI_STONE} stone as l_class then
				groups_label.set_text (l_class.group.name)
				class_label.set_text (l_class.class_name)
				if attached {FEATURE_STONE} l_class as l_feature then
					feature_label.set_text (l_feature.feature_name)
				end
			elseif attached {CLUSTER_STONE} stone as l_cluster then
				groups_label.set_text (l_cluster.cluster_i.cluster_name)
				class_label.set_text (l_default_class)
				feature_label.set_text (l_default_feature)
			else
				groups_label.set_text (l_default_group)
				class_label.set_text (l_default_class)
				feature_label.set_text (l_default_feature)
			end
		end

	on_group_selected
			-- Called when the group label is selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_group_shown: is_group_shown
		local
			l_window: like stone_selection_window
			l_widget: like stone_selection_widget
		do
			l_window := stone_selection_window
			l_widget := stone_selection_widget
			if l_widget.stone /~ stone then
				l_widget.set_stone_with_query (stone)
			end
			if not l_window.is_shown then
				l_window.show_relative_to_widget (widget, 0, height, 0, 0)
			end
			l_widget.select_group_field (True)
		end

	on_class_selected
			-- Called when the class label is selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_class_shown: is_class_shown
		local
			l_window: like stone_selection_window
			l_widget: like stone_selection_widget
		do
			l_window := stone_selection_window
			l_widget := stone_selection_widget
			if l_widget.stone /~ stone then
				l_widget.set_stone_with_query (stone)
			end
			if not l_window.is_shown then
				l_window.show_relative_to_widget (widget, 0, height, 0, 0)
			end
			l_widget.select_class_field (True)
		end

	on_feature_selected
			-- Called when the feature label is selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_feature_shown: is_feature_shown
		local
			l_window: like stone_selection_window
			l_widget: like stone_selection_widget
		do
			l_window := stone_selection_window
			l_widget := stone_selection_widget
			if l_widget.stone /~ stone then
				l_widget.set_stone_with_query (stone)
			end
			if not l_window.is_shown then
				l_window.show_relative_to_widget (widget, 0, height, 0, 0)
			end
			l_widget.select_feature_field (True)
		end

feature {NONE} -- Factory

	create_widget: attached EV_HORIZONTAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	l_default_group: STRING = "(Group)"
	l_default_class: STRING = "(Class)"
	l_default_feature: STRING = "(Feature)"

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
