indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MATRIX_FILE_GENERATOR

inherit
	ERROR_SHARED_ERROR_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			reset
		end

feature -- Access

	height: INTEGER
			-- Height of matrix

	width: INTEGER
			-- Width of matrix

	generated_file_name: STRING
			-- Location of generated file

feature {NONE} -- Access

	buffer_suffix: STRING is
			-- Retrieves buffer feature name suffix
		local
			l_suffix: like suffix
		once
			l_suffix := suffix
			if l_suffix /= Void then
				create  Result.make (default_buffer_suffix.count + l_suffix.count)
				Result.append (l_suffix)
				Result.append (default_buffer_suffix)
			else
				Result := default_buffer_suffix
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	feature_suffix: STRING is
			-- Retrieves buffer feature name suffix
		local
			l_suffix: like suffix
		once
			Result := suffix
			if Result = Void then
				Result := default_feature_suffix
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic Operations

	generate (a_doc: INI_DOCUMENT; a_frame: STRING; a_class_name: STRING; a_output: STRING) is
			-- Generates a matrix file.
		require
			not_a_class_name_is_empty: a_class_name /= Void implies not a_class_name.is_empty
			not_a_output_is_empty: a_output /= Void implies not a_output.is_empty
		local
			l_props: LIST [INI_PROPERTY]
			l_prop: INI_PROPERTY
			l_cursor: CURSOR
			l_cn: STRING
			l_of: STRING
			l_pw: STRING
			l_ph: STRING
			l_wid: STRING
			l_hgt: STRING
			l_buffer: STRING
		do
			reset

				-- Set class name
			if a_class_name = Void then
				l_prop := a_doc.property_of_name (class_name_property, True)
				if l_prop = Void or else l_prop.is_empty then
					l_cn := default_class_name
				else
					l_cn := l_prop.value
				end
			else
				l_cn := a_class_name
			end
			l_cn := format_eiffel_name (l_cn)
			l_cn.to_upper

				-- Set output file name
			if a_output = Void then
				l_of := l_cn.as_lower + ".e"
			else
				l_of := a_output
			end

			l_prop := a_doc.property_of_name (pixel_width_property, True)
			if l_prop /= Void and then l_prop.value.is_integer and then l_prop.value.to_integer > 0 then
				l_pw := l_prop.value
			else
				error_manager.set_last_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([pixel_width_property]), False)
				l_pw := default_nan
			end
			l_prop := a_doc.property_of_name (pixel_height_property, True)
			if l_prop /= Void and then l_prop.value.is_integer and then l_prop.value.to_integer > 0 then
				l_ph := l_prop.value
			else
				error_manager.set_last_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([pixel_height_property]), False)
				l_ph := default_nan
			end
			l_prop := a_doc.property_of_name (width_property, True)
			if l_prop /= Void and then l_prop.value.is_integer and then l_prop.value.to_integer > 0 then
				l_wid := l_prop.value
				width := l_wid.to_integer
			else
				error_manager.set_last_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([width_property]), False)
				l_wid := default_nan
			end
			l_prop := a_doc.property_of_name (height_property, True)
			if l_prop /= Void and then l_prop.value.is_integer and then l_prop.value.to_integer > 0 then
				l_hgt := l_prop.value
				height := l_hgt.to_integer
			else
				error_manager.set_last_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([height_property]), False)
				l_hgt := default_nan
			end
			l_prop := a_doc.property_of_name (suffix_property, True)
			if l_prop /= Void and then not l_prop.value.is_empty then
				suffix := l_prop.value
			else
				suffix := Void
			end

			if a_doc.property_of_name (access_property, True) /= Void then
				error_manager.set_last_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([access_property]), False)
			end
			if a_doc.property_of_name (implementation_property, True) /= Void then
				error_manager.set_last_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([implementation_property]), False)
			end

			if error_manager.successful then
					-- If successful
				create l_buffer.make (1024) -- 1mb should be big enough
				l_buffer.append (a_frame)

				process_sections (a_doc.sections)

					-- Replace tokens
				l_props := a_doc.named_properties
				if not l_props.is_empty then
					l_cursor := l_props.cursor
					from l_props.start until l_props.after loop
						l_prop := l_props.item
						if l_prop.has_value then
							l_buffer.replace_substring_all (token_variable (l_prop.name), l_prop.value)
						else
							l_buffer.replace_substring_all (token_variable (l_prop.name), "")
						end
						l_props.forth
					end
					l_props.go_to (l_cursor)
				end

				l_buffer.replace_substring_all (implementation_token, text_buffer ({MATRIX_BUFFER_TYPE}.implementation))
				l_buffer.replace_substring_all (access_token, text_buffer ({MATRIX_BUFFER_TYPE}.access))

				generate_output_file (l_of, l_buffer)
				generated_file_name := l_of
			end
		ensure
			generated_file_name_attached: error_manager.successful implies generated_file_name /= Void
		end

feature {NONE} -- Basic Operations

	reset is
			-- Resets generator
		do
			width := 0
			height := 0
			current_x := 0
			current_y := 0
			create access_buffer.make (512)
			create implementation_buffer.make (512)
		ensure
			width_reset: width = 0
			height_reset: height = 0
			current_x_reset: current_x = 0
			current_y_reset: current_y = 0
			access_buffer_reset: access_buffer /= Void and then access_buffer.is_empty
			implementation_buffer_reset: implementation_buffer /= Void and then implementation_buffer.is_empty
		end

	generate_output_file (a_file_name: STRING; a_content: STRING) is
			-- Generates output file `a_file_name' containing `a_content'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_content_attached: a_content /= Void
			not_a_content_is_empty: not a_content.is_empty
		local
			l_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make (a_file_name)
				if l_file.exists then
					l_file.delete
				end
				l_file.open_write
				l_file.put_string (a_content)
			else
				error_manager.set_last_error (create {ERROR_CREATING_FILE}.make_with_context ([a_file_name]), False)
			end
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Processing

	process_sections (a_sections: LIST [INI_SECTION]) is
			-- Process a section in an INI file.
		require
			a_sections_attached: a_sections /= Void
		local
			l_cursor: CURSOR
			l_item: INI_SECTION
			l_height: like height
			y: INTEGER
		do
			l_height := height
			l_cursor := a_sections.cursor
			from a_sections.start until a_sections.after loop
				l_item := a_sections.item
				y := current_y
				if y = 0 or else not is_continuation_section (l_item) then
					y := y + 1
					current_x := 0
				end
				current_y := y
				if y <= l_height then
					process_section (l_item)
				else
					error_manager.add_warning (create {WARNING_OUT_OF_BOUNDS}.make_with_context ([l_item.label, "section"]))
				end
				a_sections.forth
			end
			a_sections.go_to (l_cursor)
		ensure
			a_sections_unmoved: a_sections.cursor.is_equal (old a_sections.cursor)
		end

	process_section (a_section: INI_SECTION) is
			-- Process a section in an INI file.
		require
			a_section_attached: a_section /= Void
		local
			l_label: STRING
			l_prefix: STRING
			l_full_name: STRING
			l_name: STRING
			l_literals: LIST [INI_LITERAL]
			l_lit: INI_LITERAL
			l_cursor: CURSOR
			l_height: like height
			l_width: like width
			x, y: INTEGER
		do
			l_literals := a_section.literals
			if not l_literals.is_empty then

				l_height := height
				l_width := width
				x := current_x
				y := current_y

					-- Create feature prefix
				l_label := section_label (a_section)
				create l_prefix.make (l_label.count + 1)
				l_prefix.append (l_label)
				l_prefix.prune_all_trailing ('_')
				l_prefix.append_character ('_')

				l_cursor := l_literals.cursor
				from l_literals.start until l_literals.after loop
					x := x + 1
					if x > l_width then
						y := y + 1
						x := 1
					end
					l_lit := l_literals.item
					if y <= l_height then
						l_name := l_lit.name
						l_name.to_lower

						create l_full_name.make (l_prefix.count + l_name.count)
						l_full_name.append (l_prefix)
						l_full_name.append (l_name)
						l_full_name := format_eiffel_name (l_full_name)

						extend_buffer ({MATRIX_BUFFER_TYPE}.access, string_formatter.format (access_template, [l_full_name, l_lit.name, x, y, feature_suffix]))
						extend_buffer ({MATRIX_BUFFER_TYPE}.access, string_formatter.format (access_buffer_template, [l_full_name, l_lit.name, x, y, buffer_suffix]))
					else
						error_manager.add_warning (create {WARNING_OUT_OF_BOUNDS}.make_with_context ([l_lit.name, "item"]))
					end

					l_literals.forth
				end
				l_literals.go_to (l_cursor)

				current_x := x
				current_y := y
			end
		end

	section_label (a_section: INI_SECTION): STRING is
			-- Retrieves formatted section label from `a_section'
		require
			a_section_attached: a_section /= Void
		local
			l_label: STRING
		do
			l_label := a_section.label
			if is_continuation_section (a_section) and l_label.count > 1 then
				Result := l_label.substring (2, l_label.count)
			else
				Result := l_label
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	is_continuation_section (a_section: INI_SECTION): BOOLEAN is
			-- Determines if section `a_section' is a continued section (does not increate `current_y').
		require
			a_section_attached: a_section /= Void
		do
			Result := a_section.label.item (1) = continue_mark
		end

feature {NONE} -- Buffers

	extend_buffer (a_type: MATRIX_BUFFER_TYPE; a_str: STRING) is
			-- Extends buffer `a_type' with `a_str'
		require
			a_str_attached: a_str /= Void
			not_a_str_is_empty: not a_str.is_empty
		local
			a_buffer: like text_buffer
		do
			a_buffer := text_buffer (a_type)
			a_buffer.append (a_str)
		ensure
			buffer_extended: text_buffer (a_type).count = old text_buffer (a_type).count + a_str.count
		end

	text_buffer (a_type: MATRIX_BUFFER_TYPE): STRING is
			-- Retrieve a text buffer for a given type of buffer.
		do
			inspect a_type.to_integer
			when {MATRIX_BUFFER_TYPE}.access then
				Result := access_buffer
			when {MATRIX_BUFFER_TYPE}.implementation then
				Result := implementation_buffer
			else
				check False end
			end
		ensure
			result_attached: Result /= Void
		end

	access_buffer: STRING
			-- access variable buffer

	implementation_buffer: STRING
			-- implementation feature buffer		

feature {NONE} -- Formatting

	format_eiffel_name (a_name: STRING): STRING is
			-- Formats `a_name' into an Eiffel name
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_count: INTEGER
			c: CHARACTER
			i: INTEGER
		do
			l_count := a_name.count
			create Result.make (l_count)

			from i := 1	 until i > l_count loop
				c := a_name.item (i)
				if c.is_alpha or (i > 1 and c.is_digit or c = '_') then
					Result.append_character (c)
				elseif i > 1 then
					Result.append_character ('_')
				else
					Result.append ("x_")
				end
				i := i + 1
			end

			from l_count := -1 until l_count = Result.count loop
				Result.replace_substring_all ("__", "_")
				l_count := Result.count
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	current_x: INTEGER
			-- Current Y position in pixmap file

	current_y: INTEGER
			-- Current Y position in pixmap file

	suffix: STRING
			-- Generated feature name suffix

	frozen string_formatter: STRING_FORMATTER
			-- Access to string formatter
		once
			create Result
		end

feature {NONE} -- Constant Property Names

	default_buffer_suffix: STRING is "_buffer"
	default_feature_suffix: STRING is "_icon"

feature {NONE} -- Constant Property Names

	class_name_property: STRING is "name"
	pixel_width_property: STRING is "pixel_width"
	pixel_height_property: STRING is "pixel_height"
	width_property: STRING is "width"
	height_property: STRING is "height"
	suffix_property: STRING is "suffix"
	access_property: STRING is "access"
	implementation_property: STRING is "implementation"

	continue_mark: CHARACTER is '@'
			-- Character mark on sections to indication a continuation

feature {NONE} -- Constant Default Values	

	default_class_name: STRING is "PIXMAP_MATRIX"
	default_nan: STRING is "NaN"

feature {NONE} -- Tokens

	access_token: STRING is "${ACCESS}"
	implementation_token: STRING is "${IMPLEMENTATION}"

	token_variable (a_name: STRING): STRING is
			-- Returns a token varaible for token name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			create Result.make (a_name.count + 23)
			Result.append ("${")
			Result.append (a_name.as_upper)
			Result.append_character ('}')
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constant Templates

	access_template: STRING is "%T{1}{5}: EV_PIXMAP is%N%
		%%T%T%T-- Access to '{2}' pixmap.%N%
		%%T%Tonce%N%
		%%T%T%TResult := pixmap_from_coords ({3}, {4})%N%
		%%T%Tend%N%N"
			-- Template used for access features

	access_buffer_template: STRING is "%T{1}{5}: EV_PIXEL_BUFFER is%N%
		%%T%T%T-- Access to '{2}' pixmap pixel buffer.%N%
		%%T%Tonce%N%
		%%T%T%TResult := pixel_buffer_from_coords ({3}, {4})%N%
		%%T%Tend%N%N"
			-- Template used for access pixel buffer features

invariant
	height_non_negative: height >= 0
	width_non_negative: width >= 0
	current_x_non_negative: current_x >= 0
	current_y_non_negative: current_y >= 0
	not_suffix_is_empty: suffix /= Void implies not suffix.is_empty
	generated_file_name_not_empty: generated_file_name /= Void implies not generated_file_name.is_empty

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

end -- class {MATRIX_FILE_GENERATOR}
