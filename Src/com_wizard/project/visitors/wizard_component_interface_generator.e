indexing
	description: "Processing interface for component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_GENERATOR

inherit
	WIZARD_TYPES
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

feature -- Access

	interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	component: WIZARD_COMPONENT_DESCRIPTOR
			-- Component descriptor.

feature -- Basic operations

	generate_functions_and_properties (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate functions and properties.
		require
			non_void_interface: an_interface /= Void
		do
			if 
				an_interface.inherited_interface /= Void and then 
				not an_interface.inherited_interface.c_type_name.is_equal (Iunknown_type) and then
				not an_interface.inherited_interface.c_type_name.is_equal (Idispatch_type) 
			then
				generate_functions_and_properties (an_interface.inherited_interface)
			end		

			if not an_interface.properties.empty then
				from
					an_interface.properties.start
				until
					an_interface.properties.after
				loop
					process_property (an_interface.properties.item)
					an_interface.properties.forth
				end
			end

			if not an_interface.functions_empty then
				from
					an_interface.functions_start
				until
					an_interface.functions_after
				loop
					process_function (an_interface.functions_item)
					an_interface.functions_forth
				end
			end
		end

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		require
			non_void_property: a_property/= Void
		deferred
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		require
			non_void_descriptor: a_function/= Void
		deferred
		end

feature {NONE} -- Implementation

	finished: BOOLEAN
			-- Is processing finished?

	clean_up is
			-- Clean up.
		require
			finished: finished
		deferred
		end

invariant
	non_void_interface: not finished implies interface /= Void
	non_void_component: not finished implies component /= Void

end -- class WIZARD_COMPONENT_INTERFACE_GENERATOR

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
