indexing
	description: "C client visitor"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_C_CLIENT_VISITOR

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

	WIZARD_SHARED_DATA

	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

feature -- Processing

	process_alias (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
		do
			if not shared_wizard_environment.server then
				Precursor (alias_descriptor)
				alias_client_generator.initialize
				alias_client_generator.generate (alias_descriptor)
			end
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
			coclass_client_generator.initialize
			coclass_client_generator.generate (coclass_descriptor)
		end

	process_implemented_interface (implemented_interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR ) is
			-- process implemented interface
			-- generate code for interface described in `implemented_interface_descriptor'
			-- for interface in `implemented_interface_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		do
			Precursor (implemented_interface_descriptor)
			implemented_interface_generator.initialize
			implemented_interface_generator.generate (implemented_interface_descriptor)
		end

	process_interface (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated deffered class for interface
			-- `inteface_descriptor' must provide information on
			-- every functiom of interface
		do
			if not shared_wizard_environment.server then
				Precursor (interface_descriptor)
				interface_client_generator.initialize
				interface_client_generator.generate (interface_descriptor)
			end
		end

	process_enum (enum_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
			-- generate code for enumeration described by `enum_descriptor'
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		do
			if not shared_wizard_environment.server then
				Precursor (enum_descriptor)
			end
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
			if not shared_wizard_environment.server then
				Precursor (record_descriptor)
				record_client_generator.initialize
				record_client_generator.generate (record_descriptor)
			end
		end

feature {NONE} -- Implementation

	alias_client_generator: WIZARD_ALIAS_C_CLIENT_GENERATOR is
			-- Alias eiffel client generator.
		once
			create Result
		end

	coclass_client_generator: WIZARD_COCLASS_C_CLIENT_GENERATOR is
			-- Coclass eiffel client generator.
		once
			create Result
		end

	implemented_interface_generator: WIZARD_IMPLEMENTED_INTERFACE_C_CLIENT_GENERATOR is
			-- Implemented interface eiffel client generator.
		once
			create Result
		end

	interface_client_generator: WIZARD_INTERFACE_C_CLIENT_GENERATOR is
			-- Interface eiffel client generator.
		once
			create Result
		end

	record_client_generator: WIZARD_RECORD_C_CLIENT_GENERATOR is
			-- Record eiffel client generator.
		once
			create Result
		end

	language: STRING is
			-- Lanuage currently generated.
		once
			Result := C
		end

	Module_type: STRING is
			-- Module type currently generated.
		once
			Result := Client
		end

end -- class WIZARD_C_CLIENT_VISITOR

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


