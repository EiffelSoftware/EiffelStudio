indexing
	description: "Command to delete previously recorded measures."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DELETE_CMD

inherit
	EB_METRIC_COMMAND

create
	make

feature -- Initialization

	execute is
			-- Remove_selected_lines if any.
		do
			on_delete_click
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_delete_measure
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Delete current selected row(s)"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Delete metrics"
		end

	name: STRING is "delete"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature -- Actions

	on_delete_click is
			-- Delete selected row(s) from `multi_column_list'.
		require
			existing_tool: tool /= Void
		local
			selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			index_deleted_row: INTEGER
		do
			selected_items := clone (tool.multi_column_list.selected_items)
			from
				selected_items.start
			until
				selected_items.after
			loop
				index_deleted_row := tool.multi_column_list.index_of (selected_items.item, 1)
				tool.file_manager.delete_row (index_deleted_row)
				tool.multi_column_list.prune (selected_items.item)
				selected_items.forth
			end
			
			if not tool.file_manager.metric_file.exists then
					-- Should not be called, if file does not exist, `tool.multi_column_list' is emptied.
				tool.file_manager.destroy_file_name
				tool.set_file_loaded (False)
				tool.file_handler.load_files
			end
			check tool.file_manager.metric_file.exists end
			tool.file_manager.store
			tool.file_manager.measure_notify_all_but (tool)
		end

end -- class EB_METRIC_DELETE_CMD
