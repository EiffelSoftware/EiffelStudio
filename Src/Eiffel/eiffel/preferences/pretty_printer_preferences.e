note
	description: "Pretty printer preferences."

class
	PRETTY_PRINTER_PREFERENCES

inherit
	ANY
	PREFERENCE_EXPORTER
	SHARED_COMPILER_PREFERENCES
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (p: PREFERENCES)
			-- Initializes the preference manager using `p`.
		local
			f: BASIC_PREFERENCE_FACTORY
			m: PREFERENCE_MANAGER
		do
			m := p.manager (pretty_printer_namespace)
			if not attached m then
				m := p.new_manager (pretty_printer_namespace)
			end

			create f

				-- Loop expression style.
			preference_value_loop_expression_style := f.new_string_choice_preference_value
				(m, preference_name_loop_expression_style, preference_string_loop_expression_style)
			if not preference_result_loop_expression_style.valid_index (preference_value_loop_expression_style.selected_index) then
				preference_value_loop_expression_style.set_selected_index (preference_default_loop_expression_style)
			end
				-- Default value is a complete string with all values where the selected one is marked.
				-- It might be retrieved from the external storage. If not, it should be set after selecting an item.
			if not attached preference_value_loop_expression_style.default_value then
				preference_value_loop_expression_style.set_default_value (preference_value_loop_expression_style.text_value)
			end

				-- Line processing.
			preference_value_line_processing := f.new_string_choice_preference_value
				(m, preference_name_line_processing, preference_string_line_processing)
			if not preference_result_line_processing.valid_index (preference_value_line_processing.selected_index) then
				preference_value_line_processing.set_selected_index (preference_default_line_processing)
			end
				-- Default value is a complete string with all values where the selected one is marked.
				-- It might be retrieved from the external storage. If not, it should be set after selecting an item.
			if not attached preference_value_line_processing.default_value then
				preference_value_line_processing.set_default_value (preference_value_line_processing.text_value)
			end

				-- Unindented comments.
			preference_value_keep_unindented_comments := f.new_boolean_preference_value
				(m, preference_name_keep_unindented_comments, True)
		end

feature -- Access

	loop_expression_style: like {PRETTY_PRINTER}.loop_expression_style
			-- A setting that controls how loop expressions are processed.
		local
			i: like preference_value_loop_expression_style.selected_index
		do
			i := preference_value_loop_expression_style.selected_index
			Result := preference_result_loop_expression_style
				[if preference_result_loop_expression_style.valid_index (i) then i else preference_default_loop_expression_style end]
		ensure
			{PRETTY_PRINTER}.is_loop_expression_style (Result)
		end

	line_processing: like {PRETTY_PRINTER}.line_processing
			-- A setting that controls how new lines are processed.
		local
			i: like preference_value_line_processing.selected_index
		do
			i := preference_value_line_processing.selected_index
			Result := preference_result_line_processing
				[if preference_result_line_processing.valid_index (i) then i else preference_default_line_processing end]
		ensure
			{PRETTY_PRINTER}.is_line_processing (Result)
		end

	is_unindented_comment_kept: BOOLEAN
			-- Should unindented comments be left alone?
		do
			Result := preference_value_keep_unindented_comments.value
		end

feature {NONE} -- Preferences

	pretty_printer_namespace: STRING = "pretty_printer"
			-- The namespace for the pretty printer preferences.

	preference_name_prefix: STRING
			-- A prefix for preference names.
		once
			Result := pretty_printer_namespace + "."
		end

feature {NONE} -- Settings: loop expression style

	preference_value_loop_expression_style: STRING_CHOICE_PREFERENCE
			-- A preference to control how loop expressions are processed.

	preference_name_loop_expression_style: STRING
			-- Name of a preference that tells how loop expressions should be processed.
		once
			Result := preference_name_prefix + "loop_expression_style"
		end

	preference_string_loop_expression_style: ARRAY [STRING_32]
			-- Names of loop expression styles with indexes corresponding to `preference_result_loop_expression_style`.
		once
			Result := {ARRAY [STRING_32]} <<"keep", "keyword", "symbol">>
		end

	preference_result_loop_expression_style: ARRAYED_LIST [like {PRETTY_PRINTER}.loop_expression_style]
			-- Values of loop expression styles with indexes corresponding to `preference_string_loop_expression_style`.
		once
			create Result.make_from_array (<<
				{PRETTY_PRINTER}.loop_expression_keep,
				{PRETTY_PRINTER}.loop_expression_keyword,
				{PRETTY_PRINTER}.loop_expression_symbol
			>>)
		ensure
			across Result is s all {PRETTY_PRINTER}.is_loop_expression_style (s) end
		end

	preference_default_loop_expression_style: like {STRING_CHOICE_PREFERENCE}.selected_index
			-- Index of a default value of `preference_result_loop_expression_style`.
		once
			Result := preference_result_loop_expression_style.index_of ({PRETTY_PRINTER}.loop_expression_style_default, 1)
		ensure
			preference_result_loop_expression_style.valid_index (Result)
		end

feature {NONE} -- Settings: new line style

	preference_value_line_processing: STRING_CHOICE_PREFERENCE
			-- A preference to control how new lines are processed.

	preference_name_line_processing: STRING
			-- Name of a preference that tells how new lines should be processed.
		once
			Result := preference_name_prefix + "line_processing"
		end

	preference_string_line_processing: ARRAY [STRING_32]
			-- Names of new line styles with indexes corresponding to `preference_result_line_processing`.
		once
			Result := {ARRAY [STRING_32]} <<"keep", "wrap", "inline">>
		end

	preference_result_line_processing: ARRAYED_LIST [like {PRETTY_PRINTER}.loop_expression_style]
			-- Values of new lines styles with indexes corresponding to `preference_string_line_processing`.
		once
			create Result.make_from_array (<<
				{PRETTY_PRINTER}.line_keep,
				{PRETTY_PRINTER}.line_wrap,
				{PRETTY_PRINTER}.line_inline
			>>)
		ensure
			across Result is s all {PRETTY_PRINTER}.is_line_processing (s) end
		end

	preference_default_line_processing: like {STRING_CHOICE_PREFERENCE}.selected_index
			-- Index of a default value of `preference_result_line_processing`.
		once
			Result := preference_result_line_processing.index_of ({PRETTY_PRINTER}.line_processing_default, 1)
		ensure
			preference_result_line_processing.valid_index (Result)
		end

feature {NONE} -- Settings: commented code preservation

	preference_value_keep_unindented_comments: BOOLEAN_PREFERENCE
			-- A preference to control whether unindented comments should be left alone.

	preference_name_keep_unindented_comments: STRING
			-- Name of a preference that tells if unindented comments should be left alone.
		once
			Result := preference_name_prefix + "keep_unindented_comments"
		end

invariant
	consistent_loop_expression_style: preference_string_loop_expression_style.count = preference_result_loop_expression_style.count
	consistent_line_processing: preference_string_line_processing.count = preference_result_line_processing.count

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
