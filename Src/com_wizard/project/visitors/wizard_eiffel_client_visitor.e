indexing
	description: "Eiffel client visitor"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLIENT_VISITOR

inherit
	WIZARD_TYPE_INFO_VISITOR
		redefine
			process_alias,
			process_coclass,
			process_implemented_interface,
			process_interface,
			process_enum,
			process_record
		end

	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

feature -- Processing

	process_alias (a_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
		local
			l_generator: WIZARD_ALIAS_EIFFEL_CLIENT_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

	process_coclass (a_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
			-- generate code for coclass described in `coclass_descriptor'
			-- for every interface in `coclass_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		local
			l_generator: WIZARD_COCLASS_EIFFEL_CLIENT_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

	process_implemented_interface (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR ) is
			-- process implemented interface
			-- generate code for interface described in `implemented_interface_descriptor'
			-- for interface in `implemented_interface_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		local
			l_generator: WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_CLIENT_GENERATOR
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			Precursor (a_descriptor)
			l_interface := a_descriptor.interface_descriptor
			if not l_interface.is_well_known_interface then
				create l_generator
				l_generator.generate (a_descriptor)
			end
		end

	process_interface (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated deffered class for interface
			-- `inteface_descriptor' must provide information on
			-- every functiom of interface
		local
			l_generator: WIZARD_INTERFACE_EIFFEL_CLIENT_GENERATOR
		do
			Precursor (a_descriptor)
			if not a_descriptor.is_well_known_interface then
				create l_generator
				l_generator.generate (a_descriptor)
			end
		end

	process_enum (a_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
			-- generate code for enumeration described by `enum_descriptor'
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		local
			l_generator: WIZARD_ENUM_EIFFEL_CLIENT_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

	process_record (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- process structure
			-- generate code for structure described by `record_descriptor'
			-- for every field in `record_descriptor'
				-- if field type is basic type then
					-- generate Eiffel set/get
					-- generate C macros
				-- if field type is record then
					-- generate set/get for structure item (Eiffel + C)
					-- call `process_record' if it was not processed
				-- if field type is enumeration then
					-- 
				-- if field type is union then
					--
		local
			l_generator: WIZARD_RECORD_EIFFEL_CLIENT_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

feature {NONE}

	language: STRING is
			-- Lanuage currently generated
		once
			Result := Eiffel
		end

	Module_type: STRING is
			-- Module type currently generated
		once
			Result := Client
		end

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
end -- class WIZARD_EIFFEL_CLIENT_VISITOR

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

