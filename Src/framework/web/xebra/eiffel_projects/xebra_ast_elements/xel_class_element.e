note
	description: "[
		Used to render a class with its features, inherit and create clause
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_CLASS_ELEMENT

inherit
	XEL_SERVLET_ELEMENT

create
	make


feature -- Initialization

	make (a_signature: STRING)
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
		require
			signature_valid: not a_signature.is_empty
		do
			name := a_signature
			constructor_name := ""
			precursor_name := "ANY"
			create {LINKED_LIST [XEL_FEATURE_ELEMENT]} features.make
			create {LINKED_LIST [XEL_VARIABLE_ELEMENT]} variables.make
		end

feature {NONE} -- Access

	name: STRING
			-- Name of the class

	constructor_name: STRING
			-- Name of the create method

	features: LIST [XEL_FEATURE_ELEMENT]
			-- The local variables of the feature

	precursor_name: STRING
			-- The precursor class

	variables: LIST [XEL_VARIABLE_ELEMENT]

feature -- Access

	set_inherit (a_precursor_name: STRING)
			-- Sets the precursor class name.
		require
			a_precursor_name_is_valid: not a_precursor_name.is_empty
		do
			precursor_name := a_precursor_name
		end

	set_constructor_name (a_constructor_name: STRING)
			-- Sets the constructor name.
		require
			a_constructor_name: not a_constructor_name.is_empty
		do
			constructor_name := a_constructor_name
		end

	add_feature (a_feature: XEL_FEATURE_ELEMENT)
			-- Adds a feature to the class.
		do
			features.extend (a_feature)
		end

	add_variable (a_variable: XEL_VARIABLE_ELEMENT)
			-- Adds a variable to the class.
		do
			variables.extend (a_variable)
		end

	add_variable_by_name_type (a_name, a_type: STRING)
			-- Adds a access feature to the class
		do
			add_variable (create {XEL_VARIABLE_ELEMENT}.make (a_name, a_type))
		end

feature -- Implementation

	serialize (buf:XU_INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (header_note)

			buf.put_new_line

			buf.put_string (class_kw)
			buf.indent
			buf.put_string (name)
			buf.unindent
			buf.put_new_line

			buf.put_string (inherit_kw)
			buf.indent
			buf.put_string (precursor_name)
			buf.unindent
			buf.put_new_line

			if not constructor_name.is_empty then
				buf.put_string (create_kw)
				buf.indent
				buf.put_string (constructor_name)
				buf.unindent
				buf.put_new_line
			end

			buf.put_string (feature_kw + "-- Access")
			buf.put_new_line
			buf.indent
			from
				variables.start
			until
				variables.after
			loop
				variables.item.serialize (buf)
				variables.forth
				buf.put_new_line
			end
			buf.unindent

			buf.put_string (feature_kw + "-- Implementation")
			buf.put_new_line
			buf.indent
			from
				features.start
			until
				features.after
			loop
				features.item.serialize (buf)
				features.forth
				buf.put_new_line
			end
			buf.unindent
			buf.append_string (footer)
			buf.put_string (end_kw)

		end

feature {NONE} -- Constants

		class_kw: STRING = "class"
		feature_kw: STRING = "feature"
		inherit_kw: STRING = "inherit"
		create_kw: STRING = "create"
		local_kw: STRING = "local"
		do_kw: STRING = "do"
		end_kw: STRING = "end"

		header_note: STRING =
"{
note
	description: "[
		No comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"
}"

		footer: STRING =
"{
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
}"

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
