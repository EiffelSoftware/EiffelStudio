indexing

	description: 
		"Command that goes to the parent cluster when the %
		%associated button is pressed.";
	date: "$Date$";
	revision: "$Revision $"

class 
	UNZOOM_CLUSTER

inherit

	EC_LICENCED_COMMAND
		select
			work
		end

	EC_EDITOR_WINDOW_COM
		--undefine
		--	work
		redefine
			editor_window
		end;

creation

	make

feature -- Properties

	editor_window: MAIN_WINDOW;
			-- Associated graph cluster window

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		once
			Result := Pixmaps.unzoom_pixmap
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Unzoom cluster data from editor window.
		local
			old_cluster: CLUSTER_DATA;
			workarea: WORKAREA;
			graph_linkable: GRAPH_LINKABLE
		do
			--Windows.set_watch_cursor;
			old_cluster := editor_window.entity
			if old_cluster /= Void and then not old_cluster.is_root then
				check
					old_cluster /= system.root_cluster
				end;
				--workarea := editor_window.draw_window;
				--workarea.unselect_all;
				editor_window.set_entity (old_cluster.parent_cluster);
				--graph_linkable := workarea.find_linkable_in_current (old_cluster);
				--workarea.refresh_all
				--if graph_linkable /= Void then
					--workarea.highlight_linkable (graph_linkable);
				--end;
				--workarea.refresh_upper_left.set(0,0)
				--if graph_linkable /= Void then
				--	workarea.highlight_linkable (graph_linkable);
				--end; -- pascal
			end;
			--Windows.restore_cursor;
		end;

end -- class UNZOOM_CLUSTER
