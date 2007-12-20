indexing
	description: "Objects that represents a metric expression in editor token format"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_EXPRESSION_EDITOR_TOKEN_OUTPUT

inherit
	EB_METRIC_EXPRESSION_OUTPUT

	EB_SHARED_WRITER

	SHARED_TEXT_ITEMS

	EB_DOMAIN_ITEM_UTILITY

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_writer: like writer) is
			-- Initialize Current.
		do
			create {LINKED_LIST [EDITOR_TOKEN]} generated_output.make
			set_writer (a_writer)
		end

feature -- Access

	generated_output: LIST [EDITOR_TOKEN]
			-- Generated expression output

	writer: like token_writer

	string_representation: STRING_GENERAL is
			-- String representation of generated output
		local
			l_expr: STRING
			l_output: like generated_output
		do
			create l_expr.make (128)
			from
				l_output := generated_output
				l_output.start
			until
				l_output.after
			loop
				l_expr.append (l_output.item.image)
				l_output.forth
			end
			Result := l_expr
		end

feature -- Result operations

	wipe_out is
			-- Wipe out all generated output.
		do
			generated_output.wipe_out
			writer.new_line
		end

feature{EB_METRIC_EXPRESSION_GENERATOR}

	prepare_output is
			-- Prepare output.
		local
			l_writer: like writer
		do
			l_writer := writer
			generated_output.append (l_writer.last_line.content)
			l_writer.new_line
		end

feature -- Setting

	set_writer (a_writer: like writer) is
			-- Set `writer' with `a_writer'.
		require
			a_writer_attached: a_writer /= Void
		do
			writer := a_writer
		ensure
			writer_set: writer = a_writer
		end

feature -- Metric element output

	put_metric_name (a_metric_name: STRING) is
			-- Display metric name of `a_metric_name'.
		do
			prepare_output
			if metric_manager.is_metric_calculatable (a_metric_name) then
				writer.add (a_metric_name)
			else
				if a_metric_name.is_empty then
					writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), metric_names.te_no_metric)
				else
					writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), a_metric_name)
				end
			end
		end

	put_criterion_name (a_criterion: EB_METRIC_CRITERION) is
			-- Display name of `a_criterion'.
		do
			prepare_output
			if a_criterion.is_name_valid then
				if a_criterion.is_and_criterion or a_criterion.is_or_criterion then
					writer.process_keyword_text (a_criterion.name, Void)
				else
					writer.add (a_criterion.name)
				end
			else
				if a_criterion.name.is_empty then
					writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), metric_names.te_no_metric)
				else
					writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), a_criterion.name)
				end

			end
		end

	put_string (a_string: STRING_GENERAL) is
			-- Display `a_string'.
		local
			l_str: STRING_32
		do
			prepare_output
			l_str := ti_double_quote.as_string_32
			l_str.append (a_string.as_string_32)
			l_str.append (ti_double_quote.as_string_32)
			writer.add_string (a_string.as_string_8)
		end

	put_operator (a_operator: STRING_GENERAL) is
			-- Display `a_operator', such as "+", "-".
		do
			prepare_output
			writer.process_symbol_text (a_operator.as_string_8)
		end

	put_double (a_double: DOUBLE) is
			-- Display `a_double'.
		do
			prepare_output
			writer.process_number_text (a_double.out)
		end

	put_integer (a_integer: INTEGER) is
			-- Display `a_integer'.
		do
			prepare_output
			writer.process_number_text (a_integer.out)
		end

	put_keyword (a_keyword: STRING_GENERAL) is
			-- Display `a_keyword'.
		do
			prepare_output
			writer.process_keyword_text (a_keyword.as_string_8, Void)
		end

	put_error (a_error_msg: STRING_GENERAL) is
			-- Display error message `a_error_msg'.
		do
			writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), a_error_msg.as_string_8)
		end

	put_normal_text (a_text: STRING_GENERAL) is
			-- Display normal text `a_text'.
		do
			prepare_output
			writer.add (a_text.as_string_8)
		end

	put_domain_item (a_domain_item: EB_METRIC_DOMAIN_ITEM) is
			-- Display `a_domain_item'.			
		require
			a_domain_item_attached: a_domain_item /= Void
		do
			prepare_output
			if not a_domain_item.is_valid then
				writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), a_domain_item.string_representation)
			else
				writer.add_editor_tokens (token_name_from_domain_item (a_domain_item))
			end
		end

	put_target_domain_item (a_target_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Display `a_target_item'.
		do
			put_domain_item (a_target_item)
		end

	put_group_domain_item (a_group_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Display `a_group_item'.
		do
			put_domain_item (a_group_item)
		end

	put_folder_domain_item (a_folder_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Display `a_folder_item'.
		do
			put_domain_item (a_folder_item)
		end

	put_class_domain_item (a_class_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Display `a_class_item'.
		do
			put_domain_item (a_class_item)
		end

	put_feature_domain_item (a_feature_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Display `a_feature_item'.
		do
			put_domain_item (a_feature_item)
		end

	put_delayed_domain_item (a_delayed_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Display `a_delayed_item'.
		do
			put_domain_item (a_delayed_item)
		end

	put_modifier (a_modifier: STRING_GENERAL) is
			-- Display modifier `a_modifier'.
		do
			writer.add_comment (a_modifier)
		end

	put_warning (a_warning_msg: STRING_GENERAL) is
			-- Display warning message `a_warning_msg'.
		do
			writer.process_warning (a_warning_msg.as_string_8, warning_appearance)
		end

invariant
	generated_output_attached: generated_output /= Void
	writer_attached: writer /= Void

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
