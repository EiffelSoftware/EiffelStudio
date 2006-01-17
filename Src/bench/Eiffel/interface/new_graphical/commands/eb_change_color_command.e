indexing
	description	: "Command to change color of something."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHANGE_COLOR_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

	BON_CONSTANTS

create
	make

feature -- Basic operations

	execute is
			-- Perform on every class on the diagram.
		local
			class_list: ARRAYED_LIST [BON_CLASS_FIGURE]
			old_color_table, new_color_table: HASH_TABLE [EV_COLOR, STRING]
			l_nodes: LIST [EG_LINKABLE_FIGURE]
			bcf: BON_CLASS_FIGURE
		do
			create change_color_dialog
			change_color_dialog.set_color (bon_class_fill_color)
			change_color_dialog.show_modal_to_window (tool.development_window.window)
			
			create class_list.make (20)
			create old_color_table.make (20)
			create new_color_table.make (20)
			from
				l_nodes := tool.world.flat_classes
				l_nodes.start
			until
				l_nodes.after
			loop
				bcf ?= l_nodes.item
				if bcf /= Void then
					new_color_table.put (change_color_dialog.color, bcf.model.name)
					old_color_table.put (bcf.background_color, bcf.model.name)
					class_list.extend (bcf)
				end
				l_nodes.forth
			end
			history.do_named_undoable (
				Interface_names.t_Diagram_change_color_cmd,
				agent change_color_all (class_list, new_color_table),
				agent change_color_all (class_list, old_color_table))
		end
		
feature -- Access

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (agent execute)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.extend (agent execute_with_list)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
		end

feature {NONE} -- Implementation

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Colorize all classes in `a_stone'.
		local
			cf: BON_CLASS_FIGURE
			class_list: ARRAYED_LIST [BON_CLASS_FIGURE]
			old_color_table, new_color_table: HASH_TABLE [EV_COLOR, STRING]
			clus_classes: LIST [CLASS_I]
			es_class: ES_CLASS
		do
			create change_color_dialog
			change_color_dialog.set_color (bon_class_fill_color)
			change_color_dialog.show_modal_to_window (tool.development_window.window)
			
			from
				create class_list.make (1)
				create old_color_table.make (1)
				create new_color_table.make (1)
				clus_classes := a_stone.cluster_i.classes.linear_representation
				clus_classes.start
			until
				clus_classes.after
			loop
				es_class := tool.graph.class_from_interface (clus_classes.item)
				if es_class /= Void then
					cf ?= tool.world.figure_from_model (es_class)
					if cf /= Void then
						new_color_table.put (change_color_dialog.color, cf.model.name)
						old_color_table.put (cf.background_color, cf.model.name)
						class_list.extend (cf)
					end
				end
				clus_classes.forth
			end

			history.do_named_undoable (
				Interface_names.t_Diagram_change_color_cmd,
				agent change_color_all (class_list, new_color_table),
				agent change_color_all (class_list, old_color_table))
		end
		

	execute_with_stone (a_stone: CLASSI_STONE) is
			-- Create a development window and process `a_stone'.
		local
			cf: BON_CLASS_FIGURE
			es_class: ES_CLASS
			cfs: CLASSI_FIGURE_STONE
		do
			cfs ?= a_stone
			if cfs = Void then
				es_class := tool.graph.class_from_interface (a_stone.class_i)
				if es_class /= Void then
					cf ?= tool.world.figure_from_model (es_class)
				end
			else
				cf ?= cfs.source
			end
			if cf /= Void then
				create change_color_dialog
				change_color_dialog.set_color (cf.background_color)
				change_color_dialog.show_modal_to_window (tool.development_window.window)
				if not change_color_dialog.color.is_equal (cf.background_color) then
					history.do_named_undoable (
						Interface_names.t_Diagram_change_color_cmd,
						agent change_color (cf, change_color_dialog.color),
						agent change_color (cf, cf.background_color))
				end
			end
		end
	
	execute_with_list (a_list: CLASS_FIGURE_LIST_STONE) is
			-- Colorize all classes in `a_list'.
		local
			cf: BON_CLASS_FIGURE
			class_list: ARRAYED_LIST [BON_CLASS_FIGURE]
			l_classes: LIST [EIFFEL_CLASS_FIGURE]
			old_color_table, new_color_table: HASH_TABLE [EV_COLOR, STRING]
		do
			create change_color_dialog
			change_color_dialog.set_color (bon_class_fill_color)
			change_color_dialog.show_modal_to_window (tool.development_window.window)
			
			l_classes := a_list.classes
			create old_color_table.make (l_classes.count)
			create new_color_table.make (l_classes.count)
			create class_list.make (l_classes.count)
			from
				l_classes.start
			until
				l_classes.after
			loop
				cf ?= l_classes.item
				if cf /= Void then
					new_color_table.put (change_color_dialog.color, cf.model.name)
					old_color_table.put (cf.background_color, cf.model.name)
					class_list.extend (cf)
				end
				l_classes.forth
			end
			history.do_named_undoable (
				Interface_names.t_Diagram_change_color_cmd,
				agent change_color_all (class_list, new_color_table),
				agent change_color_all (class_list, old_color_table))
		end

	change_font (cf: BON_CLASS_FIGURE; a_color: EV_COLOR) is
			-- Change color of class figure names in order to
			-- keep them readable.	
		local
			diff: DOUBLE
		do
			diff := a_color.lightness - bon_class_name_color.lightness
			if diff.abs > 0.3 then
				cf.set_class_name_color (bon_class_name_color)
			elseif (a_color.blue > 0.8 and (a_color.green + a_color.red) < 0.5) or a_color.lightness < 0.4 then
				cf.set_class_name_color (default_colors.white)
			else
				cf.set_class_name_color (default_colors.black)
			end
			diff := a_color.lightness - bon_generics_color.lightness
			if diff.abs > 0.3 then
				cf.set_generics_color (bon_generics_color)
			elseif (a_color.blue > 0.8 and (a_color.green + a_color.red) < 0.5) or a_color.lightness < 0.4 then
				cf.set_generics_color (default_colors.white)
			else
				cf.set_generics_color (default_colors.black)
			end
		end

	change_color (a_class: BON_CLASS_FIGURE; new_color: EV_COLOR) is
			-- Change color of `a_class' to `new_color'.
		do
			change_font (a_class, new_color)
			a_class.set_background_color (new_color)
			tool.world.update_cluster_legend
			tool.projector.project
		end	
		
	change_color_all (classes: LIST [BON_CLASS_FIGURE]; color_table: HASH_TABLE [EV_COLOR, STRING]) is
			-- Change color of `classes' according to `color_table'.
		require
			classes_exist: classes /= Void
			color_table_exist: color_table /= Void
		local
			cf: BON_CLASS_FIGURE
			c: EV_COLOR
		do
			from
				classes.start
			until
				classes.after
			loop
				cf := classes.item
				c := color_table.item (classes.item.model.name)
				if c /= Void then
--					change_color (cf, c)
					change_font (classes.item, c)
					cf.set_background_color (c)
				end
				classes.forth
			end
			
			tool.world.update_cluster_legend
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
			
	default_colors: EV_STOCK_COLORS is
		-- Eiffel Vision colors.
	once
		create Result
	end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CHANGE_COLOR_COMMAND

