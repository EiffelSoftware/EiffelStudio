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
			name := a_name.twin
			if a_namespace /= Void then
				namespace := a_namespace.twin
			end
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
