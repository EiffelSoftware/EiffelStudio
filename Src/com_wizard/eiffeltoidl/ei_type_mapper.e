indexing
	description: "Map Eiffel type to MIDL type"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_TYPE_MAPPER

inherit
	WIZARD_TYPES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			create in_types.make (10)

			in_types.put (Com_date_type, Date_time)
			in_types.put (Com_float_type, Real_type)
			in_types.put (Double_type, Double_type)
			in_types.put (Variant_bool, Boolean_type)
			in_types.put (Bstr, String_type)
			in_types.put (Com_char_type, Character_type)
			in_types.put (Com_integer_type, Integer_type)
			in_types.put (Com_currency_type, Ecom_currency)
			in_types.put (Com_decimal_type, Ecom_decimal)
			in_types.put (Iunknown, Ecom_unknown_interface)
			in_types.put (IDispatch, Ecom_automation_interface)

			create inout_types.make (10)

			inout_types.put (Com_integer_pointer, Integer_ref_type)
			inout_types.put (Variant_bool_pointer, Boolean_ref_type)
			inout_types.put (Com_float_pointer, Real_ref_type)
			inout_types.put (Com_character_pointer, Character_ref_type)
			inout_types.put (Com_double_pointer, Double_ref_type)

			create cell_types.make (3)
			cell_types.put (Bstr, String_type)
			cell_types.put (Com_date_type, Date_time)
			cell_types.put (Iunknown, Ecom_unknown_interface)
			cell_types.put (IDispatch, Ecom_automation_interface)
			cell_types.put (Com_currency_type, Ecom_currency)
			cell_types.put (Com_decimal_type, Ecom_decimal)

			in_type := False
			inout_type := False
		end

feature -- Access

	in_types: HASH_TABLE [STRING, STRING]
			-- List of [in] types
			-- Eiffel type as key and MIDL type as value.

	inout_types: HASH_TABLE [STRING, STRING]
			-- List of [in] types
			-- Eiffel type as key and MIDL type as value.

	cell_types: HASH_TABLE [STRING, STRING]
			-- List of supported CELL[x] type
			-- Eiffel type as key and MIDL type as value

feature -- Status report

	in_type: BOOLEAN
			-- Is an [in] type?

	inout_type: BOOLEAN
			-- Is an [in, out] type?

	support_eiffel_type (l_type: STRING): BOOLEAN is
			-- Whether Eiffel 'l_type' is supported?
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		do
			if in_types.has (l_type) or inout_types.has (l_type) then
				Result := True
			elseif l_type.substring_index (Ecom_array_type, 1) > 0 or
					 l_type.substring_index (Cell_type, 1) > 0 then
				Result := True
			else 
				Result := False
			end
		end

feature -- Basic operations

	com_type (l_type: STRING): STRING is
			-- Com type mapped to Eiffel 'l_type' type
			-- Void if type not supported
		require
			non_void_type: l_type /= Void
			support_type: support_eiffel_type (l_type)
		local
			tmp_string: STRING
		do
			in_type := False
			inout_type := False

			if in_types.has (l_type) then
				Result := in_types.item (l_type)
				in_type := True
				inout_type := False
			elseif inout_types.has (l_type) then
				Result := inout_types.item (l_type)
				inout_type := True
				in_type := False
			elseif is_array (l_type) then
				Result := com_array_type (l_type)

			elseif is_cell (l_type)  then
				Result := com_cell_type (l_type)
			end

			if Result = Void then
				tmp_string := clone (l_type)
				tmp_string.append (Space)
				tmp_string.append (message_output.Not_e2idl_convertable_type)

				message_output.add_warning (Current, tmp_string)
			end
		end

feature {NONE} -- Implementation

	is_cell (l_type: STRING): BOOLEAN is
			-- Is CELL?
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		do
			Result := l_type.substring (1, 4).is_equal (Cell_type) 
		end

	is_array (l_type: STRING): BOOLEAN is
			-- Is array?
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		do
			Result := l_type.substring (1, 10).is_equal (Ecom_array_type)
		end

	com_array_type (l_type: STRING): STRING is
			-- Com Safearray type equavalent of Eiffel 'l_type'
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		local
			g_type: STRING
		do
			in_type := True
			inout_type := False

			Result := clone (Safearray)
			Result.append ("(")

			g_type := l_type.substring (l_type.index_of ('%(', 1) + 1, l_type.index_of ('%)', 1) -1 )

			if in_types.has (g_type) then
				Result.append (in_types.item (g_type))
			else
				in_type := False
				inout_type := False
				Result := Void
			end

			if Result /= Void then
				Result.append (") *")
			end
		end

	com_cell_type (l_type: STRING): STRING is
			-- Com pointer type of Eiffel 'l_type'
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		local
			g_type: STRING
		do
			g_type := l_type.substring (l_type.index_of ('%(', 1) + 1, l_type.index_of ('%)', 1) -1 )

			if cell_types.has (g_type) then
				Result := clone (cell_types.item (g_type))
				Result.append (" * ")

			elseif inout_types.has (g_type) then
				Result := clone (inout_types.item (g_type))
				Result.append (" * ")

			elseif is_cell (g_type) then
				Result := com_cell_type (g_type)
				Result.append (" * ")

			elseif is_array (g_type) then
				Result := com_array_type (g_type)
				Result.append (" * ")

			else
				Result := Void
				in_type := False
				inout_type := False
			end

			in_type := False
			inout_type := True
		end

end -- class EI_TYPE_MAPPER
