indexing
	description: "Processing interface for C server component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

create
	make

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			property_generator: WIZARD_CPP_SERVER_PROPERTY_GENERATOR
		do
			create property_generator

			property_generator.generate (component, a_property)
			cpp_class_writer.add_function (property_generator.c_access_feature, Public)

			if a_property.is_read_only then
				cpp_class_writer.add_function (property_generator.c_setting_feature, Public)
			end
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			function_generator: WIZARD_CPP_SERVER_FUNCTION_GENERATOR
		do
			if not a_function.is_renaming_clause then
				if a_function.func_kind = Func_dispatch then
					create {WIZARD_CPP_DISPATCH_SERVER_FUNCTION_GENERATOR} function_generator
				else
					create function_generator
				end
				function_generator.generate (component, a_function)
				cpp_class_writer.add_function (function_generator.ccom_feature_writer, Public)
			end
		end

end -- class WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
