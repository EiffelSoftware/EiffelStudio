indexing
	description: "Processing interface for C client component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

create
	make

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			property_generator: WIZARD_CPP_CLIENT_PROPERTY_GENERATOR
		do
			create property_generator.generate (component, a_property, interface.name, interface.lcid)
			cpp_class_writer.add_function (property_generator.c_access_feature, Public)

			if not is_varflag_freadonly (a_property.var_flags) then
				cpp_class_writer.add_function (property_generator.c_setting_feature, Public)
			end
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			function_generator: WIZARD_CPP_VTABLE_CLIENT_FUNCTION_GENERATOR
			disp_func_generator: WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR
		do
			if a_function.func_kind = func_dispatch then
				create disp_func_generator
				disp_func_generator.generate (component, interface.name, interface.guid.to_string, interface.lcid, a_function)
				cpp_class_writer.add_function (disp_func_generator.ccom_feature_writer, Public)

			else
				create function_generator
				function_generator.generate (component, interface.name, a_function)
				cpp_class_writer.add_function (function_generator.ccom_feature_writer, Public)
				from
					function_generator.c_header_files.start
				until
					function_generator.c_header_files.after
				loop
					if not cpp_class_writer.import_files.has (function_generator.c_header_files.item) then
						cpp_class_writer.add_import (function_generator.c_header_files.item)
					end
					function_generator.c_header_files.forth
				end

			end
		end


end -- class WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR

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
