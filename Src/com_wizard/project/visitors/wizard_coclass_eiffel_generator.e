indexing
	description: "Coclass eiffel generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_COMPONENT_EIFFEL_GENERATOR

feature -- Access

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			generated_file: PLAIN_TEXT_FILE
		do
			create eiffel_writer.make
			coclass_descriptor := a_descriptor

			-- Set class name and description
			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)

			-- Process interfaces.
			process_interfaces

			set_default_ancestors (eiffel_writer)
			add_creation

		ensure then
			non_void_eiffel_writer: eiffel_writer /= Void
		end

feature {NONE} -- Implementation

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor

	generate_functions_and_properties (descriptor: WIZARD_INTERFACE_DESCRIPTOR;
				a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS;
				inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties
		require
			non_void_descriptor: descriptor /= Void
			non_void_eiffel_writer: eiffel_writer /= Void	
			non_void_component_descriptor: a_component_descriptor /= Void
			non_void_eiffel_writer: an_eiffel_writer /= Void
		deferred
		end

	process_interfaces is
 			-- Process inherited interfaces.
		require
			non_void_list: coclass_descriptor.interface_descriptors /= Void
			not_empty: not coclass_descriptor.interface_descriptors.empty
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
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
				create inherit_clause.make
				inherit_clause.set_name (coclass_descriptor.interface_descriptors.item.eiffel_class_name)

				generate_functions_and_properties (coclass_descriptor.interface_descriptors.item, 
						coclass_descriptor, eiffel_writer, inherit_clause)
				eiffel_writer.add_inherit_clause (inherit_clause)

				coclass_descriptor.interface_descriptors.forth
			end
		ensure
			features_added: eiffel_writer.features /= Void 
		end


end -- class WIZARD_COCLASS_EIFFEL_GENERATOR

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
