indexing
	description: "Function Descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FUNCTION_DESCRIPTOR

inherit
	WIZARD_FEATURE_DESCRIPTOR
		undefine
			is_equal
		end

	ECOM_FUNC_KIND
		rename
			to_string as func_kind_to_string
		export
			{WIZARD_FUNCTION_DESCRIPTOR_FACTORY} all
		undefine
			is_equal
		end

	ECOM_INVOKE_KIND
		export
			{WIZARD_FUNCTION_DESCRIPTOR_FACTORY} all
		undefine
			is_equal
		end

	ECOM_CALL_CONV
		export
			{WIZARD_FUNCTION_DESCRIPTOR_FACTORY} all
		undefine
			is_equal
		end

	ECOM_FUNC_FLAGS
		export
			{WIZARD_FUNCTION_DESCRIPTOR_FACTORY} all
		undefine
			is_equal
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPARABLE

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_FUNCTION_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			create coclass_eiffel_names.make (5)
			arguments.compare_objects
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_arguments: arguments /= Void and then arguments.count = argument_count
			valid_return_type: return_type /= Void
			non_void_coclass_eiffel_names: coclass_eiffel_names /= Void
		end

feature -- Access

	argument_count: INTEGER
			-- Number of function arguments

	arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			-- Function parameters

	vtbl_offset: INTEGER
			-- Offset in Vtable

	func_kind: INTEGER
			-- Specifies, whether function virtual or dispatch
			-- See ECOM_FUNC_KIND for values.

	dual: BOOLEAN
			-- Can function be accessed through IDispatch and Vtable?
		
	invoke_kind: INTEGER
			-- Invocation kind
			-- See class ECOM_INVOKE_KIND for return values

	call_conv: INTEGER 
			-- Function's calling convention

	return_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Function return type

	to_string: STRING is
			-- String representation used for output
		do
			create Result.make (100)
			Result.append (func_kind_to_string (func_kind))
			Result.append (Space)
			Result.append (name)
			from
				arguments.start
				if not arguments.after then
					Result.append (Space)
					Result.append (Open_parenthesis)
					Result.append (arguments.item.name)
					Result.append (Colon)
					Result.append (Space)
					Result.append (arguments.item.type.name)
					arguments.forth
				end
			until
				arguments.after
			loop
				Result.append (Comma)
				Result.append (Space)
				Result.append (arguments.item.name)
				Result.append (Colon)
				Result.append (Space)
				Result.append (arguments.item.type.name)
				arguments.forth
			end
			if not arguments.is_empty then
				Result.append (Close_parenthesis)
			end
			Result.append (Colon)
			Result.append (return_type.name)
		end

feature -- Status report

	is_equal_function (other: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Is `other' same function?
		require
			non_void_other: other /= Void
		do
			Result := (name.is_equal (other.name) and then
					(argument_count = other.argument_count) and 
					return_type.is_equal_data_type (other.return_type))
			if Result then
				from
					arguments.start
					other.arguments.start
				until
					arguments.after or 
					not Result
				loop
					Result := Result and equal (arguments.item, other.arguments.item)
					arguments.forth
					other.arguments.forth
				end
			end
		ensure
			symmeteric: Result implies other.is_equal_function (Current)
		end

feature {WIZARD_FUNCTION_DESCRIPTOR_FACTORY} -- Basic operations

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			non_void_description: a_description /= Void
		do
			if not a_description.is_empty then
				description := clone (a_description)
			else
				description := No_description_available
			end
		end

	set_member_id (a_member_id: INTEGER) is
			-- Set `member_id' with `a_member_id'.
		do
			member_id := a_member_id
		ensure
			valid_member_id: member_id = a_member_id
		end

	set_vtbl_offset (an_offset: INTEGER) is
			-- Set `vtbl_offset' with `an_offset'
		do
			vtbl_offset := an_offset
		ensure
			valid_offset: vtbl_offset = an_offset
		end

	set_func_kind (a_kind: INTEGER) is
			-- Set `func_kind' with `a_kind'.
		require
			valid_kind: is_valid_func_kind (a_kind)
		do
			func_kind := a_kind
		ensure
			valid_func_kind: is_valid_func_kind (func_kind) and func_kind = a_kind
		end

	set_invoke_kind (a_kind: INTEGER) is
			-- Set `invoke_kind' with `a_kind'.
		require
			valid_kind: is_valid_invoke_kind (a_kind)
		do
			invoke_kind := a_kind
		ensure
			valid_invoke_kind: is_valid_invoke_kind (invoke_kind) and invoke_kind = a_kind
		end

	set_call_conv (a_convention: INTEGER) is
			-- Set `call_conv' with `a_convention'.
		require
			valid_convention: is_valid_callconv (a_convention)
		do
			call_conv := a_convention
		ensure
			valid_call_conv: is_valid_callconv (call_conv) and call_conv = a_convention
		end

feature -- Basic operations

	set_argument_count (an_argument_count: INTEGER) is
			-- Set `argument_count' with `an_argument_count'.
		do
			argument_count := an_argument_count
		ensure
			valid_argument_count: argument_count = an_argument_count
		end

	set_arguments (some_arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]) is
			-- Set `arguments' with `some_arguments'
		require
			valid_arguments: some_arguments /= Void
		do
			arguments := some_arguments
		ensure
			valid_arguments: arguments /= Void and arguments = some_arguments
		end

	set_return_type (a_data_type: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `return_type' with `a_data_type'.
		require
			valid_data_type: a_data_type /= Void
		do
			return_type := a_data_type
		ensure
			valid_return_type: return_type /= Void and return_type = a_data_type
		end

	set_dual (a_boolean: BOOLEAN) is
			-- Set `dual' with `a_boolean'.
		do
			dual := a_boolean
		ensure
			valid_dual: dual = a_boolean
		end
		
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := vtbl_offset < other.vtbl_offset
		end;
			
end -- class WIZARD_FUNCTION_DESCRIPTOR

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

