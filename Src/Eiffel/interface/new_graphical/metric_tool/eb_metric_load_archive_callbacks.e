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
		do
			l_type := metric_type_id_from_name (current_attributes.item (at_type))
			l_time := current_attributes.item (at_time)
			l_value := current_attributes.item (at_value)
			if l_type = 0 then
				set_parse_error_message ("Invalid metric type %"" + current_attributes.item (at_type) + "%".")
			end
			if not has_error then
				create l_date.make_now
				if not l_date.date_time_valid (l_time, l_date.default_format_string) then
					set_parse_error_message ("Invalid time %"" + l_time + "%".")
				end
			end
			if not has_error then
				if not l_value.is_real then
					set_parse_error_message ("Invalid metric value %"" + l_time + "%".")
				end
			end
			if not has_error then
				current_archive_node := factory.new_metric_arichive_node (
					current_attributes.item (at_name),
					l_type,
					create {DATE_TIME}.make_from_string_default (l_time),
					l_value.to_double,
					create {EB_METRIC_DOMAIN}.make)
			end
		end

	process_domain is
			-- Process "domain" definition list node.		
		do
			create current_domain.make
		end

	process_domain_item is
			-- Process "domain_item" definition list node.		
		local
			l_id: STRING
			l_type: STRING
		do
			l_id := current_attributes.item (at_id)
			l_type := current_attributes.item (at_type)
			if l_id = Void then
				set_parse_error_message ("Missing domain item id.")
			end
			if not has_error then
				if l_type = Void then
					set_parse_error_message ("Missing domain item type.")
				else
					l_type := internal_name (l_type)
					if not is_domain_item_type_valid (l_type) then
						set_parse_error_message ("Invalid domain item type.")
					else
						current_domain.extend (domain_item_type_table.item (l_type).item ([l_id]))
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
			create l_attr.make (2)
			l_attr.force (at_name, n_name)
			l_attr.force (at_type, n_type)
			l_attr.force (at_time, n_time)
			l_attr.force (at_value, n_value)
			Result.force (l_attr, t_metric)

				-- domain_item
				-- * id
				-- * type
			create l_attr.make (2)
			l_attr.force (at_id, n_id)
			l_attr.force (at_type, n_type)
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

