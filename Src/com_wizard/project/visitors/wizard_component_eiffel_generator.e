indexing
	description: "Component Eiffel generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_EIFFEL_GENERATOR

inherit
	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT


feature {NONE} -- Implementation

	dispatch_interface: BOOLEAN
			-- Is coclass has dispinterface?

	add_default_features is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		deferred
		end

	add_creation is
			-- Add creation routines.
		deferred
		end

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors
		require
			non_void_eiffel_writer: an_eiffel_writer /= Void
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do

			create tmp_writer.make
			tmp_writer.set_name (Queriable_type)
			an_eiffel_writer.add_inherit_clause (tmp_writer)

			create tmp_writer.make


			-- Add enumeration
			if not system_descriptor.enumerators.empty then
				from
					system_descriptor.enumerators.start
				until
					system_descriptor.enumerators.off
				loop
					create tmp_writer.make
					tmp_writer.set_name (system_descriptor.enumerators.item.eiffel_class_name)
					an_eiffel_writer.add_inherit_clause (tmp_writer)
					system_descriptor.enumerators.forth
				end
			end
				
		end

end -- class WIZARD_COMPONENT_EIFFEL_GENERATOR

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
