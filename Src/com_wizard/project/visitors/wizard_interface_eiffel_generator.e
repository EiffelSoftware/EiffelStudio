indexing
	description: "Interface eiffel generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INTERFACE_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

feature -- Access

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate eiffel writer
		local
			inherit_clause_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do	
			create eiffel_writer.make
			eiffel_writer.set_deferred
			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)

			create inherit_clause_writer.make
			if a_descriptor.inherited_interface /= Void and then 
					not a_descriptor.inherited_interface.name.is_equal(Iunknown_type) and then
					not a_descriptor.inherited_interface.name.is_equal (Idispatch_type) then
				inherit_clause_writer.set_name (a_descriptor.inherited_interface.eiffel_class_name)
				eiffel_writer.add_inherit_clause (inherit_clause_writer)
			end

			if a_descriptor.properties /= Void and then not a_descriptor.properties.empty then
				process_properties (a_descriptor.properties)
			end

			if a_descriptor.functions /= Void and then not a_descriptor.functions.empty then
				process_functions (a_descriptor.functions)
			end
		ensure then
			non_void_eiffel_writer: eiffel_writer /= Void
		end

feature {NONE} -- Implementation

	process_functions (functions:LINKED_LIST[WIZARD_FUNCTION_DESCRIPTOR]) is
			-- Process functions
		require
			non_void_list: functions /= Void
			not_empty_list: not functions.empty
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			func_generator: WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR
		do
			from
				functions.start
			until
				functions.off
			loop
				create func_generator

				func_generator.generate (functions.item)
				if func_generator.feature_writer.result_type /= Void and then func_generator.feature_writer.result_type.empty 
						and func_generator.feature_writer.arguments.empty then
					eiffel_writer.add_feature (func_generator.feature_writer, Access)
				else
					eiffel_writer.add_feature (func_generator.feature_writer, Basic_operations)
				end
				eiffel_writer.add_feature (func_generator.precondition_feature_writer, Status_report)
				functions.forth
			end
		end

	process_properties (properties:LINKED_LIST[WIZARD_PROPERTY_DESCRIPTOR]) is
			-- Process properties
		require
			non_void_list: properties /= Void
			not_empty_list: not properties.empty
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			prop_generator: WIZARD_EIFFEL_DEFERRED_PROPERTY_GENERATOR
		do
			from
				properties.start
			until
				properties.off
			loop
				create prop_generator

				prop_generator.generate (properties.item)
				eiffel_writer.add_feature (prop_generator.access_feature, Access)
				eiffel_writer.add_feature (prop_generator.precondition_access_feature_writer, Status_report)

				if (prop_generator.setting_feature /= Void) then
					eiffel_writer.add_feature (prop_generator.setting_feature, Element_change)
					eiffel_writer.add_feature (prop_generator.precondition_set_feature_writer, Status_report)
				end

				properties.forth
			end
		end

end -- class WIZARD_INTERFACE_EIFFEL_GENERATOR

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

