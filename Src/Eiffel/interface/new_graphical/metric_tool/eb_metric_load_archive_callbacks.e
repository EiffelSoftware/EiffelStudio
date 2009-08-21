note
	description: "Object that loads metric archives"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_LOAD_ARCHIVE_CALLBACKS

inherit
	EB_LOAD_METRIC_CALLBACKS
		redefine
			on_start_tag_finish,
			on_end_tag,
			on_content
		end

	EB_METRIC_SHARED

create
	make_with_factory

feature{NONE} -- Initialization

	make_with_factory (a_factory: like factory)
			-- Initialize `factory' with `a_factory'.
		require
			a_factory_attached: a_factory /= Void
		do
			make_null
			initialize
			factory := a_factory
			create {LINKED_LIST [EB_METRIC_ARCHIVE_NODE]}archive.make
			create current_domain.make
			create current_tag.make
			create current_attributes.make (4)
			create domain_receiver_stack.make
			set_is_for_whole_file (True)
		ensure
			factory_set: factory = a_factory
			archive_attached: archive /= Void
			current_domain_attached: current_domain /= Void
			current_tag_attached: current_tag /= Void
			current_attributes_attached: current_attributes /= Void
		end

feature -- Access

	archive: LIST [EB_METRIC_ARCHIVE_NODE]
			-- Metric archives

feature -- Setting

	wipe_out_archive
			-- Wipe out `archive'.
		do
			archive.wipe_out
		ensure
			archive_is_empty: archive.is_empty
		end

feature{NONE} -- Callbacks

	on_start_tag_finish
			-- End of start tag.
		do
			inspect
				current_tag.item
			when t_metric then
				process_metric_archive_node
			when t_domain then
				process_domain
			when t_domain_item then
				process_domain_item
			when t_tester then
				process_tester
			when t_tester_item then
				process_tester_item
			when t_constant_value then
				process_constant_value
			when t_metric_value then
				process_metric_value
			else
			end
			current_attributes.wipe_out
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
		do
			inspect
				current_tag.item
			when t_metric then
				archive.extend (current_archive_node)
				remove_domain_receiver_from_stack
			when t_domain then
				process_domain_finish
			when t_tester then
				process_tester_finish
			when t_tester_item then
				current_tester.insert_criterion (current_tester_item)
				current_tester_item := Void
				remove_receiver_from_stack (
					value_retriever_stack,
					metric_names.err_value_retriever_missing
				)
			when t_metric_value then
				process_value_retriever_finish
				remove_domain_receiver_from_stack
			when t_constant_value then
				process_value_retriever_finish
			else
			end
			current_tag.remove
		end

	on_content (a_content: STRING)
			-- Text content.
		do
		end

feature{NONE} -- Process

	process_metric_archive_node
			-- Process "metric" definition list node.
		local
			l_type: INTEGER
			l_time: STRING
			l_value: STRING
			l_date: DATE_TIME
			l_uuid_str: STRING
			l_name: STRING
			l_type_str: STRING
			l_uuid: UUID
			l_filter: STRING
			l_filter_value: BOOLEAN
		do
			l_name := current_attributes.item (at_name)
			if l_name = Void then
				create_last_error (metric_names.err_metric_name_missing_in_archive_node)
			end
			l_type_str := current_attributes.item (at_type)
			if l_type_str = Void then
				create_last_error (metric_names.err_metric_type_missing)
			else
				l_type := metric_type_id_from_name (l_type_str)
				if l_type = 0 then
					create_last_error (metric_names.err_metric_type_invalid (l_type_str))
				end
			end

			l_time := current_attributes.item (at_time)
			if l_time = Void then
				create_last_error (metric_names.err_archive_time_missing)
			else
				create l_date.make_now
				if not l_date.date_time_valid (l_time, l_date.default_format_string) then
					create_last_error (metric_names.err_archive_time_invalid (l_time))
				end
			end

			l_value := current_attributes.item (at_value)
			if l_value = Void then
				create_last_error (metric_names.err_archive_value_missing)
			elseif not l_value.is_real then
				create_last_error (metric_names.err_archive_value_invalid (l_value))
			end

			l_filter := current_attributes.item (at_filter)
			if l_filter /= Void then
				if l_filter.is_boolean then
					l_filter_value := l_filter.to_boolean
				else
					create_last_error (metric_names.err_filter_invalid (l_filter))
				end
			end

			l_uuid_str := current_attributes.item (at_uuid)
			check_uuid_validity (l_uuid_str)
			l_uuid := last_valid_uuid

			current_archive_node := factory.new_metric_arichive_node (
				current_attributes.item (at_name),
				l_type,
				create {DATE_TIME}.make_from_string_default (l_time),
				l_value.to_double,
				create {EB_METRIC_DOMAIN}.make,
				l_uuid_str,
				l_filter_value
			)
			domain_receiver_stack.extend ([agent current_archive_node.set_input_domain, False])
			tester_receiver_stack.extend ([agent current_archive_node.set_value_tester, False])
		end

feature{NONE} -- Implementation

	current_archive_node: EB_METRIC_ARCHIVE_NODE
			-- Current archive node

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
		once
			create Result.make (4)

				-- => metric_archive
			create l_trans.make (1)
			l_trans.force (t_metric_archive, n_metric_archive)
			Result.force (l_trans, t_none)

				-- metric archive node
				-- => metric (archive node)
			create l_trans.make (1)
			l_trans.force (t_metric, n_metric)
			Result.force (l_trans, t_metric_archive)

				-- metric archive node
				-- => domain
			create l_trans.make (1)
			l_trans.force (t_domain, n_domain)
			l_trans.force (t_tester, n_tester)
			Result.force (l_trans, t_metric)

				-- domain
				-- => domain_item
			create l_trans.make (1)
			l_trans.force (t_domain_item, n_domain_item)
			Result.force (l_trans, t_domain)

				-- tester
				-- => tester_item
			create l_trans.make (1)
			l_trans.force (t_tester_item, n_tester_item)
			Result.force (l_trans, t_tester)

				-- tester_item
				-- => constant_value
				-- => metric_value
			create l_trans.make (2)
			l_trans.force (t_constant_value, n_constant_value)
			l_trans.force (t_metric_value, n_metric_value)
			Result.force (l_trans, t_tester_item)

				-- metric_value
				-- => domain
			create l_trans.make (1)
			l_trans.force (t_domain, n_domain)
			Result.force (l_trans, t_metric_value)
		end

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- Mapping of possible attributes of tags.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
		once
			create Result.make (2)

				-- metric archive node
				-- * metric
				-- * type
				-- * time
				-- * uuid
				-- * value
			create l_attr.make (6)
			l_attr.force (at_name, n_name)
			l_attr.force (at_type, n_type)
			l_attr.force (at_time, n_time)
			l_attr.force (at_value, n_value)
			l_attr.force (at_uuid, n_uuid)
			l_attr.force (at_filter, n_filter)
			Result.force (l_attr, t_metric)

				-- domain_item
				-- * id
				-- * type
				-- * library_target_uuid
			create l_attr.make (2)
			l_attr.force (at_id, n_id)
			l_attr.force (at_type, n_type)
			l_attr.force (at_library_target_uuid, n_library_target_uuid)
			Result.force (l_attr, t_domain_item)

				-- Tester
			create l_attr.make (1)
			l_attr.force (at_relation, n_relation)
			Result.force (l_attr, t_tester)

				-- tester_item
				-- * name
				-- * value
			create l_attr.make (2)
			l_attr.force (at_name, n_name)
			l_attr.force (at_value, n_value)
			Result.force (l_attr, t_tester_item)

				-- constant_value
				-- * value
			create l_attr.make (1)
			l_attr.force (at_value, n_value)
			Result.force (l_attr, t_constant_value)

				-- metric_value
				-- * name
				-- * use_external_delayed
			create l_attr.make (2)
			l_attr.force (at_metric_name, n_metric_name)
			l_attr.force (at_use_external_delayed, n_use_external_delayed)
			Result.force (l_attr, t_metric_value)
		end

	element_index_table: HASH_TABLE [INTEGER, STRING]
			-- Table of indexes of supported elements indexed by element name.
		once
			create Result.make (1)
			Result.put (t_metric_archive, n_metric_archive)
			Result.put (t_domain, n_domain)
			Result.put (t_domain_item, n_domain_item)
			Result.put (t_tester, n_tester)
			Result.put (t_tester_item, n_tester_item)
			Result.put (t_constant_value, n_constant_value)
			Result.put (t_metric_value, n_metric_value)
		end

	metric_type_id_from_name (a_type_name: STRING): INTEGER
			-- Metric type id for type name `a_type_name'.
			-- Nonzero if `a_type_name' is a valid name, 0 otherwise.
		require
			a_type_name_attached: a_type_name /= Void
		local
			l_name: STRING
		do
			l_name := a_type_name.as_lower
			if l_name.is_equal (n_basic) then
				Result := basic_metric_type
			elseif l_name.is_equal (n_linear) then
				Result := linear_metric_type
			elseif l_name.is_equal (n_ratio) then
				Result := ratio_metric_type
			end
		end

invariant
	factory_attached: factory /= Void
	archive_attached: archive /= Void
	current_domain_attached: current_domain /= Void
	domain_receiver_stack_attached: domain_receiver_stack /= Void

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


