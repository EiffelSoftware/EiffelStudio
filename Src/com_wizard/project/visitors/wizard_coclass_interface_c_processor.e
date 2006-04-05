indexing
	description: "Processing interfaces for C coclass."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_C_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_PROCESSOR

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end

	WIZARD_GUID_GENERATOR
		rename
			coclass as dictionary_coclass
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_coclass: WIZARD_COCLASS_DESCRIPTOR; 
				a_coclass_generator: WIZARD_COCLASS_C_GENERATOR) is
			-- Initialize
		require
			non_void_coclass: a_coclass /= Void
			non_void_generator: a_coclass_generator /= Void
		do
			coclass := a_coclass
			coclass_generator := a_coclass_generator
		end

feature -- Access

	coclass_generator: WIZARD_COCLASS_C_GENERATOR
			-- Coclass generator.

	dispatch_interface: BOOLEAN
			-- Does coclass have dispinterface?

feature -- Basic operations

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		deferred
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		deferred
		end

feature {NONE} -- Implementation

	clean_up is
			-- Clean up.
		do
			coclass := Void
			coclass_generator := Void
		end

invariant
	non_void_coclass_generator: not finished implies coclass_generator /= Void

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
end -- class WIZARD_COCLASS_INTERFACE_C_PROCESSOR

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

