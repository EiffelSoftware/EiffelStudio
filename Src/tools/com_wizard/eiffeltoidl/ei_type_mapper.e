indexing
	description: "Map Eiffel type to MIDL type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	WIZARD_SHARED_DATA
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
			in_types.compare_objects

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
			in_types.put ("VARIANT", "ECOM_VARIANT")

			create inout_types.make (10)
			inout_types.compare_objects

			inout_types.put (Com_integer_pointer, Integer_ref_type)
			inout_types.put (Variant_bool_pointer, Boolean_ref_type)
			inout_types.put (Com_float_pointer, Real_ref_type)
			inout_types.put (Com_character_pointer, Character_ref_type)
			inout_types.put (Com_double_pointer, Double_ref_type)

			create cell_types.make (3)
			cell_types.compare_objects
			
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

	supported_eiffel_type (l_type: STRING): BOOLEAN is
			-- Whether Eiffel 'l_type' is supported?
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		do
			if in_types.has (l_type) or inout_types.has (l_type) then
				Result := True
			elseif is_array (l_type) then 
				Result := in_types.has (inner_type (l_type))
			elseif is_cell (l_type) then
				Result := supported_eiffel_type (inner_type (l_type))
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
			supported_type: supported_eiffel_type (l_type)
		local
			l_text: STRING
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
				create l_text.make (l_type.count + 42)
				l_text.append (l_type)
				l_text.append (" cannot be converted into a valid COM type")
				message_output.add_warning (l_text)
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

			Result := Safearray.twin
			Result.append ("(")

			g_type := inner_type (l_type)

			if in_types.has (g_type) then
				Result.append (in_types.item (g_type))
			else
				in_type := False
				inout_type := False
				Result := Void
			end

			if Result /= Void then
				Result.append (") ")
			end
		end

	inner_type (l_type: STRING): STRING is
			-- Inner type of CELL or ECOM_ARRAY
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
			generic_type: is_array (l_type) or is_cell (l_type)
		do
			Result := l_type.substring (l_type.index_of ('%(', 1) + 1, 
										l_type.last_index_of ('%)', l_type.count) -1 )
		end
		
	com_cell_type (l_type: STRING): STRING is
			-- Com pointer type of Eiffel 'l_type'
		require
			non_void_type: l_type /= Void
			valid_type: not l_type.is_empty
		local
			g_type: STRING
		do
			g_type := inner_type (l_type)

			if cell_types.has (g_type) then
				Result := cell_types.item (g_type).twin
				Result.append (" * ")

			elseif inout_types.has (g_type) then
				Result := inout_types.item (g_type).twin
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
end -- class EI_TYPE_MAPPER

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

