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

	class_name: STRING
			-- Class name specified in matrix file

--	icon_buffer_suffix: STRING
--			-- Retrieves buffer feature name suffix. This is either a default suffix of one set in `suffix'
--			-- This is
--		local
--			l_suffix: like suffix
--		once
--			l_suffix := suffix
--			if l_suffix /= Void then
--				create  Result.make (default_buffer_suffix.count + l_suffix.count)
--				Result.append (l_suffix)
--				Result.append (default_buffer_suffix)
--			else
--				Result := default_buffer_suffix
--			end
--		ensure
--			result_attached: Result /= Void
--			not_result_is_empty: not Result.is_empty
--		end

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
			l_buffers: like internal_buffers
			l_fragment: STRING
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

						-- Replace optional tokens.
					if class_name /= Void and then not class_name.is_empty then
						l_buffer.replace_substring_all (token_variable (class_name_property), class_name)
					else
						l_buffer.replace_substring_all (token_variable (class_name_property), "")
					end
					l_buffer.replace_substring_all (token_variable (pixel_border_property), pixel_border.out)

						-- Replace aux tokens based on other properties in the configuration file
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

						-- Replace the used buffers
					l_buffers := internal_buffers
					if not l_buffers.is_empty then
						from l_buffers.start until l_buffers.after loop
							l_fragment := l_buffers.item_for_iteration
							if not l_fragment.is_empty and then l_fragment.item (l_fragment.count) = '%N' then
								l_fragment.keep_head (l_fragment.count - 1)
							end
							l_buffer.replace_substring_all (token_variable (l_buffers.key_for_iteration), l_fragment)
							l_buffers.forth
						end
					end

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

	reset
			-- Resets generator
		do
			class_name := Void
			create internal_buffers.make (4)
			Precursor {MATRIX_FILE_GENERATOR}
		ensure then
			class_name_reset: class_name = Void
			internal_buffers_reset: internal_buffers.is_empty
		end

	generate_output_file (a_file_name: STRING; a_content: STRING)
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
			l_name: STRING
			l_base: STRING
			l_prefix: STRING
			l_isuffix: like icon_suffix
			l_ibsuffix: like icon_buffer_suffix
			l_csuffix: like name_suffix
			l_iname: STRING
			l_ibname: STRING
			l_cname: STRING
		do
				-- Create feature prefix
			l_prefix := icon_prefix (a_item)
			l_name := a_item.name
			l_name.to_lower

				-- Name constants
			l_csuffix := name_suffix
			create l_cname.make (l_name.count + l_prefix.count + l_csuffix.count)
			l_cname.append (l_prefix)
			l_cname.append (l_name)
			l_cname.append (l_csuffix)
			l_cname := format_eiffel_name (l_cname)
			buffer (icon_names_token).append (string_formatter.format (icon_name_constant_template, [l_cname, l_name]))

				-- Coordinates
			buffer (coordinates_token).append (string_formatter.format (icon_name_registration_template, [l_cname, a_x, a_y]))

			create l_base.make (l_prefix.count + l_name.count)
			l_base.append (l_prefix)
			l_base.append (l_name)

				-- Icon
			l_isuffix := icon_suffix
			create l_iname.make (l_base.count + l_isuffix.count)
			l_iname.append (l_base)
			l_iname.append (l_isuffix)
			l_iname := format_eiffel_name (l_iname)
			buffer (icons_token).append (string_formatter.format (icon_template, [l_iname, a_item.name, l_cname]))

				-- Icon buffer
			l_ibsuffix := icon_buffer_suffix
			create l_ibname.make (l_iname.count + l_ibsuffix.count)
			l_ibname.append (l_iname)
			l_ibname.append (l_ibsuffix)
			l_ibname := format_eiffel_name (l_ibname)
			buffer (icons_token).append (string_formatter.format (icon_buffer_template, [l_ibname, a_item.name, l_cname]))
		end

feature {NONE} -- Validation

	validate_properties (a_doc: INI_DOCUMENT) is
			-- Validates properties examined in `generate' or those that are in `a_doc' that have not been examined from some reason.
		do
			Precursor {MATRIX_FILE_GENERATOR} (a_doc)
			if a_doc.property_of_name (icons_token, True) /= Void then
				add_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([icons_token]), False)
			end
			if a_doc.property_of_name (icon_names_token, True) /= Void then
				add_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([icon_names_token]), False)
			end
			if a_doc.property_of_name (coordinates_token, True) /= Void then
				add_error (create {ERROR_MISSING_INI_RESERVED_PROPERTY}.make_with_context ([coordinates_token]), False)
			end
		end

feature {NONE} -- Query

	buffer (a_name: !STRING): !STRING
			-- Retrieves a text buffer given a name.
			--
			-- 'a_name':
			-- 'Result':
		require
			not_a_name_is_empty: not a_name.is_empty
		do
			if internal_buffers.has (a_name) then
				Result := internal_buffers.item (a_name)
			else
				create Result.make (1024)
				internal_buffers.put (Result, a_name)
			end
		ensure
			internal_buffers_has_a_name: internal_buffers.has (a_name)
			result_consistent: Result = buffer (a_name)
		end

	token_variable (a_name: ?STRING): !STRING
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
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Helpers

	frozen string_formatter: STRING_FORMATTER
			-- Access to string formatter
		once
			create Result
		end

feature {NONE} -- Tokens



feature {NONE} -- Constants: Defaults

	icon_buffer_suffix: STRING = "_buffer"
	name_suffix: STRING = "_name"
	default_class_name: STRING = "ICON_MATRIX"
	default_nan: STRING = "NaN"

feature {NONE} -- Constants: Token names

	icons_token: STRING = "ICONS"
	icon_names_token: STRING = "ICON_NAMES"
	coordinates_token: STRING = "COORDINATES"

feature {NONE} -- Constants: Templates

	icon_name_constant_template: !STRING = "%T{1}: !STRING = %"{2}%"%N"
			-- Template for icon name constants

	icon_name_registration_template: !STRING = "%T%T%Ta_table.force_last ([{2}, {3}], {1})%N"
			-- Template for icon name constants

	icon_template: !STRING =
			-- Template used for access features
		"%Tfrozen {1}: !EV_PIXMAP%N%
		%%T%T%T-- Access to '{2}' pixmap.%N%
		%%T%Trequire%N%
		%%T%T%Thas_named_icon: has_named_icon ({3})%N%
		%%T%Tonce%N%
		%%T%T%TResult := named_icon_pixmap ({3})%N%
		%%T%Tend%N%N"

	icon_buffer_template: !STRING =
			-- Template used for access pixel buffer features
		"%Tfrozen {1}: !EV_PIXEL_BUFFER%N%
		%%T%T%T-- Access to '{2}' pixmap pixel buffer.%N%
		%%T%Trequire%N%
		%%T%T%Thas_named_icon: has_named_icon ({3})%N%
		%%T%Tonce%N%
		%%T%T%TResult := named_icon_buffer ({3})%N%
		%%T%Tend%N%N"

--		%%T%T%TResult := ({{!EV_PIXEL_BUFFER}}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle ({3}, {4}))%N%

feature {NONE} -- Implementation: Internal cache

	internal_buffers: !HASH_TABLE [!STRING, !STRING]
			-- Table of cached buffers
			--
			-- Key: The name of the buffer
			-- Value: The actual text buffer

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
