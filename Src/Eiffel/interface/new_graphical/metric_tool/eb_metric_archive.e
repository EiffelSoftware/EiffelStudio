note
	description: "Object that represents a metric archive"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE

inherit
	EB_METRIC_SHARED

	EB_XML_DOCUMENT_HELPER [EB_METRIC_ARCHIVE_NODE]

	EB_METRIC_XML_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			create {LINKED_LIST [EB_METRIC_ARCHIVE_NODE]} archive_internal.make
		end

feature -- Access

	archive: LIST [EB_METRIC_ARCHIVE_NODE]
			-- List of archives
			-- Every time, a new list if archiv nodes are returned.
		do
			Result := archive_internal.twin
		ensure
			result_attached: Result /= Void
		end

	filtered_archive (a_filter_agent: FUNCTION [ANY, TUPLE [a_archive_node: EB_METRIC_ARCHIVE_NODE], BOOLEAN]): like Current
			-- Archive that satisfies predicate given by `a_filter_agent'.
		require
			a_filter_agent_attached: a_filter_agent /= Void
		do
			create Result.make

			archive_internal.do_if (agent Result.insert_archive_node, a_filter_agent)
		ensure
			result_attached: Result /= Void
		end

	archive_by_metric_name (a_metric_name: STRING): like archive
			-- List of archive nodes calculated over metric named `a_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
			not_a_metric_name_is_empty: not a_metric_name.is_empty
		local
			l_archive: like archive
			l_item: EB_METRIC_ARCHIVE_NODE
			l_metric_manager: like metric_manager
		do
			create {LINKED_LIST [EB_METRIC_ARCHIVE_NODE]} Result.make

			from
				l_metric_manager := metric_manager
				l_archive := archive
				l_archive.start
			until
				l_archive.after
			loop
				l_item := l_archive.item
				if l_metric_manager.is_metric_name_equal (l_item.metric_name, a_metric_name) then
					Result.extend (l_item)
				end
				l_archive.forth
			end
		ensure
			result_attached: Result /= Void
		end

	archive_by_uuid (a_uuid: UUID): EB_METRIC_ARCHIVE_NODE
			-- Archive with UUID `a_uuid'		
			-- Void if no metric archive whose UUID is `a_uuid' exists.
		require
			a_uuid_attached: a_uuid /= Void
		local
			l_archive: like archive
			l_item: EB_METRIC_ARCHIVE_NODE
		do
			from
				l_archive := archive
				l_archive.start
			until
				l_archive.after or Result /= Void
			loop
				l_item := l_archive.item
				if l_item.uuid.is_equal (a_uuid) then
					Result := l_item
				end
				l_archive.forth
			end
		end

	equivalent_archives (a_archive: EB_METRIC_ARCHIVE_NODE): LIST [EB_METRIC_ARCHIVE_NODE]
			-- List of archives which are equivalent with `a_archive'
		require
			a_archive_attached: a_archive /= Void
		do
			create {LINKED_LIST [EB_METRIC_ARCHIVE_NODE]} Result.make
			archive_internal.do_if (agent Result.extend, agent is_archive_equivalent (a_archive, ?))
		ensure
			result_attached: Result /= Void
		end

	count: INTEGER
			-- Number of archive nodes
		do
			Result := archive_internal.count
		end

feature -- Error handling

	last_error: EB_METRIC_ERROR
			-- Last occurred error

	has_error: BOOLEAN
			-- Has error?
		do
			Result := last_error /= Void
		end

	clear_last_error
			-- Clear `last_error' and ensure `has_error' return False.
		do
			last_error := Void
		ensure
			not_has_error: not has_error
		end

	create_last_error (a_error_message: STRING_GENERAL)
			-- Create `last_error' to contain `a_error_message'.
		do
			create last_error.make (a_error_message)
		ensure
			has_error: has_error
		end

feature -- Status report

	has_archive_by_metric_name (a_metric_name: STRING): BOOLEAN
			-- Does archive calculated over metric given by name `a_metric_name' exist?
		require
			a_metric_name_attached: a_metric_name /= Void
			not_a_metric_name_is_empty: not a_metric_name.is_empty
		do
			Result := not archive_by_metric_name (a_metric_name).is_empty
		end

	has_archive_by_uuid (a_uuid: UUID): BOOLEAN
			-- Does archive whose UUID is `a_uuid' exist?
		require
			a_uuid_attached: a_uuid /= Void
		do
			Result := archive_by_uuid (a_uuid) /= Void
		end

	is_archive_equivalent (a_archive, b_archive: EB_METRIC_ARCHIVE_NODE): BOOLEAN
			-- Is `a_archive' equivalent to `b_archive'?
		require
			a_archive_attached: a_archive /= Void
			b_archive_attached: b_archive /= Void
		do
			Result := a_archive.is_mergable (b_archive)
		end

feature -- Archive manipulation

	load_archive (a_file_name: STRING)
			-- Load metric archive from file named `a_file_name'.
			-- Store result in `last_loaded_metric_archive'.
			-- Set `last_loaded_metric_archive' to Void if error occurs.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_callback: EB_METRIC_LOAD_ARCHIVE_CALLBACKS
			l_loaded_archive: LIST [EB_METRIC_ARCHIVE_NODE]
			l_tuple: TUPLE [l_archive: LIST [EB_METRIC_ARCHIVE_NODE]; l_error: EB_METRIC_ERROR]
		do
			wipe_out_archive
			clear_last_error
			create l_callback.make_with_factory (create{EB_LOAD_METRIC_DEFINITION_FACTORY})

			l_tuple := items_from_file (a_file_name, l_callback, agent l_callback.archive, agent l_callback.last_error, agent create_last_error (metric_names.err_file_not_readable (a_file_name)))
			if not has_error then
				last_error := l_tuple.l_error
				if not has_error then
					l_loaded_archive := l_tuple.l_archive
					l_loaded_archive.do_all (agent insert_archive_node)
				else
					backup_file (a_file_name)
				end
			end
		end

	store_archive (a_file_name: STRING; a_error_agent: PROCEDURE [ANY, TUPLE])
			-- Write `archive' into file `a_file_name'.
			-- Clear content of `a_file_name' if file already exists.
			-- `a_error_agent' will be invoked when error occurs.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_xml_generator: EB_METRIC_XML_WRITER [EB_METRIC_ARCHIVE_NODE]
		do
			create l_xml_generator.make
			store_xml (xml_document_for_items (n_metric_archive, archive, agent l_xml_generator.xml_element ({EB_METRIC_ARCHIVE_NODE}?, ?)), a_file_name, a_error_agent)
		end

	remove_archive_node (a_uuid: UUID)
			-- Remove archive node whose UUID is `a_uuid' from `archive'.
		require
			a_uuid_attached: a_uuid /= Void
			archive_node_exists: has_archive_by_uuid (a_uuid)
		local
			l_archive: like archive
			l_item: EB_METRIC_ARCHIVE_NODE
			done: BOOLEAN
		do
			l_archive := archive_internal
			if l_archive /= Void then
				from
					l_archive.start
				until
					l_archive.after or done
				loop
					l_item := l_archive.item
					if l_item.uuid.is_equal (a_uuid) then
						l_archive.remove
						done := True
					else
						l_archive.forth
					end
				end
			end
		end

	insert_archive_node (a_archive_node: EB_METRIC_ARCHIVE_NODE)
			-- Insert `a_archive_node' into `archive'.
		require
			a_archive_node_attached: a_archive_node /= Void
			a_archive_node_not_exists: not has_archive_by_uuid (a_archive_node.uuid)
		do
			archive_internal.extend (a_archive_node)
		ensure
			archive_noded_inserted: has_archive_by_uuid (a_archive_node.uuid) and then archive_by_uuid (a_archive_node.uuid) = a_archive_node
		end

	wipe_out_archive
			-- Wipe out all archive nodes in `archive'.
		do
			archive_internal.wipe_out
		ensure
			archive_is_empty: archive.is_empty
		end

	merge_archive_node (a_new_archive_node, a_old_archive_node: EB_METRIC_ARCHIVE_NODE)
			-- Try to merge information from `a_new_archive_node' into `a_old_archive_node'.
		require
			a_new_archive_node_attached: a_new_archive_node /= Void
			a_new_archive_node_valid: a_new_archive_node.is_metric_valid
			a_old_archive_node_attached: a_old_archive_node /= Void
			a_old_archive_node_valid: a_old_archive_node.is_metric_valid
			a_old_archive_in_current: has_archive_by_uuid (a_old_archive_node.uuid)
			mergable: a_new_archive_node.is_mergable (a_old_archive_node)
		do
			a_old_archive_node.merge (a_new_archive_node)
		end

	mark_archive_as_up_to_date
			-- Mark every archive node as up-to-date.
		do
			archive_internal.do_all (agent change_archive_node_status (?, True))
		end

	mark_archive_as_old
			-- Mark every archive node as old.
		do
			archive_internal.do_all (agent change_archive_node_status (?, False))
		end

	rename_metric (a_old_name, a_new_name: STRING)
			-- Rename metric names in archive nodes from `a_old_name' to `a_new_name'.
		require
			a_old_name_valid: metric_manager.is_metric_name_valid (a_old_name)
			a_new_name_valid: metric_manager.is_metric_name_valid (a_new_name)
		do
			archive_internal.do_all (agent change_metric_name (?, a_old_name, a_new_name))
		end

feature{NONE} -- Implementation

	change_archive_node_status (a_archive_node: EB_METRIC_ARCHIVE_NODE; b: BOOLEAN)
			-- Change the status of `a_archive_node' to `b'.
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			a_archive_node.set_is_up_to_date (b)
		ensure
			status_changed: a_archive_node.is_up_to_date = b
		end

	change_metric_name (a_archive_node: EB_METRIC_ARCHIVE_NODE; a_old_name, a_new_name: STRING)
			-- If metric name in `a_archive_node' is equal to `a_old_name', then change it to `a_new_name', otherwise, do nothing.
		require
			a_archive_node_attached: a_archive_node /= Void
			a_old_name_valid: metric_manager.is_metric_name_valid (a_old_name)
			a_new_name_valid: metric_manager.is_metric_name_valid (a_new_name)
		do
			if metric_manager.is_metric_name_equal (a_archive_node.metric_name, a_old_name) then
				a_archive_node.set_metric_name (a_new_name)
			end
		end

	archive_internal: like archive
			-- Implementation of `archive_internal'.

invariant
	archive_internal_attached: archive_internal /= Void
	archive_attached: archive /= Void

note
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
