note
	description: "Interface eiffel generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INTERFACE_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

feature -- Basic Operations

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR)
			-- Generate eiffel writer
		local
			l_writer: WIZARD_WRITER_INHERIT_CLAUSE
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			create eiffel_writer.make
			eiffel_writer.set_deferred
			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)

			create l_writer.make
			l_interface := a_descriptor.inherited_interface
			if l_interface /= Void and then not l_interface.is_iunknown and then not l_interface.is_idispatch then
				l_writer.set_name (l_interface.eiffel_class_name)
			else
				l_writer.set_name ("ECOM_INTERFACE")
			end
			eiffel_writer.add_inherit_clause (l_writer)

			if a_descriptor.properties /= Void and then not a_descriptor.properties.is_empty then
				process_properties (a_descriptor.properties)
			end

			if not a_descriptor.functions_empty then
				process_functions (a_descriptor)
			end
		end

feature {NONE} -- Implementation

	process_functions (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR)
			-- Process functions
		require
			non_void_descriptor: a_descriptor /= Void
			not_empty_list: not a_descriptor.functions_empty
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			l_func_generator: WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR
			l_writer: WIZARD_WRITER_FEATURE
			l_function: WIZARD_FUNCTION_DESCRIPTOR
		do
			from
				a_descriptor.functions_start
			until
				a_descriptor.functions_after
			loop
				l_function := a_descriptor.functions_item
				if not l_function.is_renaming_clause then
					create l_func_generator.generate (l_function)
					l_writer := l_func_generator.feature_writer
					if l_writer.result_type /= Void and then l_writer.result_type.is_empty and l_writer.arguments.is_empty then
						eiffel_writer.add_feature (l_writer, Access)
					else
						eiffel_writer.add_feature (l_writer, Basic_operations)
					end
				end
				a_descriptor.functions_forth
			end
		end

	process_properties (properties: LIST [WIZARD_PROPERTY_DESCRIPTOR])
			-- Process properties
		require
			non_void_list: properties /= Void
			not_empty_list: not properties.is_empty
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			prop_generator: WIZARD_EIFFEL_DEFERRED_PROPERTY_GENERATOR
		do
			from
				properties.start
			until
				properties.off
			loop
				create prop_generator.generate (properties.item)
				eiffel_writer.add_feature (prop_generator.access_feature, Access)

				if (prop_generator.setting_feature /= Void) then
					eiffel_writer.add_feature (prop_generator.setting_feature, Element_change)
				end

				properties.forth
			end
		end

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
end -- class WIZARD_INTERFACE_EIFFEL_GENERATOR


