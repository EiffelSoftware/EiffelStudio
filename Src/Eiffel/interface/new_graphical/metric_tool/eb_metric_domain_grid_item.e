indexing
	description: "Grid item to display a domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DOMAIN_GRID_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			activate_action,
			deactivate
		end

	EVS_BORDERED
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_CONSTANTS
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			default_create,
			copy,
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature{NONE} -- Initialization

	make (a_domain: like domain) is
			-- Initialize `domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			default_create
			setting_change_actions.extend (agent on_setting_change)

			create ellipsis_actions
			create dialog
			create width_change_actions
			create dialog_ok_actions
			create dialog_cancel_actions
			create show_dialog_actions
			create hide_dialog_actions

			set_domain (a_domain)
			expose_actions.extend (agent perform_redraw)
			dialog.ok_actions.extend (agent on_ok)
			dialog.cancel_actions.extend (agent on_cancel)
			dialog.show_actions.extend (agent on_show)
			dialog.hide_actions.extend (agent on_hide)
			ellipsis_actions.extend (agent show_dialog)
		ensure
			ellipsis_actions_attached: ellipsis_actions /= Void
			width_change_actions_attached: width_change_actions /= Void
			dialog_ok_actions_attached: dialog_ok_actions /= Void
			dialog_cancel_actions_attached: dialog_cancel_actions /= Void
			show_dialog_actions_attached: show_dialog_actions /= Void
			hide_dialog_actions: hide_dialog_actions /= Void
		end

feature -- Access

	domain: EB_METRIC_DOMAIN
			-- Domain displayed in current item

	padding: INTEGER
			-- Padding (in pixels) between every domain item

	spacing: INTEGER
			-- Spacing (in pixels) between a pixmap and a text

	font: EV_FONT
			-- Typeface appearance for `Current'.

	dialog: EB_METRIC_DOMAIN_PROPERTY_DIALOG
			-- Dialog to display domain in detail

	width_change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when width of current item changes

	dialog_ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when OK button in `dialog' is pressed

	dialog_cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Cancel button in `dialog' is pressed

	show_dialog_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `dialog' is shown

	hide_dialog_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `dialog' is hiden

feature -- Status report

	is_activated: BOOLEAN
			-- Is the property activated?

	has_focus: BOOLEAN is
			-- Does this property have the focus?
		require
			is_activated
		do
			Result := domain_field.has_focus or button.has_focus
		end

	is_pebble_droppable (a_pebble: ANY): BOOLEAN is
			-- Can `a_pebble' be dropped on Current?
		local
			l_stone: STONE
			l_domain_item: EB_METRIC_DOMAIN_ITEM
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
					-- Pebble is a stone.
				l_domain_item := metric_domain_item_from_stone (l_stone)
				if l_domain_item /= Void then
					domain.compare_objects
					Result := (not domain.has (l_domain_item)) and then (not domain.has_delayed_domain_item)
				end
			end
		end

feature -- Access

	button: EV_BUTTON
			-- Ellipsis button used to edit `Current' on activate.
			-- Void when `Current' isn't being activated.

	domain_field: EV_DRAWING_AREA
			-- Domain field used to display domain on activate.
			-- Void when `Current' isn't being activated.

	popup_window: EV_POPUP_WINDOW
			-- Popup window used on activate.
			-- Void when `Current' isn't beeing activated.					

	parent_window: EV_WINDOW is
			-- Return the parent window (if any), where the property has been put.
		local
			l_parent: EV_CONTAINER
		do
			from
				l_parent := parent
			until
				Result /= Void or l_parent = Void
			loop
				Result ?= l_parent
				l_parent := l_parent.parent
			end
		end

feature -- Setting

	set_domain (a_domain: like domain) is
			-- Set `domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			lock_update
			domain := a_domain.twin
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			domain_set: domain.is_equivalent (a_domain)
		end

	set_padding (a_padding: INTEGER) is
			-- Set `padding' with `a_padding'.
		require
			a_padding_non_negative: a_padding >= 0
		do
			lock_update
			padding := a_padding
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			padding_set: padding = a_padding
		end

	set_spacing (a_spacing: INTEGER) is
			-- Set `spacing' with `a_spacing'.
		require
			a_spacing_non_negative: a_spacing >= 0
		do
			lock_update
			spacing := a_spacing
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			spacing_set: spacing = a_spacing
		end

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			lock_update
			font := a_font
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			font_assigned: font = a_font
		end

	show_dialog is
			-- Show text editor.
		require
			parent_window: parent_window /= Void
			popup_window: popup_window /= Void
			activated: is_activated
		local
			l_version: BOOLEAN_REF
		do
			if dialog.value = Void then
				dialog.set_value ([domain, False])
			else
				l_version ?= dialog.value.item (2)
				check l_version /= Void end
				dialog.set_value ([domain, l_version.item])
			end
			dialog.show_relative_to_window (parent_window)
			dialog.set_focus
		end

	add_pebble (a_pebble: ANY; a_agent: PROCEDURE [ANY, TUPLE]) is
			-- Add domain item contained in `a_pebble' if any.
			-- If `a_pebble' is added successfully, call `a_agent' is it's not Void.
		local
			l_stone: STONE
			l_target_stone: TARGET_STONE
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_feature_stone: FEATURE_STONE
			l_domain: EB_METRIC_DOMAIN
			l_domain_item: EB_METRIC_DOMAIN_ITEM
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
					-- Pebble is a stone.
				l_target_stone ?= a_pebble
				l_classi_stone ?= a_pebble
				l_cluster_stone ?= a_pebble
				l_feature_stone ?= a_pebble
				if l_target_stone /= Void or l_classi_stone /= Void or l_cluster_stone /= Void or l_feature_stone /= Void then
					l_domain_item := metric_domain_item_from_stone (l_stone)
					l_domain := domain
					l_domain.compare_objects
					if not l_domain.has (l_domain_item) then
						l_domain.extend (l_domain_item)
						set_domain (l_domain)
						if a_agent /= Void then
							a_agent.call ([])
						end
					end
				end
			end
		end

feature{NONE} -- Implementation

	perform_redraw_internal (a_drawable: EV_DRAWABLE; a_focused: BOOLEAN; a_selected: BOOLEAN) is
			-- Draw current in `a_drawable'.
			-- If `a_focused' is True, draw in focused status, if `a_selected' is True, draw in selected status.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_x, l_y: INTEGER
			l_parent: like parent
			l_font: EV_FONT
			l_pixmap: EV_PIXMAP
			l_text: STRING
			l_spacing: INTEGER
			l_padding: INTEGER
			l_class: EB_METRIC_CLASS_DOMAIN_ITEM
			l_feature: EB_METRIC_FEATURE_DOMAIN_ITEM
			l_item: EB_METRIC_DOMAIN_ITEM
		do
			l_parent := parent
			l_spacing := spacing
			l_padding := padding
				-- Clear item region and draw selection if selected.
			if a_selected then
				if a_focused then
					a_drawable.set_foreground_color (parent.focused_selection_color)
				else
					a_drawable.set_foreground_color (parent.non_focused_selection_color)
				end
			else
				if background_color/= Void then
					a_drawable.set_foreground_color (background_color)
				elseif row.background_color /= Void then
					a_drawable.set_foreground_color (row.background_color)
				else
					a_drawable.set_foreground_color (l_parent.background_color)
				end
			end
			a_drawable.fill_rectangle (0, 0, width, height)

			if font /= Void then
				l_font := font
			else
				create l_font
			end
			a_drawable.set_font (l_font)
			if l_font.height + top_border + bottom_border > height then
				l_y := (height - l_font.height) // 2
				if l_y < 0 then
					l_y := 0
				end
			else
				l_y := top_border
			end
			l_x := left_border
			from
				domain.start
			until
				domain.after
			loop
				l_item := domain.item
				l_pixmap := pixmap_of_domain_item (l_item)
				a_drawable.draw_pixmap (l_x, l_y, l_pixmap)
				l_x := l_x + l_pixmap.width
				l_x := l_x + spacing
				if l_item.is_feature_item and then l_item.is_valid then
					l_feature ?= domain.item

					l_text := ti_l_curly
					a_drawable.set_foreground_color (color_of_domain_item (Void))
					a_drawable.draw_text_top_left (l_x, l_y, l_text)
					l_x := l_x + l_font.string_width (l_text)

					l_class := l_feature.class_domain_item
					l_text := l_class.string_representation
					a_drawable.set_foreground_color (color_of_domain_item (l_class))
					a_drawable.draw_text_top_left (l_x, l_y, l_text)
					l_x := l_x + l_font.string_width (l_text)

					l_text := ti_r_curly
					a_drawable.set_foreground_color (color_of_domain_item (Void))
					a_drawable.draw_text_top_left (l_x, l_y, l_text)
					l_x := l_x + l_font.string_width (l_text)

					l_text := ti_dot
					a_drawable.set_foreground_color (color_of_domain_item (Void))
					a_drawable.draw_text_top_left (l_x, l_y, l_text)
					l_x := l_x + l_font.string_width (l_text)

				end
				l_text := l_item.string_representation
				a_drawable.set_foreground_color (color_of_domain_item (domain.item))
				a_drawable.draw_text_top_left (l_x, l_y, l_text)
				l_x := l_x + l_font.string_width (l_text)
				l_x := l_x + padding
				domain.forth
			end
		end

	perform_redraw (a_drawable: EV_DRAWABLE) is
			-- Perform redraw on `a_drawable'.
		require
			a_drawable_attached: a_drawable /= Void
		do
			perform_redraw_internal (a_drawable, parent.has_focus, is_selected)
		end

	required_width_internal: INTEGER is
			-- Required width in pixels
		local
			l_font: EV_FONT
			l_class: EB_METRIC_CLASS_DOMAIN_ITEM
			l_feature: EB_METRIC_FEATURE_DOMAIN_ITEM
			l_item: EB_METRIC_DOMAIN_ITEM
		do
			if font /= Void then
				l_font := font
			else
				create l_font
			end
			Result := left_border + right_border
			from
				domain.start
			until
				domain.after
			loop
				l_item := domain.item
				Result := Result + pixmap_of_domain_item (l_item).width
				Result := Result + spacing
				if l_item.is_feature_item then
					l_feature ?= l_item
					if l_feature.is_valid then
						l_class := l_feature.class_domain_item
						Result := Result + l_font.string_width (l_class.string_representation + ".")
					else
						Result := Result + l_font.string_width (l_feature.string_representation)
					end
				end
				Result := Result + l_font.string_width (domain.item.string_representation)
				if domain.index /= domain.count then
					Result := Result + padding
				end
				domain.forth
			end
		end

	is_position_up_to_date: BOOLEAN
			-- Is position to draw current up-to-date?

	color_of_domain_item (a_domain_item: EB_METRIC_DOMAIN_ITEM): EV_COLOR is
			-- Color for `a_domain_item'
		require
			item_parented: is_parented
		local
			l_class: EDITOR_TOKEN_CLASS
			l_feature: EDITOR_TOKEN_FEATURE
			l_symbol: EDITOR_TOKEN_OPERATOR
		do
			if not is_selected then
				if a_domain_item /= Void then
					if not a_domain_item.is_valid then
						Result := colors.red
					else
						if
							a_domain_item.is_target_item or
							a_domain_item.is_delayed_item or
							a_domain_item.is_folder_item or
							a_domain_item.is_group_item
						then
							Result := colors.black
						elseif a_domain_item.is_class_item then
							create l_class.make ("")
							Result := l_class.text_color
						elseif a_domain_item.is_feature_item then
							create l_feature.make ("")
							Result := l_feature.text_color
						end
					end
				else
					create l_symbol.make ("")
					Result := l_symbol.text_color
				end
			else
				if parent.has_focus then
					Result := colors.white
				else
					Result := colors.black
				end
			end
		ensure
			result_attached: Result /= Void
		end

	pixmap_of_domain_item (a_domain_item: EB_METRIC_DOMAIN_ITEM): EV_PIXMAP is
			-- Pixmap of `a_domain_item'			
		require
			a_domain_item_attached: a_domain_item /= Void
		local
			l_class: EB_METRIC_CLASS_DOMAIN_ITEM
			l_feature: EB_METRIC_FEATURE_DOMAIN_ITEM
			l_group: EB_METRIC_GROUP_DOMAIN_ITEM
			l_folder: EB_METRIC_FOLDER_DOMAIN_ITEM
			l_eb_folder: EB_FOLDER
			l_ql_feature: QL_FEATURE
		do
			if not a_domain_item.is_valid then
				Result := pixmaps.icon_pixmaps.general_error_icon
			else
				if a_domain_item.is_target_item then
					Result := pixmaps.icon_pixmaps.metric_unit_target_icon
				elseif a_domain_item.is_delayed_item then
					Result := pixmaps.icon_pixmaps.metric_domain_delayed_icon
				elseif a_domain_item.is_class_item then
					l_class ?= a_domain_item
					Result := pixmap_from_class_i (l_class.ql_class.class_i)
				elseif a_domain_item.is_feature_item then
					l_feature ?= a_domain_item
					l_ql_feature := l_feature.ql_feature
					if l_ql_feature.is_real_feature then
						Result := pixmap_from_e_feature (l_ql_feature.e_feature)
					else
						Result := pixmaps.icon_pixmaps.class_features_invariant_icon
					end
				elseif a_domain_item.is_group_item then
					l_group ?= a_domain_item
					Result := pixmap_from_group (l_group.ql_group.group)
				elseif a_domain_item.is_folder_item then
					l_folder ?= a_domain_item
					l_eb_folder := l_folder.folder
					Result := pixmap_from_group_path (l_eb_folder.cluster, l_eb_folder.path)
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Actions

	on_setting_change is
			-- Action to be performed when setting changes
		do
			if not is_destroyed then
				set_required_width (required_width_internal)
			end
			if is_parented then
				redraw
			end
		end

	on_cancel is
			-- Action to be performed when "Cancel" button is pressed in `dialog'
		do
			dialog_cancel_actions.call ([])
		end

	on_show is
			-- Action to be performed when `dialog' is shown.
		do
			show_dialog_actions.call ([])
		end

	on_hide is
			-- Action to be performed when `dialog' is hidden.		
		do
			hide_dialog_actions.call ([])
			deactivate
		end

	on_ok is
			-- Action to be performed when "OK" button is pressed in `dialog'
		local
			l_domain: EB_METRIC_DOMAIN
		do
			l_domain ?= dialog.value.item (1)
			check l_domain /= Void end
			set_domain (l_domain)
			dialog_ok_actions.call ([])
		end

feature -- Events

	ellipsis_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the ellipsis button is pressed.

feature {NONE} -- Implementation

	colors: EV_STOCK_COLORS is
			-- Color factory
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	ellipsis: EV_PIXMAP is
			-- Icon for ellipsis
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (8, 2)
			Result.fill_rectangle (0, 0, 2, 2)
			Result.fill_rectangle (3, 0, 2, 2)
			Result.fill_rectangle (6, 0, 2, 2)

			create l_mask.make_with_size (8, 2)
			l_mask.fill_rectangle (0, 0, 2, 2)
			l_mask.fill_rectangle (3, 0, 2, 2)
			l_mask.fill_rectangle (6, 0, 2, 2)

			Result.set_mask (l_mask)
		ensure
			Result_set: Result /= Void
		end

	initialize_actions is
			-- Setup the actions sequences when the item is shown.
		do
			button.set_focus
			button.focus_out_actions.extend (agent focus_lost)
			button.select_actions.append (ellipsis_actions)
		end

	focus_lost is
			-- Check if no other element in the popup has the focus.
		do
			if is_activated and then not has_focus then
				deactivate
			end
		end

	activate_action (a_popup_window: EV_POPUP_WINDOW) is
			-- Activate action.
		local
			l_hb: EV_HORIZONTAL_BOX
		do
			popup_window := a_popup_window
			popup_window.set_background_color (implementation.displayed_background_color)


			create domain_field
			perform_redraw_internal (domain_field, False, False)

			create l_hb
			l_hb.extend (domain_field)

			create button
			button.set_pixmap (ellipsis)
			l_hb.extend (button)
			l_hb.disable_item_expand (button)
			button.set_minimum_height (popup_window.height-1)

			popup_window.extend (l_hb)

			popup_window.show_actions.extend (agent initialize_actions)
			popup_window.set_x_position (popup_window.x_position + 1)
			popup_window.set_size (popup_window.width - 1, popup_window.height -1 )
			is_activated := True
		ensure then
			is_activated: is_activated
		end

	deactivate is
			-- Cleanup from previous call to `activate'.
		do
			Precursor
			if button /= Void then
				button.focus_out_actions.wipe_out
				button.destroy
				button := Void
			end
			if domain_field /= Void then
				domain_field.destroy
				domain_field := Void
			end
			is_activated := False
			if not parent.is_destroyed then
				parent.set_focus
			end
		ensure then
			button_void: button = Void
			domain_field_void: domain_field = Void
			not_activated: not is_activated
		end

invariant
	ellipsis_actions_not_void: is_initialized implies ellipsis_actions /= Void
	active_elements: is_activated implies button /= Void and domain_field /= Void
	domain_attached: domain /= Void
	width_change_actions_attached: width_change_actions /= Void
	dialog_ok_actions_attached: dialog_ok_actions /= Void
	dialog_cancel_actions_attached: dialog_cancel_actions /= Void
	show_dialog_actions_attached: show_dialog_actions /= Void
	hide_dialog_actions: hide_dialog_actions /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
