indexing
	description: "GUID related strings."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_GUID_GENERATOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

feature -- Basic operations

	iid_name (a_name: STRING): STRING is
			-- Name of IID constant.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (100)
			Result.append ("IID_")
			Result.append (a_name)
			if 
				not a_name.is_equal ("IDispatch") and
				not a_name.is_equal ("IUnknown") and
				not a_name.is_equal ("IConnectionPointContainer") and
				not a_name.is_equal ("IConnectionPoint")  and
				not a_name.is_equal ("IProvideClassInfo") and
				not a_name.is_equal ("IProvideClassInfo2")
			then
				Result.append ("_")
			end
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.is_empty
		end

	iid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of IID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_guid: a_guid /= Void
		do
			create Result.make (1000)
			if 
				not a_name.is_equal ("IDispatch") and
				not a_name.is_equal ("IUnknown") and
				not a_name.is_equal ("IConnectionPointContainer") and
				not a_name.is_equal ("IConnectionPoint")  and
				not a_name.is_equal ("IProvideClassInfo") and
				not a_name.is_equal ("IProvideClassInfo2")
			then
				Result.append ("static const IID ")
				Result.append (iid_name (a_name))
				Result.append (" = ")
				Result.append (a_guid.to_definition_string)
				Result.append_character (';')
			end
		ensure
			non_void_definition: Result /= Void
		end

	libid_name (name: STRING): STRING is
			-- Name of library id
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			create Result.make (100)
			Result.append ("LIBID_")
			Result.append (name)
			Result.append ("_")
		end

	libid_definition (name: STRING; guid: ECOM_GUID): STRING is
			-- Definition of CLSID in source file.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
			non_void_guid: guid /= Void
		do
			create Result.make (1000)
			Result.append ("static ")
			Result.append (Const)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append (Space)
			Result.append (libid_name (name))
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (guid.to_definition_string)
			Result.append (Semicolon)
		ensure
			non_void_definition: Result /= Void
			valid_definition: not Result.is_empty
		end

	libid_declaration (name: STRING): STRING is
			-- Declaration of LIBID in header file
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			-- extern "C" IID LIBID_'name'

			create Result.make (200)
			Result.append (Extern)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append ("C")
			Result.append (Double_quote)
			Result.append (Space)
			Result.append (Const)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append (Space)
			Result.append (libid_name (name))
			Result.append (Semicolon)
		end


	clsid_name (a_name: STRING): STRING is
			-- Name of CLSID constant.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (1000)
			Result.append (Clsid_type)
			Result.append ("_")
			Result.append (a_name)
			Result.append ("_")
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.is_empty
		end

	clsid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of CLSID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_guid: a_guid /= Void
		do
			create Result.make (1000)
			Result.append ("static ")
			Result.append (Const)
			Result.append (Space)
			Result.append (Clsid_type)
			Result.append (Space)
			Result.append (clsid_name (a_name))
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (a_guid.to_definition_string)
			Result.append (Semicolon)
		ensure
			non_void_definition: Result /= Void
			valid_definition: not Result.is_empty
		end

	clsid_declaration (a_name: STRING): STRING is
			-- Declaration of CLSID in header file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			-- extern "C" CLSID CLSID_`a_name';

			create Result.make (1000)
			Result.append (Extern)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append ("C")
			Result.append (Double_quote)
			Result.append (Space)
			Result.append (Const)
			Result.append (Space)
			Result.append (Clsid_type)
			Result.append (Space)
			Result.append (clsid_name (a_name))
			Result.append (Semicolon)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.is_empty
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
end -- class WIZARD_GUID_GENERATOR

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

