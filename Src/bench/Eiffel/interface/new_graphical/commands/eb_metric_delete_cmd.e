indexing
	description: "Command to delete previously recorded measures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
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
			selected_items := tool.multi_column_list.selected_items.twin
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

			if tool.file_manager.metric_file /= Void then
					-- Make sure that a metric file is available.
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

end -- class EB_METRIC_DELETE_CMD
