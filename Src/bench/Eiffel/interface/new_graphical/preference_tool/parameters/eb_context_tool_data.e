indexing
	description: "All shared attributes specific to the context tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_TOOL_DATA

inherit
	ES_TOOLBAR_PREFERENCE

feature -- Access

	diagram_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	bon_class_name_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_roman)
			Result.set_shape (fc.shape_italic)
			Result.set_height (16)
			Result.set_weight (fc.weight_bold)
		end

	bon_class_name_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.1, 0.5)
		end

	bon_class_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 0.0)
		end

	bon_class_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

	bon_class_line_width: INTEGER is
		do
			Result := 1
		end

	bon_generics_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_roman)
			Result.set_weight (fc.weight_bold)
			Result.set_height (16)
		end

	bon_generics_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.4, 0.7)
		end

	bon_client_label_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_roman)
			Result.set_shape (fc.shape_italic)
			Result.set_height (15)
		end

	max_class_name_length: INTEGER is
		do
			Result := 15
		end
	
	bon_cluster_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.8, 0.1, 0.0)
		end

	bon_cluster_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	bon_cluster_iconified_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 0.9, 0.9)
		end

	bon_cluster_name_area_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	bon_cluster_name_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.5, 0.0, 0.0)
		end

	max_cluster_name_length: INTEGER is
		do
			Result := 25
		end

	retrieve_diagram_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, diagram_toolbar_layout)
		end

	save_diagram_toolbar (toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_resources' to have the changes actually saved.
		do
			set_array ("diagram__toolbar_layout", save_toolbar (toolbar))
		end

feature {NONE} -- Implementation

	diagram_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := array_resource_value ("diagram__toolbar_layout", <<"Clear_bkpt__visible">>)
		end


end -- class EB_CONTEXT_TOOL_DATA

