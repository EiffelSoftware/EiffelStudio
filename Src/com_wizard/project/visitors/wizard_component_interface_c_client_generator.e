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
			l_generator: WIZARD_CPP_CLIENT_PROPERTY_GENERATOR
		do
			create l_generator.generate (component, a_property, interface.name, interface.lcid)
			cpp_class_writer.add_function (l_generator.c_access_feature, Public)

			if not a_property.is_read_only then
				cpp_class_writer.add_function (l_generator.c_setting_feature, Public)
			end
		end

	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			l_generator: WIZARD_CPP_VTABLE_CLIENT_FUNCTION_GENERATOR
			l_disp_generator: WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR
			l_header_files: LIST [STRING]
		do
			if not a_function.is_renaming_clause then
				if a_function.func_kind = func_dispatch and not a_function.dual then
					create l_disp_generator
					l_disp_generator.generate (component, interface.name, interface.guid.to_string, interface.lcid, a_function)
					cpp_class_writer.add_function (l_disp_generator.ccom_feature_writer, Public)
				else
					create l_generator
					l_generator.generate (component, interface.name, a_function)
					cpp_class_writer.add_function (l_generator.ccom_feature_writer, Public)
					l_header_files := l_generator.c_header_files
					from
						l_header_files.start
					until
						l_header_files.after
					loop
						if not cpp_class_writer.import_files.has (l_header_files.item) then
							cpp_class_writer.add_import (l_header_files.item)
						end
						l_header_files.forth
					end
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
