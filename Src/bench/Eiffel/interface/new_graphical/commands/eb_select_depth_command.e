indexing
	description	: "Command to change depth of relations."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SELECT_DEPTH_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
	
	SHARED_ERROR_HANDLER

create
	make

feature -- Basic operations

	execute is
			-- User clicked on the button.
		local
			d: CONTEXT_DIAGRAM
			cd: CLUSTER_DIAGRAM
			sel: EB_VIEW_SELECTOR
			tmp: LINKED_LIST [STRING]
			dial: EB_CONTEXT_DEPTH_DIALOG
			cancelled: BOOLEAN
		do
			if not cancelled then
				d ?= tool.class_view
				if d = Void then
					cd ?= tool.cluster_view
					check cd /= Void end
					create dial.make_for_cluster_view
					dial.preset_for_cluster_view (cd)
					dial.show_modal_to_window (tool.development_window.window)
					if
						not dial.cancelled
					and
						dial.supercluster_depth /= cd.supercluster_depth or
						dial.subcluster_depth /= cd.subcluster_depth
					then
						history.wipe_out
						sel := dial.view_selector
						if not sel.text.is_empty then
							if sel.selected_item = Void then
								tmp := sel.strings
								if not tmp.has (sel.text) then
									tmp.put_front (sel.text)
									sel.set_strings (tmp)
									sel.i_th (1).enable_select
								else					
									tmp.compare_objects
									tmp.search (sel.text)
									sel.i_th (tmp.index).enable_select
									tmp.compare_references
								end
							end
							check 
								a_view_is_selected: sel.selected_item /= Void
							end
							if not sel.selected_item.text.is_equal (cd.current_view) then
								tool.view_selector.select_actions.block
								tool.view_selector.set_strings (sel.strings)
								tool.view_selector.select_actions.resume
								tool.view_selector.set_text (sel.selected_item.text)
								tool.view_selector.return_actions.call ([])
							end	
						end
						tool.progress_dialog.set_title ("Synchronizing progress")
						tool.progress_dialog.set_message ("Diagram for " + cd.center_cluster.cluster_i.cluster_name)
						tool.progress_dialog.enable_cancel
						tool.progress_dialog.start (5)
						tool.progress_dialog.set_value (0)
						tool.progress_dialog.show
						history.wipe_out
						cd.set_supercluster_depth (dial.supercluster_depth)		
						cd.set_subcluster_depth (dial.subcluster_depth)
						cd.enable_placement_needed
						cd.synchronize (True, tool.progress_dialog)
					end
				else
					create dial.make_for_class_view
					dial.preset_for_class_view (d)
					dial.show_modal_to_window (tool.development_window.window)
					if
						not dial.cancelled
					and
						(dial.ancestor_depth /= d.ancestor_depth or
						dial.descendant_depth /= d.descendant_depth or
						dial.client_depth /= d.client_depth or
						dial.supplier_depth /= d.supplier_depth or
						dial.all_classes_of_cluster /= d.include_all_classes_of_cluster or
						dial.only_classes_of_cluster /= d.include_only_classes_of_cluster)
					then
						history.wipe_out
						sel := dial.view_selector
						if not sel.text.is_empty then
							if sel.selected_item = Void then
								tmp := sel.strings
								if not tmp.has (sel.text) then
									tmp.put_front (sel.text)
									sel.set_strings (tmp)
									sel.i_th (1).enable_select
								else					
									tmp.compare_objects
									tmp.search (sel.text)
									sel.i_th (tmp.index).enable_select
									tmp.compare_references
								end
							end
							check 
								a_view_is_selected: sel.selected_item /= Void
							end
							if not sel.selected_item.text.is_equal (d.current_view) then
								tool.view_selector.select_actions.block
								tool.view_selector.set_strings (sel.strings)
								tool.view_selector.select_actions.resume
								tool.view_selector.set_text (sel.selected_item.text)
								tool.view_selector.return_actions.call ([])
							end	
						end
						tool.progress_dialog.set_title ("Synchronizing progress")
						tool.progress_dialog.set_message ("Diagram for " + d.center_class.class_i.name_in_upper)
						tool.progress_dialog.enable_cancel
						tool.progress_dialog.start (6)
						tool.progress_dialog.set_value (0)
						tool.progress_dialog.show
						history.wipe_out
						d.set_ancestor_depth (dial.ancestor_depth)
						d.set_descendant_depth (dial.descendant_depth)
						d.set_client_depth (dial.client_depth)
						d.set_supplier_depth (dial.supplier_depth)
						d.set_include_all_classes_of_cluster (dial.all_classes_of_cluster)
						d.set_include_only_classes_of_cluster (dial.only_classes_of_cluster)
						d.enable_placement_needed
						d.synchronize (True, tool.progress_dialog)
					end
				end
			end
		rescue
			cancelled := True
			Error_handler.error_list.wipe_out
			tool.Progress_dialog.hide
			tool.clear_area
			tool.disable_toolbar
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.standard_cursor)
			retry	
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_select_depth
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Select depth of relations"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Context dialog"
		end

	name: STRING is "Context_depth"
			-- Name of the command. Used to store the command in the
			-- preferences.

	class_depth_dialog: EB_CONTEXT_DEPTH_DIALOG
			-- Dialog to tweak depths on class views.

	cluster_depth_dialog: EB_CONTEXT_DEPTH_DIALOG
			-- Dialog to tweak depths on cluster views.
			
end -- class EB_SELECT_DEPTH_COMMAND

