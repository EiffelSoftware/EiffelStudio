indexing
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

	EB_METRIC_UTILITY

	EB_METRIC_SHARED

create
	make_with_factory

feature{NONE} -- Initialization

	make_with_factory (a_factory: like factory) is
			-- Initialize `factory' with `a_factory'.
		require
			a_factory_attached: a_factory /= Void
		do
			factory := a_factory
			create {LINKED_LIST [EB_METRIC_ARCHIVE_NODE]}archive.make
			create current_domain.make
			create current_tag.make
			create current_attributes.make (4)
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

	wipe_out_archive is
			-- Wipe out `archive'.
		do
			archive.wipe_out
		ensure
			archive_is_empty: archive.is_empty
		end

feature{NONE} -- Callbacks

	on_start_tag_finish is
			-- End of start tag.
		do
			if not has_error then
				inspect
					current_tag.item
				when t_metric then
					process_metric_archive_node
				when t_domain then
					process_domain
				when t_domain_item then
					process_domain_item
				else
				end
				current_attributes.clear_all
			end
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		do
			if not has_error then
				inspect
					current_tag.item
				when t_metric then
					current_archive_node.set_input_domain (current_domain)
					archive.extend (current_archive_node)
				else
				end
				current_tag.remove
			end
		end

	on_content (a_content: STRING) is
			-- Text content.
		do
		end

feature{NONE} -- Process

	process_metric_archive_node is
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
		do
			l_name := current_attributes.item (at_name)
			if not has_error then
				if l_name = Void then
					set_parse_error_message (metric_names.err_metric_name_missing_in_archive_node, Void)
				end
			end
			if not has_error then
				l_type_str := current_attributes.item (at_type)
				if l_type_str = Void then
					set_parse_error_message (
						metric_names.err_metric_type_missing,
						metric_names.archive_location (l_name)
					)
				else
					l_type := metric_type_id_from_name (l_type_str)
					if l_type = 0 then
						set_parse_error_message (
							metric_names.err_metric_type_invalid (l_type_str),
							metric_names.archive_location (l_name)
						)
					end
				end
			end
			if not has_error then
				l_time := current_attributes.item (at_time)
				if l_time = Void then
					set_parse_error_message (
						metric_names.err_archive_time_missing,
						metric_names.archive_location (l_name)
					)
				else
					create l_date.make_now
					if not l_date.date_time_valid (l_time, l_date.default_format_string) then
						set_parse_error_message (
							metric_names.err_archive_time_invalid (l_time),
							metric_names.archive_location (l_name)
						)
					end
				end
			end
			if not has_error then
				l_value := current_attributes.item (at_value)
				if l_value = Void then
					set_parse_error_message (
						metric_names.err_archive_value_missing,
						metric_names.archive_location (l_name)
					)
				elseif not l_value.is_real then
					set_parse_error_message (
						metric_names.err_archive_value_invalid (l_value),
						metric_names.archive_location (l_name)
					)
				end
			end
			if not has_error then
				l_uuid_str := current_attributes.item (at_uuid)
				check_uuid_vadility (
					l_uuid_str,
					metric_names.archive_location (l_name)
				)
				if not has_error then
					l_uuid := last_valid_uuid
				end
			end
			if not has_error then
				current_archive_node := factory.new_metric_arichive_node (
					current_attributes.item (at_name),
					l_type,
					create {DATE_TIME}.make_from_string_default (l_time),
					l_value.to_double,
					create {EB_METRIC_DOMAIN}.make,
					l_uuid_str)
				create current_domain.make
			end
		end

	process_domain is
			-- Process "domain" definition list node.		
		do
			if not current_domain.is_empty then
				set_parse_error_message (
					metric_names.err_too_many_domain,
					metric_names.archive_location (current_archive_node.metric_name)
				)
			end
		end

	process_domain_item is
			-- Process "domain_item" definition list node.		
		local
			l_id: STRING
			l_type: STRING
			l_library_target_uuid: STRING
			l_domain_item: EB_METRIC_DOMAIN_ITEM
		do
			check current_archive_node /= Void end
			l_id := current_attributes.item (at_id)
			l_type := current_attributes.item (at_type)
			l_library_target_uuid := current_attributes.item (at_library_target_uuid)
			if l_id = Void then
				set_parse_error_message (
					metric_names.err_domain_item_id_is_missing,
					metric_names.archive_location (current_archive_node.metric_name)
				)
			end
			if not has_error then
				if l_type = Void then
					set_parse_error_message (
						metric_names.err_domain_item_type_is_missing,
						metric_names.archive_location (current_archive_node.metric_name)
					)
				else
					l_type := internal_name (l_type)
					if not is_domain_item_type_valid (l_type) then
						set_parse_error_message (
							metric_names.err_domain_item_type_invalid (l_type),
							metric_names.archive_location (current_archive_node.metric_name)
						)
					else
						if l_library_target_uuid /= Void then
							if not shared_uuid.is_valid_uuid (l_library_target_uuid) then
								set_parse_error_message (
									metric_names.err_library_target_uuid_invalid (l_library_target_uuid),
									metric_names.archive_location (current_archive_node.metric_name)
								)
							end
						end
						if not has_error then
							l_domain_item := domain_item_type_table.item (l_type).item ([l_id])
							if l_library_target_uuid /= Void then
								l_domain_item.set_library_target_uuid (l_library_target_uuid)
							end
							current_domain.extend (l_domain_item)
						end
					end
				end
			end
		end

feature{NONE} -- Implementation

	current_archive_node: EB_METRIC_ARCHIVE_NODE
			-- Current archive node

	current_domain: EB_METRIC_DOMAIN
			-- Current domain

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
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
			Result.force (l_trans, t_metric)

				-- domain
				-- => domain_item
			create l_trans.make (1)
			l_trans.force (t_domain_item, n_domain_item)
			Result.force (l_trans, t_domain)
		end

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
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
			create l_attr.make (2)
			l_attr.force (at_name, n_name)
			l_attr.force (at_type, n_type)
			l_attr.force (at_time, n_time)
			l_attr.force (at_value, n_value)
			l_attr.force (at_uuid, n_uuid)
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
		end

	metric_type_id_from_name (a_type_name: STRING): INTEGER is
			-- Metric type id for type name `a_type_name'.
			-- Nonzero if `a_type_name' is a valid name, 0 otherwise.
		require
			a_type_name_attached: a_type_name /= Void
		local
			l_name: STRING
		do
			l_name := internal_name (a_type_name)
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

indexing
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

