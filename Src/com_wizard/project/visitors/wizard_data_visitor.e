indexing
	description: "Wizard data visitor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_DATA_VISITOR

feature -- Operations

	visit (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- visit `a_descriptor'
		require
			non_void_descriptor: a_descriptor /= Void
		do
			a_descriptor.visit (Current)
		end

feature -- Processing

	process_safearray_data_type (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Process SAFEARRAY
		require
			valid_descriptor: a_safearray_descriptor /= Void
		deferred
		end

	process_automation_data_type (an_automation_descriptor: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR) is
			-- Process Automation Data Type
		require
			valid_descriptor: an_automation_descriptor /= Void
		deferred
		end
		
	process_array_data_type (an_array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Process Array
		require
			valid_descriptor: an_array_descriptor /= Void
		deferred
		end

	process_user_defined_data_type (a_user_defined_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR) is
			-- Process User Defined Data Type
		require
			valid_descriptor: a_user_defined_descriptor /= Void
		deferred
		end

	process_pointed_data_type (a_pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR) is
			-- Process pointed Data Type
		require
			valid_descriptor: a_pointed_descriptor /= Void
		deferred
		end


end -- class WIZARD_DATA_VISITOR

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

