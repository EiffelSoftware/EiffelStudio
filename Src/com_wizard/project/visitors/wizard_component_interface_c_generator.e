indexing
	description: "Processing interface for C component."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_GENERATOR
		redefine
			default_create
		end

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize instance.
		do
			create generated_coclasses.make (10)
		end
		
feature -- Initialization

	initialize (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_interface: WIZARD_INTERFACE_DESCRIPTOR; a_writer: WIZARD_WRITER_CPP_CLASS) is
			-- Initialize
		require
			non_void_component: a_component /= Void
			non_void_interface: a_interface /= Void
			non_void_writer: a_writer /= Void
		do
			component := a_component
			interface := a_interface
			cpp_class_writer := a_writer
			finished := False
		end

feature -- Access

	cpp_class_writer: WIZARD_WRITER_CPP_CLASS
			-- C++ class writer.

feature {NONE} -- Implementation

	clean_up is
			-- Clean up.
		do
			component := Void
			interface := Void
			cpp_class_writer := Void
		end

invariant
	non_void_writer: not finished implies cpp_class_writer /= Void

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
end -- class WIZARD_COMPONENT_INTERFACE_C_GENERATOR

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

