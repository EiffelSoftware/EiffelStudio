indexing
	description: "Processing interfaces for Eiffel coclass."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 

inherit
	WIZARD_COCLASS_INTERFACE_PROCESSOR

feature {NONE} -- Initialization

	make (a_coclass: WIZARD_COCLASS_DESCRIPTOR; an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Initialize
		require
			non_void_coclass: a_coclass /= Void
			non_void_writer: an_eiffel_writer /= Void
		do
			coclass := a_coclass
			eiffel_writer := an_eiffel_writer
		end

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
			-- Eiffel class writer.

	dispatch_interface: BOOLEAN
			-- Does coclass have dispinterface?

feature -- Basic operations

	generate_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			l_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			if a_interface.is_implementing_coclass (coclass) then
				dispatch_interface := a_interface.dispinterface and not a_interface.dual
				create l_clause.make
				l_clause.set_name (a_interface.eiffel_class_name)
				generate_functions_and_properties (a_interface, l_clause)
				eiffel_writer.add_inherit_clause (l_clause)
			end
		end

feature {NONE} -- Implementation

	generate_functions_and_properties (an_interface: WIZARD_INTERFACE_DESCRIPTOR;
				an_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties for interface.
		require
			non_void_interface: an_interface /= Void
			non_void_inherit_clause: an_inherit_clause /= Void
		deferred
		end

	clean_up is
			-- Clean up.
		do
			coclass := Void
			eiffel_writer := Void
		end

invariant
	non_void_writer: not finished implies eiffel_writer /= Void

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
end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR

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

