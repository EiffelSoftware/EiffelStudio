indexing
	description: ""
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR

feature -- Basic operations

	generate (coclass_name: STRING; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate server feature signature.
		require
			non_void_coclass_name: coclass_name /= Void
			valid_coclass_name: not coclass_name.empty
			non_void_descriptor: a_descriptor /= Void
		local
			tmp_string: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			func_desc := a_descriptor
			create original_name.make (0)
			create changed_name.make (0)

			create feature_writer.make
			create visitor

			if a_descriptor.coclass_eiffel_names.has (coclass_name) then
				function_renamed := True
				original_name := a_descriptor.interface_eiffel_name
				changed_name := a_descriptor.coclass_eiffel_names.item (coclass_name)
				feature_writer.set_name (changed_name)
			else
				feature_writer.set_name (a_descriptor.interface_eiffel_name)
			end

			
			-- Set arguments and precondition
			set_feature_result_type_and_arguments

			-- Set return type for C server function
			visitor.visit (func_desc.return_type)

			-- Set description, function body
			feature_writer.set_comment (func_desc.description)
			feature_writer.set_body (Exception_body)

			feature_writer.set_effective
		ensure
			feature_generated: feature_writer /= Void
			valid_feature_writer: feature_writer.can_generate
			function_descriptor_set: func_desc /= Void
		end

end -- class WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
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
