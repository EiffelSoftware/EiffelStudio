indexing
	description: "Eiffel server visitor"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_SERVER_VISITOR

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

feature -- Processing
	process_alias (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
		do
			Precursor (alias_descriptor)
			alias_server_generator.initialize
			alias_server_generator.generate (alias_descriptor)
		end

	process_coclass (coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
			-- generate code for coclass described in `coclass_descriptor'
			-- for every interface in `coclass_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		do
			Precursor (coclass_descriptor)
			if shared_wizard_environment.new_eiffel_project then
				coclass_impl_generator.generate (coclass_descriptor)
			else
				coclass_server_generator.initialize
				coclass_server_generator.generate (coclass_descriptor)
			end
		end

	process_implemented_interface (interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated class for interface
			-- `inteface_descriptor' must provide information on
			-- every function of interface
		do
			Precursor (interface_descriptor)
			implemented_interface_generator.initialize
			implemented_interface_generator.generate (interface_descriptor)
		end

	process_interface (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated deffered class for interface
			-- `inteface_descriptor' must provide information on
			-- every functiom of interface
		do
			if not shared_wizard_environment.new_eiffel_project then
				Precursor (interface_descriptor)
				interface_server_generator.initialize
				interface_server_generator.generate (interface_descriptor)
			end
		end

	process_enum (enum_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
			-- generate code for enumeration described by `enum_descriptor'
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		do
			Precursor (enum_descriptor)
			enum_server_generator.initialize
			enum_server_generator.generate (enum_descriptor)
		end

	process_record (record_descriptor: WIZARD_RECORD_DESCRIPTOR) is
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
		do
			Precursor (record_descriptor)
			record_server_generator.initialize
			record_server_generator.generate (record_descriptor)
		end

feature {NONE}

	alias_server_generator: WIZARD_ALIAS_EIFFEL_SERVER_GENERATOR is
			-- Alias eiffel server generator
		once
			create Result
		end

	coclass_server_generator: WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR is
			-- Coclass eiffel server generator
		once
			create Result
		end

	implemented_interface_generator: WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_SERVER_GENERATOR is
			-- Implemented interface Eiffel server  generator.
		once
			create Result
		end

	enum_server_generator: WIZARD_ENUM_EIFFEL_SERVER_GENERATOR is
			-- Enum eiffel server generator
		once
			create Result
		end			

	interface_server_generator: WIZARD_INTERFACE_EIFFEL_SERVER_GENERATOR is
			-- Interface eiffel server generator
		once
			create Result
		end

	coclass_impl_generator: WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR is
			-- Coclass implementation generator
		once
			create Result
		end

	record_server_generator: WIZARD_RECORD_EIFFEL_SERVER_GENERATOR is
			-- Record eiffel server generator
		once
			create Result
		end

	language: STRING is
			-- Lanuage currently generated
		once
			Result := Eiffel
		end

	Module_type: STRING is
			-- Module type currently generated
		once
			Result := Server
		end

end -- class WIZARD_EIFFEL_SERVER_VISITOR

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

