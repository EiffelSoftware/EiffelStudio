indexing
	description: "Export directive."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_EXPORT_DIRECTIVE

create
	make

feature -- Initialization

	make (some_features: LIST [STRING]; a_class: STRING) is
			-- Creation.
		require
			non_void_features: some_features /= Void
			valid_features: not some_features.is_empty
			non_void_class: a_class /= Void
			valid_class: not a_class.is_empty
		do
			features := some_features
			to_class := a_class
		end
		
feature -- Access

	features: LIST [STRING]
	
	to_class: STRING

invariant
	non_void_features: features /= Void
	valid_features: not features.is_empty
	non_void_class: to_class /= Void
	valid_class: not to_class.is_empty

end -- class WIZARD_WRITER_EXPORT_DIRECTIVE

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
