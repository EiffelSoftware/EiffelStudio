note
	description: "Viewpoint area used in class and feature tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_VIEWPOINT_AREA

inherit
	EB_CONSTANTS

	EB_SHARED_WRITER

feature -- Access

	viewpoints: EB_VIEWPOINT_COMBO_BOX
			-- Viewpoints selection combo box
		do
			if viewpoints_internal = Void then
				create viewpoints_internal
				viewpoints_internal.set_minimum_width (100)
				viewpoints_internal.disable_edit
				viewpoints_internal.select_actions.extend (agent on_context_change)
			end
			Result := viewpoints_internal
		ensure
			result_attached: Result /= Void
		end

	viewpoint_area: EV_WIDGET
			-- Area for `viewpoints'
		local
			l_hor: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_cell1: EV_CELL
			l_toolbar: EV_TOOL_BAR
		do
			if viewpoint_area_internal = Void then
				create l_hor
				create l_lbl.make_with_text (interface_names.l_viewpoints_colon)
				create l_cell1
				create l_toolbar
				l_toolbar.extend (create {EV_TOOL_BAR_SEPARATOR})
				l_hor.set_padding (3)
				l_hor.extend (l_toolbar)
				l_hor.disable_item_expand (l_toolbar)
				l_hor.extend (l_lbl)
				l_hor.disable_item_expand (l_lbl)
				l_hor.extend (viewpoints)
				l_hor.disable_item_expand (viewpoints)
				viewpoint_area_internal := l_hor
			end
			Result := viewpoint_area_internal
		end

feature -- Actions

	on_context_change
			-- Action to be performed when `viewpoints' changes
		deferred
		end

feature{NONE} -- Implementation

	viewpoints_internal: like viewpoints
			-- Implementation of `viewpoints'

	viewpoint_area_internal: like viewpoint_area;
			-- Implementation of `viewpoint_area'	

	update_viewpoints (a_class_c: CLASS_C)
			-- Update `viewpoints' with information in `a_class_c'.
		do
			if a_class_c = Void then
				viewpoint_area.hide
			else
				if viewpoints.conf_class /= a_class_c.lace_class.config_class then
					viewpoints.set_conf_class (a_class_c.lace_class.config_class)
					show_viewpoint_area
				end
				token_writer.set_context_group (viewpoints.current_viewpoint)
			end
		end

	show_viewpoint_area
			-- Show `viewpoint_area'.
			-- `viewpoint_area' is only shown when it has renamed context.
		do
			if viewpoints.has_renamed_view_point then
				if not viewpoint_area.is_displayed then
					viewpoint_area.show
				end
			else
				viewpoint_area.hide
			end
		end

	hide_viewpoint_area
			-- Hide `viewpoint_area'.
		do
			viewpoint_area.hide
		end

end
