indexing
	description: "Type visitor"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_TYPE_VISITOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

feature -- Operations

	visit (a_descriptor: WIZARD_TYPE_DESCRIPTOR) is
			-- visit `a_descriptor'
		require
			non_void_descriptor: a_descriptor /= Void
		do
			a_descriptor.visit (Current)
		end

feature -- Processing

	process_alias (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
		require
			non_void_descriptor: alias_descriptor /= Void
		deferred
		end

	process_coclass (coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
			-- generate code for coclass described in `coclass_descriptor'
			-- for every interface in `coclass_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		require
			non_void_descriptor: coclass_descriptor /= Void
		deferred
		end

	process_implemented_interface (interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated class for interface
			-- `inteface_descriptor' must provide information on
			-- every function of interface
		require
			non_void_descriptor: interface_descriptor /= Void
		deferred
		end

	process_interface (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated deffered class for interface
			-- `inteface_descriptor' must provide information on
			-- every functiom of interface
		require
			non_void_descriptor: interface_descriptor /= Void
		deferred
		end

	process_enum (enum_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
			-- generate code for enumeration described by `enum_descriptor'
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		require
			non_void_descriptor: enum_descriptor /= Void
		do
			if not enum_descriptor.is_added then
				enum_descriptor.system_descriptor.add_enumerator (enum_descriptor)
				enum_descriptor.set_added
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
		require
			non_void_descriptor: record_descriptor /= Void
		deferred
		end

	process_union (union_descriptor: WIZARD_UNION_DESCRIPTOR) is
			-- process union
			-- generate code for union described by `union_descriptor'
			-- for every field in union 
				-- generate set/get for current type in union (Eiffel + C)
			-- generated code for descriminators
			-- Union is not implemented
		require
			non_void_descrioptor: union_descriptor /= Void
		do
			message_output.add_warning (Current, message_output.Unions_not_supported)
		end

end -- class WIZARD_TYPE_VISITOR

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


