indexing
	description: "Dialog to setup customized tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL_DIALOG

inherit
	EB_CUSTOMIZED_FORMATTER_DIALOG
		redefine
			item_anchor
		end

create
	make

feature{NONE} -- Initializatioin

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			default_initialize
			empty_selection_label.set_text (interface_names.l_select_tool)
			set_title (interface_names.t_setup_customized_tool)
			add_button.set_tooltip (interface_names.f_add_tool)
			remove_button.set_tooltip (interface_names.f_remove_tool)
		end

feature -- Access

	item_anchor: EB_CUSTOMIZED_TOOL_DESP
			-- Item ancho type	

	name_of_item (a_item: like item_anchor): STRING_GENERAL is
			-- Name of `a_item'
		do
			Result := a_item.name
		end

	item_grid_column_count: INTEGER is
			-- Number of columns in `item_grid'
		do
			Result := 1
		end

	new_item: like item_anchor is
			-- New item used when adding new item
		local
			l_descriptor: like item_anchor
		do
			create l_descriptor.make (next_item_name, uuid_gen.generate_uuid.out)
			l_descriptor.set_pixmap_location ("")
			Result := l_descriptor
		end

feature{NONE} -- Actions

	on_name_change (a_new_data: STRING_32; a_descriptor: like item_anchor) is
			-- Action to be performed when `a_new_data' changes.
			-- Invoke `a_setter' to set this new data.
			-- After setting, invoke `a_referesh' to refresh Current dialog if `a_refresher' is not Void.
		require
			a_new_data_attached: a_new_data /= Void
			a_descriptor_attached: a_descriptor /= Void
		do
			set_has_changed (True)
			a_descriptor.set_name (a_new_data)
			refresh_grid_for_descriptor (a_descriptor)
		end

	on_data_change (a_new_data: STRING_32; a_setter: PROCEDURE [ANY, TUPLE [STRING]]; a_refresher: PROCEDURE [ANY, TUPLE]) is
			-- Action to be performed when `a_new_data' changes.
			-- Invoke `a_setter' to set this new data.
			-- After setting, invoke `a_referesh' to refresh Current dialog if `a_refresher' is not Void.
		require
			a_new_data_attached: a_new_data /= Void
			a_setter_attached: a_setter /= Void
		do
			set_has_changed (True)
			a_setter.call ([string_8_from_string_32 (a_new_data)])
			if a_refresher /= Void then
				a_refresher.call (Void)
			end
		end

feature{NONE} -- Implementation/Data

	default_icon_pixmap: EV_PIXMAP is
			-- Default icon pixmap for `items'
		do
			Result := pixmaps.icon_pixmaps.diagram_export_to_png_icon
		end

	new_item_name: STRING is
			-- Base for new created items
		do
			Result := "New tool #"
		end

	name_property: STRING_PROPERTY [STRING_GENERAL]
			-- Name property

feature{NONE} -- Implementation

	load_descriptors is
			-- Load descriptors retrieved from `items_getter' into Current.
			-- Keep a copy of retrieved descriptors so modification done in Current dialog don't mess up the source.
		local
			l_desps: like descriptors
			l_callback: EB_CUSTOMIZED_TOOL_XML_CALLBACK
		do
			items.wipe_out
			create l_callback.make
			l_desps :=
				items_from_xml_document (
					xml_document_for_items (n_tools, items_getter.item (Void), agent customized_tool_manager.xml_for_descriptor),
					l_callback,
					agent l_callback.tools,
					agent l_callback.last_error
				)
			l_desps.do_all (agent items.force_last)
			set_has_changed (False)
		end

	setup_item_grid is
			-- Setup `item_grid'.
		do
			item_grid.column (1).set_title (interface_names.t_tool_name)
		end

	bind_item_row (a_descriptor: like item_anchor; a_grid_row: EV_GRID_ROW) is
			-- Bind `a_descriptor' in `a_grid_row'.
		local
			l_item: EV_GRID_LABEL_ITEM
			l_pixmap: EV_PIXMAP
		do
			create l_item.make_with_text (a_descriptor.name)
			l_pixmap := pixmap_from_file (a_descriptor.pixmap_location)
			l_pixmap.stretch (16, 16)
			l_item.set_pixmap (l_pixmap)
			a_grid_row.set_data (a_descriptor)
			a_grid_row.set_item (1, l_item)
		end

	resize_item_grid is
			-- Resize `item_grid'.
		do
		end

	bind_property_grid (a_descriptor: like item_anchor) is
			-- Load information of `a_descriptor' in `property_grid'.
		local
			l_grid: like property_grid
			l_name: like name_property
			l_pixmap: FILE_PROPERTY
		do
			l_grid := property_grid
			l_grid.clear_description
			l_grid.reset
				-- Build "General" section.
			l_grid.add_section (interface_names.l_general)

			create l_name.make (interface_names.l_name)
			l_name.set_value (a_descriptor.name.as_string_32)
			l_name.change_value_actions.extend (agent on_name_change (?, a_descriptor))
			name_property := l_name
			l_grid.add_property (l_name)

			create l_pixmap.make (interface_names.l_pixmap_file)
			l_pixmap.set_value (string_32_from_string_8 (a_descriptor.pixmap_location))
			l_pixmap.change_value_actions.extend (agent on_data_change (?, agent a_descriptor.set_pixmap_location, Void))
			l_grid.add_property (l_pixmap)

			l_grid.current_section.expand
			l_name.enable_select
		end

	refresh_grid_for_descriptor (a_descriptor: like item_anchor) is
			-- Refresh grid item for `a_descriptor'.
		local
			l_grid_row: EV_GRID_ROW
			l_selected: BOOLEAN
		do
			item_grid.row_select_actions.block
			item_grid.row_deselect_actions.block
			l_grid_row := descriptor_row_table.item (a_descriptor)
			check l_grid_row /= Void end
			l_selected := l_grid_row.is_selected
			bind_item_row (a_descriptor, l_grid_row)
			if l_selected then
				l_grid_row.enable_select
			end
			item_grid.row_select_actions.resume
			item_grid.row_deselect_actions.resume
		end

end
