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
		deferred
		end

end -- class WIZARD_COMPONENT_EIFFEL_GENERATOR

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

