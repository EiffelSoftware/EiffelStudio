note
	description: "[
		Used to render a feature with its local variables
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_FEATURE_ELEMENT

inherit
	XEL_SERVLET_ELEMENT

create
	make,
	make_with_locals

feature -- Initialization

	make (a_signature: STRING)
			-- `a_signature': The signature of the feature
		do
			make_with_expressions (a_signature, create {ARRAYED_LIST [XEL_SERVLET_ELEMENT]}.make (5))
		end

	make_with_expressions (a_signature: STRING; a_content: LIST [XEL_SERVLET_ELEMENT])
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
		require
			signature_valid: not a_signature.is_empty
		local
			list: LIST [XEL_VARIABLE_ELEMENT]
		do
			create {LINKED_LIST [XEL_VARIABLE_ELEMENT]} list.make
			make_with_locals (a_signature, a_content, list)
		end

	make_with_locals (a_signature: STRING; a_content: LIST [XEL_SERVLET_ELEMENT]; some_locals: LIST[XEL_VARIABLE_ELEMENT])
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
			-- `some_locals': The local variables of the feature
		require
			signature_valid: not a_signature.is_empty
		do
			signature := a_signature
			locals := some_locals
			content := a_content
			variable_count := 0
		end

feature {NONE} -- Access

	variable_count: NATURAL
			-- Used to generate unique identifiers

feature -- Access

	signature: STRING
			-- Signature of the feature

	locals: LIST [XEL_VARIABLE_ELEMENT]
			-- The local variables of the feature

	content: LIST [XEL_SERVLET_ELEMENT]
			-- The body expressions of the feature

	append_local (name, type: STRING)
			-- Appends a {XEL_PLAIN_CODE_ELEMENT} to the feature
		require
			name_is_valid: not name.is_empty
			type_is_valid: not type.is_empty
		do
			locals.extend (create {XEL_VARIABLE_ELEMENT}.make (name, type))
		ensure
			local_has_been_added: old locals.count + 1 = locals.count
		end

	append_expression (expression: STRING)
			-- Appends a {XEL_PLAIN_CODE_ELEMENT} to the feature
		require
			expression_is_valid: not expression.is_empty
		do
			content.extend (create {XEL_PLAIN_CODE_ELEMENT}.make (expression))
		ensure
			expression_has_been_added: old content.count + 1 = content.count
		end

	get_temp_variable: STRING
			-- Generates a name for a unique (feature scope) temp variable
		do
			Result := "temp_" + variable_count.out
		end

feature -- Implementation

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (signature)
			buf.indent
			if not locals.is_empty then
				buf.put_string ("local")
				buf.indent
				from
					locals.start
				until
					locals.after
				loop
					locals.item.serialize (buf)
					locals.forth
				end
				buf.unindent
			end
			buf.put_string ("do")
			buf.indent
			from
				content.start
			until
				content.after
			loop
				content.item.serialize (buf)
				content.forth
			end
			buf.unindent
			buf.put_string ("end")
			buf.unindent
		end

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
