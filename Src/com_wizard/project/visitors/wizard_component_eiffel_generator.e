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
		export
			{NONE} all
		end


feature {NONE} -- Implementation

	dispatch_interface: BOOLEAN
			-- Is coclass has dispinterface?

	add_default_features (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		require
			non_void_descriptor: a_component_descriptor /= Void
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
