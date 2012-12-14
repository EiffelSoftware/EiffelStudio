note
	description: "Manager that handles a metric file containing recorded measures%
		%and the related metric definitions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_FILE_MANAGER

inherit
	SHARED_XML_ROUTINES

	EB_CONSTANTS

	PROJECT_CONTEXT

create
	make

feature -- Initialization

	make
			-- Create XML elements to store metrics and measures.
		local
			l_node: XML_ELEMENT
			l_namespace: XML_NAMESPACE
		do
			create observer_list.make (10)
			create l_namespace.make_default
			create file_header.make_with_root_named ("ROOT", l_namespace)
			l_node := file_header.root_element
			create metric_header.make (l_node, "METRIC_DEFINITIONS", l_namespace)
			l_node.put_last (metric_header)
			create measure_header.make (l_node, "RECORDED_MEASURES", l_namespace)
			l_node.put_last (measure_header)
		end

feature -- Access

	file_header: XML_DOCUMENT
		-- XML header containing metric definitions and recorded measures.

	metric_header: XML_ELEMENT
		-- XML element containing metric definitions.

	measure_header: XML_ELEMENT
		-- XML element containing recorded measures.

	metric_file: PLAIN_TEXT_FILE
		-- File containing `file_header'.

	internal_metric_file_name: detachable PATH
		-- Path of `metric_file'.

feature -- File creation

	metric_file_name: PATH
			-- Location of XML file for metric macros.
		local
			directory: DIRECTORY
		do
			Result := internal_metric_file_name
			if Result = Void then
				Result := project_location.location.extended ("Metrics")
				create directory.make_with_path (Result)
				if not directory.exists then
					directory.create_dir
				end
				Result := Result.extended ("metric_file.xml")
				internal_metric_file_name := Result
			end
		end

	destroy_file_name
			-- Destroy file name when `metric_file' does no longer exist
			-- to make re-creation possible.
		do
			internal_metric_file_name := Void
		end

	create_metric_file (name: STRING)
			-- Create `metric_file' if not yet created.
		require
			name_not_empty: name /= Void and then not name.is_empty
		do
			create metric_file.make (name)
			if not metric_file.exists then
				metric_file.create_read_write
				metric_file.close
			end
		end

	store
			-- Overwrite `metric_file' with new data of `file_header'.
		require
			header_not_void: file_header /= Void
		local
			retried: BOOLEAN
			error_dialog: EB_INFORMATION_DIALOG
		do
				-- `metric_file can be void when user works on
				-- other tabs than the metric one. Since recompilation calls
				-- `store', we have to take into account that possibility.
			if not retried and metric_file /= Void then
				if not metric_file.is_closed then
					metric_file.close
				end
				metric_file.wipe_out
				metric_file.open_read_write
				Xml_routines.save_xml_document (metric_file.path, file_header)
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to write file:%N"
								+ metric_file.name )
			error_dialog.show
			retry
		end

feature -- Metric definitions

	metric_element (name, unit, type: STRING): XML_ELEMENT
			-- XML element for new metric definitions.
		require
			name_not_empty: name /= Void and then not name.is_empty
			unit_not_empty: unit /= Void and then not unit.is_empty
			type_not_empty: type /= Void and then not type.is_empty
		local
			l_namespace: XML_NAMESPACE
		do
			create l_namespace.make_default
			create Result.make_root (create {XML_DOCUMENT}.make, "METRIC", l_namespace)

			Result.add_attribute ("Name", l_namespace, name)
			Result.add_attribute ("Unit", l_namespace, unit)
			Result.add_attribute ("Type", l_namespace, type)
		end

	add_metric (metric: XML_ELEMENT; index: INTEGER)
			-- Add `metric' to `metric_header' at `index' position.
		require
			metric_not_void: metric /= Void
		do
			metric_header.nodes.go_i_th (index)
			metric_header.nodes.put_left (metric)
		end

	replace_metric (index_old_metric: INTEGER; new_metric: XML_ELEMENT)
			-- Overwrite metric at `index_old_metric' with `new_metric'.
		require
			new_metric_not_void: new_metric /= Void
			correct_index: index_old_metric >= 1 and index_old_metric <= metric_header.count
		do
			new_metric.set_parent (metric_header)
			metric_header.nodes.put_i_th (new_metric, index_old_metric)
		end

	index_of_metric (metric_name: STRING): INTEGER
			-- Return index of metric whose name is `metric_name' in `metric_header'.
		require
			metric_name_not_empty: metric_name /= Void and then not metric_name.is_empty
		local
			a_cursor: XML_COMPOSITE_CURSOR
			i: INTEGER
			node, a_metric_element: XML_ELEMENT
			node_name: STRING
		do
			a_cursor := metric_header.new_cursor
			from
				a_cursor.start
				i := 1
			until
				a_metric_element /= Void
			loop
				node ?= a_cursor.item
				if node /= Void then
					node_name := node.attribute_by_name ("Name").value
					if node_name.is_equal (metric_name) then
						a_metric_element := node
					end
				end
				i := i + 1
				a_cursor.forth
			end
			Result := i - 1
		ensure
			index_found: Result >= 1 and Result <= metric_header.count
		end

	new_metric_notify_all (new_metric: EB_METRIC; new_metric_element: XML_ELEMENT; overwrite: BOOLEAN; index: INTEGER)
			-- Notify all observers of a change in metric definitions.
		do
			if metric_file.is_closed then
				metric_file.open_read_write
			end
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.notify_new_metric (new_metric, new_metric_element, overwrite, index)
				observer_list.forth
			end
			metric_file.close
		rescue
		end

	management_metric_notify_all (metric_list: ARRAYED_LIST [EB_METRIC]; xml_list: ARRAYED_LIST [XML_ELEMENT])
			-- Notify all observers of a change in metric definitions.
		do
			if metric_file.is_closed then
				metric_file.open_read_write
			end
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.notify_management_metric (metric_list, xml_list)
				observer_list.forth
			end
			metric_file.close
		rescue
		end

feature -- Recorded_measures

	measure_element (row: EV_MULTI_COLUMN_LIST_ROW; status: STRING): XML_ELEMENT
			-- XML element for new recorded measures.
		local
			l_namespace: XML_NAMESPACE
		do
			create l_namespace.make_default
			create Result.make_root (create {XML_DOCUMENT}.make, "MEASURE", l_namespace)
			Result.add_attribute ("STATUS", l_namespace, status)
			Result.put_last (Xml_routines.xml_node (Result, "MEASURE_NAME", row.i_th (1)))
			Result.put_last (Xml_routines.xml_node (Result, "SCOPE_TYPE", row.i_th (2)))
			Result.put_last (Xml_routines.xml_node (Result, "SCOPE_NAME", row.i_th (3)))
			Result.put_last (Xml_routines.xml_node (Result, "METRIC", row.i_th (4)))
			Result.put_last (Xml_routines.xml_node (Result, "RESULT", row.i_th (5)))
		end

	add_row (row: EV_MULTI_COLUMN_LIST_ROW; status: STRING)
			-- Add new measure to `measure_header'.
		require
			row_not_void: row /= Void
			status_correct: equal (status, "new") or equal (status, "old")
		local
			added_row: XML_ELEMENT
		do
			added_row := measure_element (row, status)
			measure_header.put_last (added_row)
		end

	delete_row (index: INTEGER)
			-- Remove recorded measure at `index'.
		require
			correct_range: index >= 1 and index <= measure_header.count
		do
			measure_header.nodes.go_i_th (index)
			measure_header.nodes.remove
		end

	update_row (row: EV_MULTI_COLUMN_LIST_ROW; index: INTEGER)
			-- Overwrite recorded measure at `index' after measure has changed.
		require
			row_not_void: row /= Void
			correct_range: index >= 1 and index <= measure_header.count
		local
			updated_row: XML_ELEMENT
		do
			updated_row := measure_element (row, "new")
			measure_header.nodes.put_i_th (updated_row, index)
		end

	measure_notify_all
			-- Notify all observers of a change in recorded measures.
		do
			if metric_file.is_closed then
--				metric_file.open_read_write
			end
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.notify_measure
				observer_list.forth
			end
			metric_file.close
		rescue
		end

	measure_notify_all_but (tool: EB_METRIC_OBSERVER)
			-- Notify all observers of a change in recorded measures.
		do
			if metric_file.is_closed then
				metric_file.open_read_write
			end
			from
				observer_list.start
			until
				observer_list.after
			loop
				if not equal (observer_list.item, tool) then
					observer_list.item.notify_measure
				end
				observer_list.forth
			end
			metric_file.close
		rescue
		end

	set_recompiled (bool: BOOLEAN)
			-- Assign `bool' to `is_recompiled' of each_observer.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.set_recompiled (bool)
				observer_list.forth
			end
		end

feature -- Observer

	observer_list: ARRAYED_LIST [EB_METRIC_OBSERVER]
		-- List of observers currently displayed.

	add_observer (an_observer: EB_METRIC_OBSERVER)
			-- Add `an_observer' to `observer_list'.
		require
			observer_not_void: an_observer /= Void
		do
			observer_list.extend (an_observer)
		ensure
			added_observer: observer_list.has (an_observer)
		end

	remove_observer (an_observer: EB_METRIC_OBSERVER)
			-- Remove `an_observer' from `observer_list'.
		require
			observer_not_void: an_observer /= Void
		do
			observer_list.start
			observer_list.prune_all (an_observer)
		ensure
			removed_observer: not observer_list.has (an_observer)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_METRIC_FILE_MANAGER
