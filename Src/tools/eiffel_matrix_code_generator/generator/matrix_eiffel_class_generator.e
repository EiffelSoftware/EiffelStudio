indexing
	description: "[
		A generator for creating Eiffel classes from a matrix INI file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MATRIX_EIFFEL_CLASS_GENERATOR

inherit
	MATRIX_FILE_GENERATOR
		redefine
			reset,
			process_property,
			validate_properties
		end

	ERROR_SHARED_ERROR_MANAGER
		export
			{NONE} all
		end

create
	make

feature -- Access

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
			l_of: STRING
			l_buffer: STRING
		do
			reset

			class_name := a_class_name
			if successful then
					-- If successful
				create l_buffer.make (1024) -- 1mb should be big enough
				l_buffer.append (a_frame)

				process (a_doc, agent
					do
						if class_name = Void then
							class_name := default_class_name
						end
					end, Void)

				if successful then
					check
						class_name_attached: class_name /= Void
					end

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

					if a_output = Void then
						l_of := class_name + ".e"
						l_of.to_lower
					else
						l_of := a_output
					end
					generate_output_file (l_of, l_buffer)
					generated_file_name := l_of
				end
			end
		ensure
			generated_file_name_attached: successful implies generated_file_name /= Void
		end

feature {NONE} -- Basic Operations

	reset is
			-- Resets generator
		do
			class_name := Void
			create access_buffer.make (512)
			create implementation_buffer.make (512)
			Precursor {MATRIX_FILE_GENERATOR}
		ensure then
			class_name_reset: class_name = Void
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

	process_property (a_property: INI_PROPERTY): BOOLEAN is
			-- Process document properties
		local
			l_name: STRING
			l_value: STRING
		do
			Result := Precursor {MATRIX_FILE_GENERATOR} (a_property)
			if not Result then
				l_name := a_property.name.as_lower
				l_value := a_property.value
				if l_name.is_equal (class_name_property) then
					if class_name = Void then
						class_name := format_eiffel_name (l_value)
					end
				end
			end
		end

	process_literal_item (a_item: INI_LITERAL; a_x: NATURAL_32; a_y: NATURAL_32)
			-- Processes a literal from an INI matrix file.
		local
			l_prefix: STRING
			l_full_name: STRING
			l_name: STRING
			l_fsuffix: like tile_suffix
			l_bsuffix: like buffer_suffix
			l_fname: STRING
			l_bname: STRING
		do
			l_fsuffix := tile_suffix
			l_bsuffix := buffer_suffix

				-- Create feature prefix
			l_prefix := tile_prefix (a_item)

			l_name := a_item.name
			l_name.to_lower

			create l_full_name.make (l_prefix.count + l_name.count)
			l_full_name.append (l_prefix)
			l_full_name.append (l_name)
			l_full_name := format_eiffel_name (l_full_name)

			create l_fname.make (l_full_name.count + l_fsuffix.count)
			l_fname.append (l_full_name)
			l_fname.append (l_fsuffix)
			l_full_name := format_eiffel_name (l_fname)

			extend_buffer ({MATRIX_BUFFER_TYPE}.access, string_formatter.format (access_template, [l_full_name, a_item.name, a_x, a_y]))
			extend_buffer ({MATRIX_BUFFER_TYPE}.access, "%N")

			create l_bname.make (l_full_name.count + l_bsuffix.count)
			l_bname.append (l_full_name)
			l_bname.append (l_bsuffix)
			l_full_name := format_eiffel_name (l_bname)

			extend_buffer ({MATRIX_BUFFER_TYPE}.access, string_formatter.format (access_buffer_template, [l_full_name, a_item.name, a_x, a_y]))
			extend_buffer ({MATRIX_BUFFER_TYPE}.access, "%N")
		end

feature {NONE} -- Validation

	validate_properties (a_doc: INI_DOCUMENT) is
			-- Validates properties examined in `generate' or those that are in `a_doc' that have not been examined from some reason.
		do
			Precursor {MATRIX_FILE_GENERATOR} (a_doc)
			if a_doc.property_of_name (access_property, True) /= Void then
				add_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([access_property]), False)
			end
			if a_doc.property_of_name (implementation_property, True) /= Void then
				add_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([implementation_property]), False)
			end
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



feature {NONE} -- Implementation

	class_name: STRING
			-- Class name specified in matrix file

	frozen string_formatter: STRING_FORMATTER
			-- Access to string formatter
		once
			create Result
		end

feature {NONE} -- Constant Property Names

	default_buffer_suffix: STRING is "_buffer"

feature {NONE} -- Constant Property Names

	class_name_property: STRING is "name"
	access_property: STRING is "access"
	implementation_property: STRING is "implementation"

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

	access_template: STRING is "%Tfrozen {1}: !EV_PIXMAP is%N%
		%%T%T%T-- Access to '{2}' pixmap.%N%
		%%T%Tonce%N%
		%%T%T%TResult := ({{!EV_PIXMAP}}) #? raw_buffer.sub_pixmap (pixel_rectangle ({3}, {4}))%N%
		%%T%Tend%N"
			-- Template used for access features

	access_buffer_template: STRING is "%Tfrozen {1}: !EV_PIXEL_BUFFER is%N%
		%%T%T%T-- Access to '{2}' pixmap pixel buffer.%N%
		%%T%Tonce%N%
		%%T%T%TResult := ({{!EV_PIXEL_BUFFER}}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle ({3}, {4}))%N%
		%%T%Tend%N"
			-- Template used for access pixel buffer features

invariant
	generated_file_name_not_empty: generated_file_name /= Void implies not generated_file_name.is_empty
	class_name_not_empty: class_name /= Void implies not class_name.is_empty

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

end -- class {MATRIX_EIFFEL_CLASS_GENERATOR}
