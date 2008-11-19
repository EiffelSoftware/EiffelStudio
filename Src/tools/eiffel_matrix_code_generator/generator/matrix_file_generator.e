indexing
	description: "[
		A base matrix configuration INI file processor.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MATRIX_FILE_GENERATOR

inherit
	MULTI_ERROR_MANAGER
		rename
			make as make_error_manager,
			reset as reset_error_manager,
			class_name as c_class_name
		export
			{NONE} all
			{ANY} successful, trace_errors, trace_warnings, errors, warnings
		end

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			make_error_manager
			reset
		end

feature -- Access

	height: NATURAL
			-- Height of matrix

	width: NATURAL
			-- Width of matrix

	pixel_height: NATURAL
			-- Tile pixel height

	pixel_width: NATURAL
			-- Tile pixel width

	pixel_border: NATURAL
			-- Border used to separate icons

feature {NONE} -- Access

	current_x: NATURAL
			-- Current Y position in matrix file

	current_y: NATURAL
			-- Current Y position in matrix file

	suffix: STRING
			-- Generated icon name suffix

feature -- Status report

	is_document_processed: BOOLEAN
			-- Inidicates if a document has been processed, in which case `reset' should be called.

feature {NONE} -- Status report

	is_continuation_section (a_section: INI_SECTION): BOOLEAN
			-- Determines if section `a_section' is a continued section (does not increate `current_y').
		require
			a_section_attached: a_section /= Void
		do
			Result := a_section.label.item (1) = continue_mark
		end

feature {NONE} -- Query

	section_label (a_section: INI_SECTION): STRING
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

	icon_prefix (a_literal: INI_LITERAL): !STRING
			-- Retrieves a icon prefix for `a_literal'
		require
			a_literal_attached: a_literal /= Void
		local
			l_section: INI_SECTION
			l_label: STRING
		do
			l_section ?= a_literal.container
			check
				l_section_attached: l_section /= Void
			end
			l_label := section_label (l_section)
			create Result.make (l_label.count + 1)
			Result.append (l_label)
			Result.prune_all_trailing ('_')
			Result.append_character ('_')
		end

	icon_suffix: !STRING
			-- Retrieves icon name suffix
		do
			if {l_suffix: STRING} suffix then
				Result := l_suffix
			else
				Result := default_icon_suffix
			end
		end
		
feature -- Basic Operations

	process (a_doc: INI_DOCUMENT; a_post_validate: PROCEDURE [ANY, TUPLE]; a_post_process: PROCEDURE [ANY, TUPLE]) is
			-- Processes INI document `a_doc' and executes `a_post_validate' to do other initalization once the basics have been validated
			-- and `a_post_validate' on post processing
		require
			a_doc_attached: a_doc /= Void
		do
			if is_document_processed then
				reset
			end

			process_properties (a_doc.properties)
			validate_properties (a_doc)
			if successful then
				if a_post_validate /= Void then
					a_post_validate.call ([])
				end
				if successful then
					process_sections (a_doc.sections)
					if a_post_process /= Void and then successful then
						a_post_process.call ([])
					end
				end
			end

			is_document_processed := True
		ensure
			is_document_processed: is_document_processed
		end

feature {NONE} -- Basic Operations

	reset is
			-- Resets generator
		do
			width := 0
			height := 0
			pixel_height := 0
			pixel_width := 0
			pixel_border := 1
			current_x := 0
			current_y := 0
			is_document_processed := False
			reset_error_manager
		ensure
			width_reset: width = 0
			height_reset: height = 0
			pixel_height_reset: pixel_height = 0
			pixel_width_reset: pixel_width = 0
			pixel_border_reset: pixel_border = 1
			current_x_reset: current_x = 0
			current_y_reset: current_y = 0
			not_is_document_processed: not is_document_processed
		end

feature {NONE} -- Processing

	process_properties (a_properties: LIST [INI_PROPERTY])
			-- Process document properties
		require
			a_properties_attached: a_properties /= Void
		local
			l_cursor: CURSOR
		do
			l_cursor := a_properties.cursor
			from a_properties.start until a_properties.after loop
				process_property (a_properties.item).do_nothing
				a_properties.forth
			end
			a_properties.go_to (l_cursor)
		ensure
			a_properties_unmoved: a_properties.cursor.is_equal (old a_properties.cursor)
		end

	process_property (a_property: INI_PROPERTY): BOOLEAN
			-- Process document properties
		require
			a_property_attached: a_property /= Void
		local
			l_name: STRING
			l_value: STRING
		do
			Result := True
			l_name := a_property.name.as_lower
			l_value := a_property.value
			if l_name.is_equal (pixel_width_property) then
				if l_value.is_natural then
					pixel_width := l_value.to_natural
				end
			elseif l_name.is_equal (pixel_height_property) then
				if l_value.is_natural then
					pixel_height := l_value.to_natural
				end
			elseif l_name.is_equal (width_property) then
				if l_value.is_natural then
					width := l_value.to_natural
				end
			elseif l_name.is_equal (height_property) then
				if l_value.is_natural then
					height := l_value.to_natural
				end
			elseif l_name.is_equal (pixel_border_property) then
				if not l_value.is_natural then
					pixel_border := l_value.to_natural
				end
			elseif l_name.is_equal (suffix_property) then
				if not l_value.is_empty then
					suffix := l_value
				end
			else
				Result := False
			end
		end

	process_sections (a_sections: LIST [INI_SECTION])
			-- Process a section in an INI file.
		require
			successful: successful
			a_sections_attached: a_sections /= Void
		local
			l_cursor: CURSOR
			l_item: INI_SECTION
			l_height: like height
			y: NATURAL
		do
			l_height := height
			l_cursor := a_sections.cursor
			from a_sections.start until a_sections.after or not successful loop
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
					add_warning (create {WARNING_OUT_OF_BOUNDS}.make_with_context ([l_item.label, "section"]))
				end
				a_sections.forth
			end
			a_sections.go_to (l_cursor)
		ensure
			a_sections_unmoved: a_sections.cursor.is_equal (old a_sections.cursor)
		end

	process_section (a_section: INI_SECTION)
			-- Process a section in an INI file.
		require
			successful: successful
			a_section_attached: a_section /= Void
		local
			l_literals: LIST [INI_LITERAL]
			l_lit: INI_LITERAL
			l_cursor: CURSOR
			l_height: like height
			l_width: like width
			x, y: NATURAL
		do
			l_literals := a_section.literals
			if not l_literals.is_empty then
				l_height := height
				l_width := width
				x := current_x
				y := current_y

				l_cursor := l_literals.cursor
				from l_literals.start until l_literals.after or not successful loop
					x := x + 1
					if x > l_width then
						y := y + 1
						x := 1
					end
					l_lit := l_literals.item
					if y <= l_height then
						process_literal_item (l_lit, x, y)
					else
						add_warning (create {WARNING_OUT_OF_BOUNDS}.make_with_context ([l_lit.name, "item"]))
					end

					l_literals.forth
				end
				l_literals.go_to (l_cursor)

				current_x := x
				current_y := y
			end
		end

	process_literal_item (a_item: INI_LITERAL; a_x: NATURAL; a_y: NATURAL)
			-- Processes a literal from an INI matrix file.
		require
			successful: successful
			a_item_attached: a_item /= Void
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= width
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= height
		deferred
		end

feature {NONE} -- Validation

	validate_properties (a_doc: INI_DOCUMENT)
			-- Validates properties examined in `generate' or those that are in `a_doc' that have not been examined from some reason.
		require
			a_doc_attached: a_doc /= Void
		do
			if pixel_height = 0 then
				add_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([pixel_width_property]), False)
			end
			if pixel_width = 0 then
				add_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([pixel_height_property]), False)
			end
			if width = 0 then
				add_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([width_property]), False)
			end
			if height = 0 then
				add_error (create {ERROR_MISSING_INI_FILE_PROPERTIES}.make_with_context ([height_property]), False)
			end
		end

feature {NONE} -- Formatting

	format_eiffel_name (a_name: STRING): !STRING
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
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constants: Defaults

	default_icon_suffix: !STRING = "_icon"
			-- Default icon suffix for a full icon name generation.

feature {NONE} -- Constants: Property Names

	class_name_property: !STRING = "name"
	width_property: !STRING = "width"
	height_property: !STRING = "height"
	pixel_width_property: !STRING = "pixel_width"
	pixel_height_property: !STRING = "pixel_height"
	pixel_border_property: !STRING = "pixel_border"
	suffix_property: !STRING = "suffix"

	continue_mark: CHARACTER = '@'
			-- Character mark on sections to indication a continuation

invariant
	not_suffix_is_empty: suffix /= Void implies not suffix.is_empty

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
