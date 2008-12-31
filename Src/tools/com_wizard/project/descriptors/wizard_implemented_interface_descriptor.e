note
	description: "Implemented interface descriptor."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR

inherit
	WIZARD_COMPONENT_DESCRIPTOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_FILE_NAME_FACTORY
		export
			{NONE} all
		end

	WIZARD_UNIQUE_IDENTIFIER_FACTORY
		export
			{NONE} all
		end

create
	make_from_interface

feature -- Initialization

	make_from_interface (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR)
			-- Initialize
		require
			non_void_descriptor: a_descriptor /= Void
		do
			interface_descriptor := a_descriptor
			type_kind := Tkind_coclass
			name := a_descriptor.name.twin
			namespace := a_descriptor.namespace.twin
			name.append ("_impl")
			c_type_name := name.twin
			eiffel_class_name := name_for_class (name, type_kind, True)
			c_definition_header_file_name := header_name (namespace, name)
			c_declaration_header_file_name := declaration_header_file_name (c_definition_header_file_name)
			description := "Implemented %Q"
			description.append (a_descriptor.name)
			description.append ("%' interface.")
			type_library_descriptor := a_descriptor.type_library_descriptor
			disambiguate_argument_names
		end

feature -- Access

	interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	creation_message: STRING
			-- Creation message for wizard output
		do
			create Result.make (1024)
			Result.append ("Processing implemented ")
			if interface_descriptor.dispinterface then
				Result.append ("dispatch interface ")
			else
				Result.append ("interface ")
			end
			Result.append (name)
			Result.append_character ('.')
		end

	source: BOOLEAN
			-- Is source interface?

feature -- Basic operations

	disambiguate_argument_names
			-- We need to make sure there are no clashes between argument
			-- names and feature names because if we have interface IA with
			-- feature `f (g: ANY)' and interface IB inherit IA with feature
			-- `g' then the disambiguation of the feature names in the interfaces
			-- will not rename the argument name (and it's not needed because the
			-- argument is in a different scope, it's only needed in the implementation
			-- because the feature is redefined and thus the argument is in the same
			-- scope as the feature).
		local
			l_parent: WIZARD_INTERFACE_DESCRIPTOR
			l_eiffel_names: LIST [STRING]
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_argument: WIZARD_PARAM_DESCRIPTOR
		do
			l_eiffel_names := interface_descriptor.feature_eiffel_names
			from
				l_parent := interface_descriptor.inherited_interface
			until
				l_parent = Void
			loop
				from
					l_parent.functions_start
				until
					l_parent.functions_after
				loop
					if l_parent.functions_item.argument_count > 0 then
						l_arguments := l_parent.functions_item.arguments
						from
							l_arguments.start
						until
							l_arguments.after
						loop
							l_argument := l_arguments.item
							l_argument.set_name (unique_identifier (l_argument.name, agent l_eiffel_names.has))
							l_arguments.forth
						end
					end
					l_parent.functions_forth
				end
				l_parent := l_parent.inherited_interface
			end
		end

	set_source (a_boolean: BOOLEAN)
			-- Set `source' with `a_boolean'.
		do
			source := a_boolean
		ensure
			source_set: source = a_boolean
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR)
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_implemented_interface (Current)
		end

	set_impl_names (is_client: BOOLEAN)
			-- Set implementation names.
		do
			c_type_name := impl_c_type_name (is_client)
			eiffel_class_name := impl_eiffel_class_name (is_client)
			c_declaration_header_file_name := impl_c_declaration_header_file_name (is_client)
			c_definition_header_file_name := impl_c_definition_header_file_name (is_client)
		end

	impl_c_type_name (is_client: BOOLEAN): STRING
			-- Implementation C type name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := impl_name (is_client)
		ensure
			non_void_c_type_name: Result /= Void
			valid_c_type_name: not Result.is_empty
		end

	impl_eiffel_class_name (is_client: BOOLEAN): STRING
			-- Implementation Eiffel class name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := to_eiffel_name (impl_name (is_client))
			Result.to_upper
		ensure
			non_void_class_name: Result /= Void
			valid_class_name: not Result.is_empty
		end

	impl_c_definition_header_file_name (is_client: BOOLEAN): STRING
			-- Implementation header file name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := header_name (namespace, impl_name (is_client))
		ensure
			non_void_header: Result /= Void
			valid_header: not Result.is_empty
		end

	impl_c_declaration_header_file_name (is_client: BOOLEAN): STRING
			-- Implementation header file name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := declaration_header_file_name (impl_c_definition_header_file_name (is_client))
		ensure
			non_void_header: Result /= Void
			valid_header: not Result.is_empty
		end

feature {NONE} -- implementation

	impl_name (is_client: BOOLEAN): STRING
			-- Implementation name.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			Result := name.twin
			if is_client then
				Result.append ("_proxy")
			else
				Result.append ("_stub")
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

invariant
	non_void_interface: interface /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR


