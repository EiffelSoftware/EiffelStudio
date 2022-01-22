note
	description: "A command to export Eiffel code in some other format."

class
	E_EXPORT

inherit
	E_CMD
	SHARED_LOCALE
	SHARED_WORKBENCH
	SHARED_SERVER

create
	make

feature {NONE} -- Creation

	make
			-- Initialize the command.
		do
			create classes.make (1)
		end

feature {NONE} -- Access

	classes: ARRAYED_LIST [READABLE_STRING_32]
			-- A list of classes to export.

feature -- Modification

	add_class (c: READABLE_STRING_32)
			-- Add a class of name `c` to the list of classes to process.
		do
			classes.extend (c)
		ensure
			classes.has (c)
		end

feature {NONE} -- Execution

	execute
			-- <Precursor>
		local
			cs: like {UNIVERSE_I}.compiled_classes_with_name
			has_error: BOOLEAN
			class_list: ARRAYED_LIST [CLASS_C]
			g: B_NODE_JSON_GENERATOR
		do
				-- Clean up the state.
			create class_list.make (classes.count)
			if attached workbench.universe as u then
					-- Add classes if possible.
				⟳ n: classes ¦
					cs := u.compiled_classes_with_name ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (n))
					if cs.is_empty then
						has_error := True
						output_window.add (locale.formatted_string (locale.translation_in_context ("Class `$1` is not found or not compiled.", "command.export"), n))
						output_window.add_new_line
					else
						⟳ c: cs ¦ class_list.extend (c.compiled_class) ⟲
					end
				⟲
			else
				has_error := True
				output_window.add (locale.translation_in_context ("The project is not compiled.", "command.export"))
				output_window.add_new_line
			end
			if not has_error then
					-- Export selected classes.
				create g.make (io.output)
				⟳ c: class_list ¦
					⟳ f: c.written_in_features ¦
						if attached byte_server.disk_item (f.associated_feature_i.body_index) as code then
							code.process (g)
						end
					⟲
				⟲
			end
			classes.wipe_out
		end

feature {NONE} -- Output

	output_window: OUTPUT_WINDOW
			-- Output sink.
		do
			Result := {ES}.command_line_io.output_window
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	author: "Alexander Kogtenkov"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	licensing_options: "http://www.eiffel.com/licensing"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
