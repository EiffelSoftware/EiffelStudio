indexing
	description	: "Command to change color of something."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHANGE_COLOR_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

	EB_CONTEXT_TOOL_DATA
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform on every class on the diagram.
		local
			cd: CONTEXT_DIAGRAM
			class_list: ARRAYED_LIST [CLASS_FIGURE]
			old_color_table, new_color_table: HASH_TABLE [EV_COLOR, STRING]
			cf: CLASS_FIGURE
			class_layer: EV_FIGURE_GROUP
		do
			create change_color_dialog
			create class_list.make (20)
			create old_color_table.make (20)
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
				check cd /= Void end
			end
			class_layer := cd.class_layer
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				old_color_table.put (cf.color, cf.name)
				class_layer.forth
			end
			change_color_dialog.set_color (tool.Bon_class_fill_color)
			change_color_dialog.show_modal_to_window (tool.development_window.window)
			create new_color_table.make (20)
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				new_color_table.put (change_color_dialog.color, cf.name)
				class_list.extend (cf)
				class_layer.forth
			end
			history.do_named_undoable (
				Interface_names.t_Diagram_change_color_cmd,
				~change_color_all (class_list, new_color_table),
				~change_color_all (class_list, old_color_table))
		end

	execute_with_stone (a_stone: CLASSI_STONE) is
			-- Create a development window and process `a_stone'.
		local
			cf: CLASS_FIGURE
			cfs: CLASSI_FIGURE_STONE
			cd: CONTEXT_DIAGRAM
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd /= Void end
			cfs ?= a_stone
			create change_color_dialog
			if cfs /= Void and then cfs.source.world = cd then
				cf := cfs.source
			else
				cf := cd.class_figure_by_class (a_stone.class_i)
			end
			if cf /= Void then
				change_color_dialog.set_color (cf.color)
				change_color_dialog.show_modal_to_window (tool.development_window.window)
				if not change_color_dialog.color.is_equal (cf.color) then
					history.do_named_undoable (
						Interface_names.t_Diagram_change_color_cmd,
						~change_color (cf, change_color_dialog.color),
						~change_color (cf, cf.color))
				end
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_stone)
		end

feature {NONE} -- Implementation

	change_font (cf: CLASS_FIGURE; a_color: EV_COLOR) is
			-- Change color of class figure names in order to
			-- keep them readable.
		local
			white: EV_COLOR
		do
			if a_color.lightness < 0.5 then
				create white.make_with_rgb (1.0, 1.0, 1.0)
				cf.set_name_color (white)
				if cf.generics /= Void then
					cf.set_generics_color (white)
				end
			else
				cf.set_name_color (bon_class_name_color)
				if cf.generics /= Void then
					cf.set_generics_color (bon_generics_color)
				end
			end
		end

	change_color (a_class: CLASS_FIGURE; new_color: EV_COLOR) is
			-- Change color of `a_class' to `new_color'.

		do
			change_font (a_class, new_color)
			a_class.set_color (new_color)
			tool.projector.project
		end	
		
	change_color_all (classes: LIST [CLASS_FIGURE]; color_table: HASH_TABLE [EV_COLOR, STRING]) is
			-- Change color of `classes' according to `color_table'.
		require
			classes_exist: classes /= Void
			color_table_exist: color_table /= Void
		local
			cf: CLASS_FIGURE
			c: EV_COLOR
		do
			from
				classes.start
			until
				classes.after
			loop
				cf := classes.item
				c := color_table.item (classes.item.name)
				if c /= Void then
					change_font (classes.item, c)
					cf.set_color (c)
				end
				classes.forth
			end
			tool.projector.project
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_color
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_change_color
		end

	name: STRING is "Color"
			-- Name of the command. Used to store the command in the
			-- preferences.

	change_color_dialog: EV_COLOR_DIALOG
			-- Dialog that allows to choose a color.

end -- class EB_CHANGE_COLOR_COMMAND

