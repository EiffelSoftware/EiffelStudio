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
			valid_features: not some_features.empty
			non_void_class: a_class /= Void
			valid_class: not a_class.empty
		do
			features := some_features
			to_class := a_class
		end
		
feature -- Access

	features: LIST [STRING]
	
	to_class: STRING

invariant
	non_void_features: features /= Void
	valid_features: not features.empty
	non_void_class: to_class /= Void
	valid_class: not to_class.empty

end -- class WIZARD_WRITER_EXPORT_DIRECTIVE

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
