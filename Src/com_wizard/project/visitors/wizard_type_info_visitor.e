indexing
	description: "Type Info visitor"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_TYPE_INFO_VISITOR

inherit
	WIZARD_TYPE_VISITOR
		redefine
			process_enum
		end

feature -- Processing

	process_alias (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
		do
			output_information (alias_descriptor)
		end

	process_coclass (coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
			-- generate code for coclass described in `coclass_descriptor'
			-- for every interface in `coclass_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		do
			output_information (coclass_descriptor)
		end

	process_implemented_interface (interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated class for interface
			-- `inteface_descriptor' must provide information on
			-- every function of interface
		do
			output_information (interface_descriptor)
		end

	process_interface (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated deffered class for interface
			-- `inteface_descriptor' must provide information on
			-- every function of interface
		do
			output_information (interface_descriptor)
		end

	process_enum (enum_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
			-- generate code for enumeration described by `enum_descriptor'
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		do
			Precursor {WIZARD_TYPE_VISITOR} (enum_descriptor)
			output_information (enum_descriptor)
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
			output_information (record_descriptor)
		end

feature {NONE} -- Implementation

	output_information (a_wizard_descriptor: WIZARD_DESCRIPTOR) is
			-- Wizard output
		local
			a_message: STRING
		do
			a_message := clone (Processing)
			a_message.append (Space)
			a_message.append (a_wizard_descriptor.name)
			a_message.append (Space)
			a_message.append (For)
			a_message.append (Space)
			a_message.append (language)
			a_message.append (Space)
			a_message.append (module_type)
			add_message (Current, a_message)
		end

	language: STRING is
			-- Language currently generated (C or Eiffel)
		deferred
		end

	module_type: STRING is
			-- Module currently generated (Client or Server)
		deferred
		end

invariant
	valid_language: language.is_equal (Eiffel) or language.is_equal (C)
	valid_module_type: module_type.is_equal (Client) or module_type.is_equal (Server)

end -- WIZARD_TYPE_INFO_VISITOR

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


