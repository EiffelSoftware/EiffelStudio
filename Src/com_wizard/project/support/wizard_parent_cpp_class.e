indexing
	description: "Parent of C++ class"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
