indexing
	description: "Visitor to generate xml representation for metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_XML_WRITER

inherit
	EB_METRIC_VISITOR

	EB_METRIC_XML_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create text.make (4096)
		ensure
			text_attached: text /= Void
		end

feature -- Xml generation

	process_metric (a_metric: EB_METRIC) is
			-- Process `a_metric' to see if it is valid.
		require
			a_metric_attached: a_metric /= Void
		do
			a_metric.process (Current)
		end

	clear_text is
			-- Clear `text'.
		do
			text.wipe_out
		ensure
			text_cleared: text.is_empty
		end

	set_indent (a_indent: INTEGER) is
			-- Set `indent_level' with `a_indent'
		require
			a_indent_non_negative: a_indent >= 0
		do
			indent_level := a_indent
		ensure
			indent_level_set: indent_level = a_indent
		end

feature{NONE} -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC) is
			-- Process `a_basic_metric'.
		do
			append_tab (indent_level)
			append_start_tag (n_basic_metric, metric_identifier_table (a_basic_metric))
			append_new_line
			indent
			if a_basic_metric.description /= Void then
				append_indent
				append_start_tag (n_description, Void)
				append_content (a_basic_metric.description)
				append_end_tag (n_description)
				append_new_line
			end
			if
				a_basic_metric.criteria /= Void
			then
				append_indent
				append_start_tag (n_criterion, Void)
				append_new_line
				indent
				a_basic_metric.criteria.process (Current)
				exdent
				append_indent
				append_end_tag (n_criterion)
				append_new_line
			end
			exdent
			append_tab (indent_level)
			append_end_tag (n_basic_metric)
			append_new_line
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR) is
			-- Process `a_linear_metric'.
		local
			l_variable_metric: LIST [STRING]
			l_coefficient: LIST [DOUBLE]
			l_uuid: LIST [UUID]
		do
			append_tab (indent_level)
			append_start_tag (n_linear_metric, metric_identifier_table (a_linear_metric))
			append_new_line
			indent
			if a_linear_metric.description /= Void then
				append_tab (indent_level)
				append_start_tag (n_description, Void)
				append_content (a_linear_metric.description)
				append_end_tag (n_description)
				append_new_line
			end
			if
				a_linear_metric.variable_metric /= Void and then
				not a_linear_metric.variable_metric.is_empty
			then
				from
					l_variable_metric := a_linear_metric.variable_metric
					l_coefficient := a_linear_metric.coefficient
					l_uuid := a_linear_metric.variable_metric_uuid
					l_variable_metric.start
					l_coefficient.start
					l_uuid.start
				until
					l_variable_metric.after
				loop
					append_variable_metric (l_variable_metric.item, l_coefficient.item.out, l_uuid.item.out)
					l_variable_metric.forth
					l_coefficient.forth
					l_uuid.forth
				end
			end
			exdent
			append_tab (indent_level)
			append_end_tag (n_linear_metric)
			append_new_line
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO) is
			-- Process `a_ratio_metric'.
		local
			l_attr_tbl: like metric_identifier_table
		do
			append_tab (indent_level)
			l_attr_tbl := metric_identifier_table (a_ratio_metric)
			l_attr_tbl.put (a_ratio_metric.numerator_metric_name, n_numerator)
			l_attr_tbl.put (a_ratio_metric.numerator_metric_uuid.out, n_numerator_uuid)
			l_attr_tbl.put (a_ratio_metric.denominator_metric_name, n_denominator)
			l_attr_tbl.put (a_ratio_metric.denominator_metric_uuid.out, n_denominator_uuid)
			append_start_tag (n_ratio_metric, l_attr_tbl)
			append_end_tag (n_ratio_metric)
			append_new_line
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Process `a_criterion'.
		do
			check
				should_not_arrive_here: False
			end
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
		do
			append_indent
			append_start_tag (n_domain_criterion, criterion_identifier_table (a_criterion))
			append_new_line
			indent
			append_domain (a_criterion.domain)
			exdent
			append_indent
			append_end_tag (n_domain_criterion)
			append_new_line
		end

	process_caller_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
		local
			l_attr_tbl: like criterion_identifier_table
		do
			l_attr_tbl := criterion_identifier_table (a_criterion)
			l_attr_tbl.put (a_criterion.only_current_version.out, n_only_current_version)
			append_indent
			append_start_tag (n_caller_criterion, l_attr_tbl)
			append_new_line
			indent
			append_domain (a_criterion.domain)
			exdent
			append_indent
			append_end_tag (n_caller_criterion)
			append_new_line
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
		local
			l_attr_tbl: like criterion_identifier_table
		do
			l_attr_tbl := criterion_identifier_table (a_criterion)
			l_attr_tbl.put (a_criterion.is_case_sensitive.out, n_case_sensitive)
			l_attr_tbl.put ((not a_criterion.is_identical_comparison_used).out, n_regular_expression)
			append_indent
			append_start_tag (n_text_criterion, l_attr_tbl)
			append_new_line
			indent
			append_indent
			append_start_tag (n_text, Void)
			append_content (a_criterion.text)
			append_end_tag (n_text)
			append_new_line
			exdent
			append_indent
			append_end_tag (n_text_criterion)
			append_new_line
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
		do
			append_indent
			append_start_tag (n_path_criterion, criterion_identifier_table (a_criterion))
			append_new_line
			indent
			append_indent
			append_start_tag (n_path, Void)
			append_content (a_criterion.path)
			append_end_tag (n_path)
			append_new_line
			exdent
			append_end_tag (n_path_criterion)
			append_new_line
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION) is
			-- Process `a_criterion'.
		do
			append_indent
			append_start_tag (n_normal_criterion, criterion_identifier_table (a_criterion))
			append_end_tag (n_normal_criterion)
			append_new_line
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
		do
			append_indent
			append_new_line
			process_list (a_criterion.operands)
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION) is
			-- Process `a_criterion'.
		local
			l_attr_tbl: like criterion_identifier_table
		do
			l_attr_tbl := criterion_identifier_table (a_criterion)
			append_indent
			append_start_tag (n_and_criterion, l_attr_tbl)
			indent
			process_nary_criterion (a_criterion)
			exdent
			append_indent
			append_end_tag (n_and_criterion)
			append_new_line
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION) is
			-- Process `a_criterion'.
		local
			l_attr_tbl: like criterion_identifier_table
		do
			l_attr_tbl := criterion_identifier_table (a_criterion)
			append_indent
			append_start_tag (n_or_criterion, l_attr_tbl)
			indent
			process_nary_criterion (a_criterion)
			exdent
			append_indent
			append_end_tag (n_or_criterion)
			append_new_line
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			check
				should_not_arrive_here: False
			end
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			append_domain_item (n_target, a_item.text_of_id)
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			append_domain_item (n_group, a_item.text_of_id)
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			append_domain_item (n_folder, a_item.text_of_id)
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			append_domain_item (n_class, a_item.text_of_id)
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			append_domain_item (n_feature, a_item.text_of_id)
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			append_domain_item (n_delayed, a_item.text_of_id)
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE) is
			-- Process `a_item'.
		local
			l_attr: HASH_TABLE [STRING, STRING]
			l_type_name: STRING
		do
			create l_attr.make (4)
			l_attr.put (a_item.metric_name, n_name)
			inspect
				a_item.metric_type
			when {EB_METRIC_SHARED}.basic_metric_type then
				l_type_name := n_basic
			when {EB_METRIC_SHARED}.linear_metric_type then
				l_type_name := n_linear
			when {EB_METRIC_SHARED}.ratio_metric_type then
				l_type_name := n_ratio
			end
			l_attr.put (l_type_name, n_type)
			l_attr.put (a_item.calculated_time.out, n_time)
			l_attr.put (a_item.value.out, n_value)
			append_indent
			append_start_tag (n_metric, l_attr)
			append_new_line
			indent
			append_domain (a_item.input_domain)
			exdent
			append_indent
			append_end_tag (n_metric)
			append_new_line
		end

feature -- Access

	text: STRING
			-- Text which contains xml representation of the metric been visited

	indent_level: INTEGER
			-- Number of tab indent

	uuid: UUID is
			-- UUID
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_uuid_valid (a_uuid: STRING): BOOLEAN is
			-- Is `a_uuid' a valid UUID?
		require
			a_uuid_attached: a_uuid /= Void
		do
			Result := uuid.is_valid_uuid (a_uuid)
		end

feature{NONE} -- Implementation

	append_tab (n: INTEGER) is
			-- Append `n' tabs in `text'.
		require
			n_non_negative: n >= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > n
			loop
				text.append_character ('%T')
				i := i + 1
			end
		end

	append_domain_item (a_type: STRING; a_id: STRING) is
			-- Append domain item with `a_attr_tbl' in `text'.
		require
			a_type_attached: a_type /= Void
			not_a_type_is_empty: not a_type.is_empty
			a_id_attached: a_id /= Void
		local
			l_attr_tbl: HASH_TABLE [STRING, STRING]
		do
			create l_attr_tbl.make (2)
			l_attr_tbl.put (a_type, n_type)
			l_attr_tbl.put (a_id, n_id)
			append_indent
			append_start_tag (n_domain_item, l_attr_tbl)
			append_end_tag (n_domain_item)
			append_new_line
		end

	append_new_line is
			-- Append a new line character in `text'.
		do
			text.append_character ('%N')
		end

	append_content (a_content: STRING) is
			-- Append `a_content' into `text'.
		require
			a_content_attached: a_content /= Void
		do
			text.append (a_content)
		end

	append_start_tag (a_tag_name: STRING; a_attr: HASH_TABLE [STRING, STRING]) is
			-- Append an element whose name is `a_tag_name' and attributes is `a_attri' in `text'.
			-- Key of `a_attr' is attribute name, and value of `a_attr' is attribute value.
		require
			a_tag_name_attached: a_tag_name /= Void
			not_a_tag_name_is_empty: not a_tag_name.is_empty
		local
			l_text: STRING
		do
			l_text := text
			l_text.append_character ('<')
			l_text.append (a_tag_name)
			if a_attr /= Void and then not a_attr.is_empty then
				l_text.append_character (' ')
				from
					a_attr.start
					append_attribute (a_attr.key_for_iteration, a_attr.item_for_iteration)
					a_attr.forth
				until
					a_attr.after
				loop
					l_text.append_character (' ')
					append_attribute (a_attr.key_for_iteration, a_attr.item_for_iteration)
					a_attr.forth
				end
			end
			l_text.append_character ('>')
		end

	append_end_tag (a_tag_name: STRING) is
			-- Append an element end tag `a_tag_name' into `text'.
		require
			a_tag_name_attached: a_tag_name /= Void
			not_a_tag_name_is_empty: not a_tag_name.is_empty
		do
			text.append_character ('<')
			text.append_character ('/')
			text.append (a_tag_name)
			text.append_character ('>')
		end

	append_attribute (a_name: STRING; a_value: STRING) is
			-- Append attribute with name `a_name' and value `a_value' into `text'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_value_attached: a_value /= Void
		do
			text.append (a_name)
			text.append_character ('=')
			text.append_character ('%"')
			text.append (a_value)
			text.append_character ('%"')
		end

	metric_identifier_table (a_metric: EB_METRIC): HASH_TABLE [STRING, STRING] is
			-- Hash table to contain name and unit attribute for `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			create Result.make (3)
			Result.put (a_metric.name, n_name)
			Result.put (a_metric.unit.name, n_unit)
			Result.put (a_metric.uuid.out, n_uuid)
		ensure
			result_attached: Result /= Void
		end

	criterion_identifier_table (a_criterion: EB_METRIC_CRITERION): HASH_TABLE [STRING, STRING] is
			-- Hash table to contain name, scope, negation, and connector for `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			create Result.make (3)
			Result.put (a_criterion.name, n_name)
			Result.put (a_criterion.scope.name, n_scope)
			Result.put (a_criterion.is_negation_used.out, n_negation)
		ensure
			result_attached: Result /= Void
		end


	indent is
			-- Increase `indent_level' by 1.
		do
			indent_level := indent_level + 1
		ensure
			indent_level_increased: indent_level = old indent_level + 1
		end

	exdent is
			-- Decrease `indent_level' by 1.
		require
			indent_level_positive: indent_level > 0
		do
			indent_level := indent_level - 1
		ensure
			indent_level_decreased: indent_level = old indent_level - 1
		end

	append_indent is
			-- Append current `indent' tabs into `text'.
		do
			append_tab (indent_level)
		end


	append_variable_metric (a_name: STRING; a_coefficient: STRING; a_uuid: STRING) is
			-- Append variable metric (in a linear metric) with name `a_name' and coefficient `a_coefficient' into `text'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_coefficient_attached: a_coefficient /= Void
			not_a_coefficient_is_empty: not a_coefficient.is_empty
			a_coefficient_is_number: a_coefficient.is_real
			a_uuid_attached: a_uuid /= Void
			a_uuid_valid: is_uuid_valid (a_uuid)
		local
			l_attr_table: HASH_TABLE [STRING, STRING]
		do
			create l_attr_table.make (3)
			l_attr_table.put (a_name, n_name)
			l_attr_table.put (a_coefficient, n_coefficient)
			l_attr_table.put (a_uuid, n_uuid)
			append_indent
			append_start_tag (n_variable_metric, l_attr_table)
			append_end_tag (n_variable_metric)
			append_new_line
		end

	append_domain (a_domain: EB_METRIC_DOMAIN) is
			-- Append `a_domain' into `text'.
		require
			a_domain_attached: a_domain /= Void
		do
			append_indent
			append_start_tag (n_domain, Void)
			append_new_line
			indent
			from
				a_domain.start
			until
				a_domain.after
			loop
				a_domain.item.process (Current)
				a_domain.forth
			end
			exdent
			append_indent
			append_end_tag (n_domain)
			append_new_line
		end

invariant
	text_attached: text /= Void

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
