indexing
	description: "Coclass eiffel server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR
		redefine
			generate,
			set_default_ancestors,
			process_interfaces
		end

	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR
		redefine
			set_default_ancestors,
			generate_functions_and_properties
			end

feature -- Basic operation

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			local_string: STRING
		do
			create eiffel_writer.make
			coclass_descriptor := a_descriptor

			-- Set class name and description
			eiffel_writer.set_class_name (implemented_coclass_name (a_descriptor.eiffel_class_name))
			local_string := clone (coclass_descriptor.eiffel_class_name)
			local_string.append (" Implementation.")
			eiffel_writer.set_description (local_string)

			-- Process interfaces.
			process_interfaces

			set_default_ancestors (eiffel_writer)

			-- Generate code
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
		end

	add_creation is
		do
		end

	add_default_features (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
		do
		end

	generate_functions_and_properties (a_desc: WIZARD_INTERFACE_DESCRIPTOR;
				a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS;
				inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Process functions and properties
		local
			prop_generator: WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR
			func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
			tmp_original_name, tmp_changed_name: STRING
		do
			if not a_desc.functions.empty then
				from
					a_desc.functions.start
				until
					a_desc.functions.off
				loop
					-- Generate feature writer
					create func_generator
					func_generator.generate (a_component_descriptor.name, a_desc.functions.item)

					if func_generator.feature_writer.result_type = Void or else 
						func_generator.feature_writer.result_type.empty 
					then
						an_eiffel_writer.add_feature (func_generator.feature_writer, Basic_operations)
					else
						an_eiffel_writer.add_feature (func_generator.feature_writer, Access)
					end
					a_desc.functions.forth
				end
			end
			if not a_desc.properties.empty then
				from
					a_desc.properties.start
				until
					a_desc.properties.off
				loop
					-- Generate feature writer
					create prop_generator
					prop_generator.generate(a_component_descriptor.eiffel_class_name, a_desc.properties.item)
					an_eiffel_writer.add_feature (prop_generator.setting_feature, Element_change)
					an_eiffel_writer.add_feature (prop_generator.access_feature, Access)

					a_desc.properties.forth
				end
			end

			if 
				a_desc.inherited_interface /= Void and not
				a_desc.inherited_interface.guid.is_equal (Iunknown_guid) and then
				not a_desc.inherited_interface.guid.is_equal (Idispatch_guid) 
			then
				generate_functions_and_properties (a_desc.inherited_interface, a_component_descriptor, an_eiffel_writer, inherit_clause)
			end		
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	process_interfaces is
 			-- Process inherited interfaces.
		local
			dummy_object: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create dummy_object.make

			from
				coclass_descriptor.interface_descriptors.start
			until
				coclass_descriptor.interface_descriptors.off
			loop

				if coclass_descriptor.interface_descriptors.item.dispinterface or else
					coclass_descriptor.interface_descriptors.item.dual
				then
					dispatch_interface := True
				end

				generate_functions_and_properties (coclass_descriptor.interface_descriptors.item, 
						coclass_descriptor, eiffel_writer, dummy_object)

				coclass_descriptor.interface_descriptors.forth
			end
		end

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create tmp_writer.make
			tmp_writer.set_name (coclass_descriptor.eiffel_class_name)

			an_eiffel_writer.add_inherit_clause (tmp_writer)
		end

end -- class WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
