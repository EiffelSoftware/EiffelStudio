indexing
	description: "Processing interface for C client component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

