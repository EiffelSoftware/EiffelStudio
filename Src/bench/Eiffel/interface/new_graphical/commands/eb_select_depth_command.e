indexing
	description	: "Command to change depth of relations."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SELECT_DEPTH_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			menu_name
		end
	
	SHARED_ERROR_HANDLER

create
	make

feature -- Basic operations

	execute is
			-- User clicked on the button.
		local
			cd: EIFFEL_CLUSTER_DIAGRAM
			dial: EB_CONTEXT_DEPTH_DIALOG
			d: EIFFEL_CLASS_DIAGRAM
			cg: ES_CLASS_GRAPH
		do
			d := tool.class_view
			if d = Void then
				cd := tool.cluster_view
				create dial.make_for_cluster_view
				dial.preset_for_cluster_view (cd)
				dial.show_modal_to_window (tool.development_window.window)
				if
					not dial.cancelled
				and
					dial.supercluster_depth /= cd.model.supercluster_depth or
					dial.subcluster_depth /= cd.model.subcluster_depth
				then
					history.wipe_out
					cd.model.set_supercluster_depth (dial.supercluster_depth)		
					cd.model.set_subcluster_depth (dial.subcluster_depth)
					tool.create_cluster_view (cd.model.center_cluster.cluster_i, False)
				end
			else
				create dial.make_for_class_view
				dial.preset_for_class_view (d)
				dial.show_modal_to_window (tool.development_window.window)
				cg := d.model
				if
					not dial.cancelled
				and
					(dial.ancestor_depth /= cg.ancestor_depth or
					dial.descendant_depth /= cg.descendant_depth or
					dial.client_depth /= cg.client_depth or
					dial.supplier_depth /= cg.supplier_depth or
					dial.all_classes_of_cluster /= cg.include_all_classes_of_cluster or
					dial.only_classes_of_cluster /= cg.include_only_classes_of_cluster)
				then
					cg.set_ancestor_depth (dial.ancestor_depth)
					cg.set_descendant_depth (dial.descendant_depth)
					cg.set_client_depth (dial.client_depth)
					cg.set_supplier_depth (dial.supplier_depth)
					cg.set_include_all_classes_of_cluster (dial.all_classes_of_cluster)
					cg.set_include_only_classes_of_cluster (dial.only_classes_of_cluster)
					tool.create_class_view (cg.center_class.class_i, False)
				end
			end
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
			Result := Interface_names.f_diagram_context_depth
		end

	menu_name: STRING is
			-- Name for the menu entry.
		do
			Result := Interface_names.m_diagram_context_depth
		end
		
	name: STRING is "Context_depth"
			-- Name of the command. Used to store the command in the
			-- preferences.

	class_depth_dialog: EB_CONTEXT_DEPTH_DIALOG
			-- Dialog to tweak depths on class views.

	cluster_depth_dialog: EB_CONTEXT_DEPTH_DIALOG
			-- Dialog to tweak depths on cluster views.
			
end -- class EB_SELECT_DEPTH_COMMAND

