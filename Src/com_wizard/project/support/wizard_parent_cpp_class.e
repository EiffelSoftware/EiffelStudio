indexing
	description: "Parent of C++ class"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PARENT_CPP_CLASS

inherit
	WIZARD_WRITER_CPP_EXPORT_STATUS

create
	make

feature -- Initialization

	make (a_name: STRING; a_namespace: STRING; an_export_status: INTEGER) is
			-- Initialize
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			valid_export_status: is_valid_export_status (an_export_status)
		do
			name := clone (a_name)
			namespace := clone (a_namespace)
			export_status := an_export_status
		ensure
			non_void_name: name /= Void
			valid_name: not name.is_empty
			valid_export_status: is_valid_export_status (export_status)
		end

feature -- Access

	name: STRING
			-- Name of parent.

	namespace: STRING 
			-- Namespace of parent

	export_status: INTEGER
			-- Export status.
			-- See WIZARD_WRITER_CPP_EXPORT_STATUS for values.

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty
	valid_export_status: is_valid_export_status (export_status)

end -- class WIZARD_PARENT_CPP_CLASS

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
