indexing
	description: "Eiffel enumeration generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_ENUM_EIFFEL_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

feature -- Access

	generate (a_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- Generate eiffel client for enum.
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		local
			writer_feature: WIZARD_WRITER_FEATURE
			enum_element_descriptor: WIZARD_ENUM_ELEMENT_DESCRIPTOR
		do
			create eiffel_writer.make
			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)
			eiffel_writer.set_effective

			from
				a_descriptor.elements.start
			until
				a_descriptor.elements.after
			loop
				enum_element_descriptor := a_descriptor.elements.item
				create writer_feature.make_constant (enum_element_descriptor.value, 
					enum_element_descriptor.name, enum_element_descriptor.description)

				eiffel_writer.add_feature (writer_feature, Access)
				a_descriptor.elements.forth
			end

		end

end -- class WIZARD_ENUM_EIFFEL_GENERATOR

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

