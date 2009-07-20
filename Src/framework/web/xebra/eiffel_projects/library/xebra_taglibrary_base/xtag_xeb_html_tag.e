note
	description: "[
		This tag outputs plain html and plain text. Whitespaces are wrapped to newlines.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_HTML_TAG

inherit
	XTAG_PLAINTEXT_TAG
		redefine
			generates_render
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_base
			create attributes.make (2)
		ensure
			attributes_attached: attached attributes
		end

feature {NONE} -- Access

	attributes: HASH_TABLE [XTAG_TAG_ARGUMENT, STRING]
			-- The XHTML content
feature {NONE}

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_tag: STRING
			l_cashable: BOOLEAN
		do
			l_tag := "<" + tag_id
			l_cashable := True
			from
				attributes.start
			until
				attributes.after
			loop
				l_cashable := l_cashable and attributes.item_for_iteration.is_plain_text
				l_tag := l_tag + " " + attributes.key_for_iteration + "=%%%"" + attributes.item_for_iteration.value (current_controller_id) + "%%%""
				attributes.forth
			end
			l_tag := l_tag + ">"
			if l_cashable then
				write_string_to_result (l_tag, a_servlet_class.render_html_page)
			else
				write_string_to_result_uncashed (l_tag, a_servlet_class.render_html_page)
			end

			generate_children (a_servlet_class, a_variable_table)

			write_string_to_result ("</" + tag_id + ">", a_servlet_class.render_html_page)
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			attributes.put (a_attribute, a_id)
		end

	is_just_whitespace (a_string: STRING): BOOLEAN
		-- Checks, if `a_string' is only composed by whitespace characters
		local
			index: INTEGER
		do
			from
				index := 1
				Result := True
			until
				(not Result) or (index > a_string.count)
			loop
				Result := Result and (a_string [index].is_space or a_string [index].is_equal ('%N') or a_string [index].is_equal ('%T'))
				index := index + 1
			end
		end

	generates_render: BOOLEAN = True

invariant
	attributes_attached: attached attributes

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
