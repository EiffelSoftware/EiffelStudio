indexing
	description: "Command to delete diagram components and to remove corresponding code in system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DELETE_DIAGRAM_ITEM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		rename
			make as make_context_diagram
		undefine
			menu_name
		redefine
			new_toolbar_item,
			description
		select
			name
		end

	EB_DELETE_CLASS_CLUSTER_COMMAND
		rename
			name as dup_name,
			make as dup_make
		undefine
			enable_sensitive,
			disable_sensitive,
			new_toolbar_item,
			new_mini_toolbar_item,
			mini_pixmap,
			description,
			tooltip,
			pixmap
		redefine
			drop_class,
			drop_cluster,
			delete_class,
			delete_cluster,
			execute
		end

create
	make

feature -- Initialization

	make (a_target: like tool; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize with `a_target' and `a_window'.
		do
			make_context_diagram (a_target)
			window := a_window
		end

	execute is
			-- Display information about `Current'.
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_delete_item)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

	execute_with_inherit_stone (a_stone: INHERIT_STONE) is
			-- Remove `a_stone' from diagram.
		local
			cf: CLASS_FIGURE
			cd: CONTEXT_DIAGRAM
			stone_midpoints, saved_midpoints: LINKED_LIST [LINK_MIDPOINT]
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd /= Void end			
			if a_stone.source.world = cd then
				cf ?= a_stone.source.descendant
				if cf /= Void then
					cf.code_generator.reset_date
					cf.code_generator.set_diagram (cf.world)
				end
				stone_midpoints := a_stone.source.midpoints
				create saved_midpoints.make
				from
					stone_midpoints.start
				until
					stone_midpoints.after
				loop
					saved_midpoints.put_front (stone_midpoints.item)
					stone_midpoints.forth
				end
				history.do_named_undoable (
					Interface_names.t_Diagram_delete_inheritance_link_cmd,
					~remove_inheritance_figure (a_stone.source),
					~restore_inheritance_figure (a_stone.source, saved_midpoints))
				if not a_stone.source.last_generation_successful then
					history.remove_last
					a_stone.source.update
				end
			end
		end

	execute_with_client_stone (a_stone: CLIENT_STONE) is
			-- Remove `a_stone' from diagram.
		local
			csfs_to_remove: LINKED_LIST [CLIENT_SUPPLIER_FIGURE]
			names: LINKED_LIST [STRING]
			cancelled: BOOLEAN
			cf: CLASS_FIGURE
			dial: EB_DELETE_CLIENT_LINK_DIALOG
			cd: CONTEXT_DIAGRAM
			stone_midpoints, saved_midpoints: LINKED_LIST [LINK_MIDPOINT]
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd /= Void end		
			if a_stone.source.world = cd then
				cancelled := False
				create csfs_to_remove.make
				cf ?= a_stone.source.client
				if cf /= Void then
					cf.code_generator.reset_date
				end
				if not a_stone.source.children_figures.is_empty then
					dial := delete_client_link_dialog
					dial.set_strings (a_stone.source.feature_names)
					dial.show_modal_to_window (window.window)
					if not dial.cancelled and then
						dial.selected_item /= Void then
							names := dial.selected_items
							from
								names.start
							until
								names.after
							loop
								csfs_to_remove.extend (a_stone.source.link_by_feature_name (names.item))
								names.forth
							end	
					else
						cancelled := True
					end
					dial.destroy
				else
					csfs_to_remove.extend (a_stone.source)
				end
				stone_midpoints := a_stone.source.midpoints
				create saved_midpoints.make
				from
					stone_midpoints.start
				until
					stone_midpoints.after
				loop
					saved_midpoints.put_front (stone_midpoints.item)
					stone_midpoints.forth
				end
	
				if not cancelled then
					history.do_named_undoable (
						Interface_names.t_Diagram_delete_client_link_cmd,
						[<<~remove_client_supplier_figures (csfs_to_remove, a_stone.source),
							~update_label (a_stone.source)>>],
						[<<~restore_client_supplier_figures (csfs_to_remove, saved_midpoints, a_stone.source),
							~update_label (a_stone.source)>>])
				end
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor {EB_CONTEXT_DIAGRAM_COMMAND} (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_inherit_stone)
			Result.drop_actions.extend (~execute_with_client_stone)
			Result.drop_actions.extend (~drop_class)
			Result.drop_actions.extend (~drop_cluster)
		end

	project is
			-- Call the projector.
		do
			tool.projector.project
		end

	remove_inheritance_figure (a_inheritance_figure: INHERITANCE_FIGURE) is
			-- Remove `a_inheritance_figure' from diagram and from code.
		local
			d: CONTEXT_DIAGRAM
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end

			a_inheritance_figure.remove_from_diagram (d)
		end
		
	restore_inheritance_figure (
		a_inheritance_figure: INHERITANCE_FIGURE;
		saved_midpoints: LINKED_LIST [LINK_MIDPOINT]) is
			-- Put `a_inheritance_figure' back on diagram and code.
		local
			d: CONTEXT_DIAGRAM
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			a_inheritance_figure.put_on_diagram (d)
			a_inheritance_figure.retrieve_midpoints (saved_midpoints)
			tool.projector.project
		end

	remove_client_supplier_figures (
		client_supplier_figures: LINKED_LIST [CLIENT_SUPPLIER_FIGURE];
		client_stone: CLIENT_SUPPLIER_FIGURE) is
			-- Remove `client_supplier_figures' items from diagram.
		local
			d: CONTEXT_DIAGRAM
			cf: CLASS_FIGURE
			data: LINKED_LIST [CASE_SUPPLIER]
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			if not client_supplier_figures.is_empty then
				cf ?= client_supplier_figures.first.client
				if cf /= Void then
					cf.code_generator.set_diagram (d)
				end
			end

			create data.make
			from
				client_supplier_figures.start
			until
				client_supplier_figures.after
			loop
				data.put_front (client_supplier_figures.item.supplier_data)
				client_supplier_figures.forth
			end
			cf.code_generator.remove_features_with_data (data)
			
			client_stone.update
			tool.projector.project			
		end
		
	restore_client_supplier_figures (
		client_supplier_figures: LINKED_LIST [CLIENT_SUPPLIER_FIGURE];
		saved_midpoints: LINKED_LIST [LINK_MIDPOINT];
		client_stone: CLIENT_SUPPLIER_FIGURE) is
			-- Put `client_supplier_figures' items back on  diagram.
		local
			d: CONTEXT_DIAGRAM
			cf: CLASS_FIGURE
			data: LINKED_LIST [CASE_SUPPLIER]
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			if not client_supplier_figures.is_empty then
				cf ?= client_supplier_figures.first.client
				if cf /= Void then
					cf.code_generator.set_diagram (d)
				end
			end

			if client_stone.world = Void then
				client_stone.put_on_diagram (d)
				client_stone.reset
				client_stone.retrieve_midpoints	(saved_midpoints)	
				client_stone.disable_is_valid
			end

			create data.make
			from
				client_supplier_figures.start
			until
				client_supplier_figures.after
			loop
				data.extend (client_supplier_figures.item.supplier_data)
				client_supplier_figures.forth
			end
			cf.code_generator.extend_features_with_data (data)

			tool.projector.project
		end

	drop_class (st: CLASSI_STONE) is
			-- Extract the class that should be removed from `st' and erase it.
		local
			cfs: CLASSI_FIGURE_STONE
			cd: CONTEXT_DIAGRAM
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd /= Void end		
			cfs ?= st
			if cfs /= Void and then cfs.source.world = cd then
				class_figure := cfs.source
			else
				class_figure := cd.class_figure_by_class (st.class_i)			
			end
			Precursor (st)
		end

	class_figure: CLASS_FIGURE
			-- Figure to be removed.

	drop_cluster (st: CLUSTER_STONE) is
			-- Extract the cluster that should be removed from `st' and erase it.
		local
			cfs: CLUSTER_FIGURE_STONE
			cld: CLUSTER_DIAGRAM
		do
			cld ?= tool.cluster_view
			cfs ?= st
			if cfs /= Void then
				cluster_figure := cfs.source
			else
				if cfs /= Void and then cfs.source.world = cld then
					cluster_figure := Void
				elseif cld /= Void then
					cluster_figure := cld.cluster_figure_by_cluster (st.cluster_i)
				end
			end
			Precursor (st)
		end

	cluster_figure: CLUSTER_FIGURE
			-- Figure to be removed.

	delete_class is
			-- Remove `class_i' from the system.
		local
			file: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				create file.make (class_i.file_name)
				if
					file.exists and then
					file.is_writable
				then
					file.delete
					manager.remove_class (class_i)
					if class_figure /= Void then
						class_figure.remove_from_diagram (True)
						class_figure.update_pebble
					end					
					could_not_delete := False
				end
				Application.resynchronize_breakpoints
				Window_manager.synchronize_all
			end
			if could_not_delete then
					-- We were not able to delete the file.
				create wd.make_with_text (Warning_messages.w_Not_writable (class_i.file_name))
				wd.show_modal_to_window (window.window)
			end
		rescue
			retried := True
			retry	
		end

	delete_cluster is
			-- Remove `cluster_i' from the system.
		do
			history.wipe_out
			if cluster_figure /= Void then
				cluster_figure.recursive_remove_from_diagram (True)
			end
			Precursor		
		end

	update_label (link: CLIENT_SUPPLIER_FIGURE) is
			-- `link' needs to have its labels updated.
		require
			link_exists: link /= Void
		do
			if link.world /= Void then
				link.build_label
				link.update_name_figure
			end
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_delete_small
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_delete
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_delete
		end

	name: STRING is "Delete_item"
			-- Name of the command. Used to store the command in the
			-- preferences.

	delete_client_link_dialog: EB_DELETE_CLIENT_LINK_DIALOG is
			-- Associated widget.
		do
			create Result
		end

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.
			
end -- class EB_DELETE_DIAGRAM_ITEM_COMMAND
