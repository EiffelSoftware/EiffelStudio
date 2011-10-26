note
	description: "[
		Used to render a class with its features, inherit and create clause
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
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
		require
			signature_valid: not a_signature.is_empty
		do
			name := a_signature
			constructor_name := ""
			precursor_name := "ANY"
			create {LINKED_LIST [XEL_FEATURE_ELEMENT]} features.make
			create {LINKED_LIST [XEL_VARIABLE_ELEMENT]} variables.make
			ui_count := 0
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
			-- Class scope variable-features

	ui_count: NATURAL
			-- Used for unique identifier generation

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
		require
			a_feature_attached: attached a_feature
		do
			features.extend (a_feature)
			a_feature.set_parent_class (Current)
		ensure
			feature_added: features.count = old features.count + 1
		end

	add_variable (a_variable: XEL_VARIABLE_ELEMENT)
			-- Adds a variable to the class.
		require
			a_variable_attached: attached a_variable
		do
			variables.extend (a_variable)
		ensure
			variable_added: variables.count = old variables.count + 1
		end

	add_variable_by_name_type (a_name, a_type: STRING)
			-- Adds a access feature to the class
		require
			a_name_valid: attached a_name and then not a_name.is_empty
			a_type_valid: attached a_type and then not a_type.is_empty
		do
			add_variable (create {XEL_VARIABLE_ELEMENT}.make (a_name, a_type))
		end

	new_variable (a_type: STRING): STRING
			-- Adds a new access feature to the class and selects the name itself
		require
			a_type_attached: attached a_type and then not a_type.is_empty
		do
			Result := unique_identifier
			add_variable_by_name_type (Result, a_type)
		ensure
			Result_attached: attached Result
			variable_added: variables.count = old variables.count + 1
		end

	add_const_variable_by_name_type (a_name, a_type, a_value: STRING)
			-- Adds a constant to the class
		require
			a_name_valid: attached a_name and then not a_name.is_empty
			a_type_valid: attached a_type and then not a_type.is_empty
			a_value_valid: attached a_value and then not a_value.is_empty
		do
			add_variable (create {XEL_VARIABLE_ELEMENT}.make_const (a_name, a_type, a_value))
		ensure
			variable_added: variables.count = old variables.count + 1
		end

	unique_identifier: STRING
			-- Generates a name for a unique (feature scope) temp variable
		do
			Result := "class_temp_" + ui_count.out
			ui_count := ui_count + 1
		ensure
			Result_attached: attached Result
			ui_count_changed: ui_count /= old ui_count
		end

feature -- Implementation

	serialize (a_buf: XU_INDENDATION_FORMATTER)
			-- <Precursor>			
		do
			a_buf.put_string (header_note)

			a_buf.put_new_line

			a_buf.put_string (class_kw)
			a_buf.indent
			a_buf.put_string (name)
			a_buf.unindent
			a_buf.put_new_line

			a_buf.put_string (inherit_kw)
			a_buf.indent
			a_buf.put_string (precursor_name)
			a_buf.unindent
			a_buf.put_new_line

			if not constructor_name.is_empty then
				a_buf.put_string (create_kw)
				a_buf.indent
				a_buf.put_string (constructor_name)
				a_buf.unindent
				a_buf.put_new_line
			end

			a_buf.put_string (feature_kw + "-- Access")
			a_buf.put_new_line
			a_buf.indent
			from
				variables.start
			until
				variables.after
			loop
				variables.item.serialize (a_buf)
				variables.forth
				a_buf.put_new_line
			end
			a_buf.unindent

			a_buf.put_string (feature_kw + "-- Implementation")
			a_buf.put_new_line
			a_buf.indent
			from
				features.start
			until
				features.after
			loop
				features.item.serialize (a_buf)
				features.forth
				a_buf.put_new_line
			end
			a_buf.unindent
			a_buf.append_string (footer)
			a_buf.put_string (end_kw)

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
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
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
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
