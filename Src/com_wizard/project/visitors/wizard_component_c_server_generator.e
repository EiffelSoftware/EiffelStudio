indexing
	description: "Component C server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_C_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_C_GENERATOR

	ECOM_FUNC_KIND

feature -- Access

	dispatch_interface_name: STRING
			-- Name for a dispatch interface.

feature -- Basic operations

	generate_functions_and_properties (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR;
					a_desc: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate functions and properties of 'a_desc'
		local
			function_generator: WIZARD_CPP_SERVER_FUNCTION_GENERATOR
			property_generator: WIZARD_CPP_SERVER_PROPERTY_GENERATOR
		do
			if not a_desc.properties.empty then
				from
					a_desc.properties.start
				until
					a_desc.properties.off
				loop
					create property_generator

					property_generator.generate (a_component_descriptor.name, a_desc.properties.item)
					cpp_class_writer.add_function (property_generator.c_access_feature, Public)
					cpp_class_writer.add_function (property_generator.c_setting_feature, Public)

					a_desc.properties.forth
				end
			end

			if not a_desc.functions.empty then
				from
					a_desc.functions.start
				until
					a_desc.functions.off
				loop
					if a_desc.functions.item.func_kind = Func_dispatch then
						create {WIZARD_CPP_DISPATCH_SERVER_FUNCTION_GENERATOR} function_generator
					else
						create function_generator
					end
					function_generator.generate (a_component_descriptor.name, a_desc.functions.item)
					cpp_class_writer.add_function (function_generator.ccom_feature_writer, Public)

					a_desc.functions.forth
				end
			end

			if a_desc.inherited_interface /= Void and not
					a_desc.inherited_interface.c_type_name.is_equal (Iunknown_type) and then
					not a_desc.inherited_interface.c_type_name.is_equal (Idispatch_type) then
				generate_functions_and_properties (a_component_descriptor, a_desc.inherited_interface)
			end		
		end

end -- class WIZARD_COMPONENT_C_SERVER_GENERATOR

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
