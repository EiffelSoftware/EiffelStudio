indexing
	description: "Component Eiffel generator for server"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

	WIZARD_COMPONENT_CLIENT_GENERATOR
	
	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

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

					if func_generator.function_renamed then
						inherit_clause.add_rename (func_generator.original_name, func_generator.changed_name)
						tmp_original_name := vartype_namer.user_precondition_name (func_generator.original_name)
						tmp_changed_name := vartype_namer.user_precondition_name (func_generator.changed_name)
						inherit_clause.add_rename (tmp_original_name, tmp_changed_name)
					end

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

					if prop_generator.property_renamed then
						from
							prop_generator.changed_names.start
						until
							prop_generator.changed_names.off
						loop
							inherit_clause.add_rename (prop_generator.changed_names.key_for_iteration, prop_generator.changed_names.item_for_iteration)
							prop_generator.changed_names.forth
						end
					end

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

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
