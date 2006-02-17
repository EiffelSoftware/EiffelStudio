indexing
	description: "Wizard name mapper"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VARIABLE_NAME_MAPPER

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
			{ANY} client
			{ANY} server
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_FORBIDDEN_NAMES
		export
			{NONE} all
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
			{ANY} is_valid_type_kind
		end

feature -- Access

	Registration_class_creation_routine: STRING is "make"
			-- Registration class creation routine name

	registration_class_name: STRING is
			-- Registration class name
		do
			Result := Ecom_prefix.twin
			Result.append (to_eiffel_name (environment.project_name))
			Result.append (Registration_suffix)
			Result.to_upper
		end

feature -- Basic Operations

	to_legal_name_for_c_function (a_name: STRING) is
			-- Modify `a_name' to make it legal C function name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			a_name.to_lower
			a_name.replace_substring_all ("::", "_")
		end

	namespace_name (a_name: STRING): STRING is
			-- Namespace name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (50)
			if not a_name.is_equal ("stdole") then
				Result.append ("ecom_")
				Result.append (a_name)
			end
		ensure
			non_void_namespace: Result /= Void
		end

	implemented_coclass_name (a_coclass_name: STRING): STRING is
			-- Name of heir of coclass `a_coclass_name'
			-- Implementation class for component server.
		do
			Result := a_coclass_name.twin
			Result.append (Implemented_coclass_extension)
		end

	to_eiffel_name (a_name: STRING): STRING is
			-- Convert `a_name' to Eiffel legitimate name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			i: INTEGER
			previous_upper: BOOLEAN
		do
			create Result.make (100)
			from
				i := 1
				previous_upper := True
			variant 
				a_name.count - i + 1
			until
				i > a_name.count
			loop
				if a_name.item (i).is_upper and not previous_upper then
					Result.append (Underscore)
				end
				Result.extend (a_name.item (i))
				previous_upper := (a_name.item (i).is_upper or (a_name.item (i) = '_'))
				i := i + 1
			end
			if (Result.item (1) = '_') then
				Result.prepend ("x")
			end
			if Result.item (1).is_digit then
				Result.prepend ("x_")
			end

		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	name_for_class (a_name: STRING; a_type: INTEGER; is_client: BOOLEAN): STRING is
			-- Convert to Eiffel class name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			valid_type: is_valid_type_kind (a_type)
		do
			Result := to_eiffel_name (a_name)
			Result.to_upper

			if (a_type = Tkind_enum) then
				Result.append ("_ENUM")
			elseif (a_type = Tkind_record) then
				Result.append ("_RECORD")
				if standard_structures.has (a_name) then
					Result := standard_structures.item (a_name).twin
				end
			elseif 
				(a_type = Tkind_interface) or
				(a_type = Tkind_dispatch)
			then
				Result.append ("_INTERFACE")
--			elseif (a_type = Tkind_dispatch) then
--				Result.append ("_AUTO_INTERFACE")
			elseif (a_type = Tkind_coclass) then
				if is_client then
					Result.append ("_PROXY")
				else
					Result.append ("_COCLASS")
				end
			elseif (a_type = Tkind_alias) then
				Result.append ("_ALIAS")
			elseif (a_type = Tkind_union) then
				Result.append ("_UNION")
			end
		ensure
			non_void_class_name: Result /= Void
			valid_class_name: not Result.is_empty
		end

	name_for_feature (a_name: STRING): STRING is
			-- Convert to Eiffel feature name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			Result := to_eiffel_name (a_name)
			Result.to_lower
		ensure
			non_void_feature_name: Result /= Void
			valid_feature_name: not Result.is_empty
		end

	name_for_feature_with_keyword_check (a_name: STRING): STRING is
			-- Convert to Eiffel feature name and for conflicts with Eiffel keywords.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			Result := name_for_feature (a_name)

			if Eiffel_keywords.has (Result) and not environment.is_eiffel_interface then
				Result.append (One)
			end
		ensure
			non_void_feature_name: Result /= Void
			valid_feature_name: not Result.is_empty
		end

	external_feature_name (a_name: STRING): STRING is
			-- Name of external feature name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (100)
			Result.append ("ccom_")
			Result.append (name_for_feature (a_name))
		ensure
			non_void_feature_name: Result /= Void
			valid_feature_name: not Result.is_empty
		end

	header_name (a_namespace, a_name: STRING): STRING is
			-- Name for header file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_string: STRING
		do
			create Result.make (20)
			if a_namespace /= Void and then not a_namespace.is_empty then
				Result.append (a_namespace)
			end
			Result.append ("_")
			Result.append (a_name)
			if not environment.is_client then
				Result.append ("_s")
			end
			Result.append (".h")

			l_string := Result.as_lower
			if library_headers.has (l_string) then
				if not standard_structures.has (a_name) then
					Result.insert_string ("_x", Result.index_of ('.', 1))
				end
			end
		ensure
			non_void_header_name: Result /= Void
			valid_header_name: not Result.is_empty
		end

	variable_name (a_type_name: STRING): STRING is
			-- Variable naem that will contain instances of `a_type_name'
		require
			non_void_type_name: a_type_name /= Void
		do
			create Result.make (a_type_name.count + 2)
			Result.append ("p_")
			Result.append (a_type_name)
		ensure
			non_void_variable_name: Result /= Void
		end
		
	standard_structures: HASH_TABLE [STRING, STRING] is
			-- Names of standard structures.
			-- Where item is Eiffel name, and key is C name
		once
			create Result.make (10)
			Result.compare_objects

			Result.put ("ECOM_GUID", "GUID")
			Result.put ("INTEGER", "RemotableHandle")
			Result.put ("INTEGER", "_RemotableHandle")

			Result.put ("ECOM_STATSTG", "STATSTG")
			Result.put ("ECOM_EXCEP_INFO", "EXCEPINFO")
			Result.put ("ECOM_DISP_PARAMS", "DISPPARAMS")
		end

feature {NONE} -- Implementation

	library_headers: HASH_TABLE [STRING, STRING] is
			-- Names of header files in EiffelCOM library.
		once
			create result.make (10)
			Result.compare_objects

			Result.put ("ecom_guid.h", "ecom_guid.h")
			Result.put ("ecom_exception.h", "ecom_exception.h")
			Result.put ("ecom_flags.h", "ecom_flags.h")
			Result.put ("ecom_font.h", "ecom_font.h")
			Result.put ("ecom_fontevents.h", "ecom_fontevents.h")
			Result.put ("ecom_ifont.h", "ecom_ifont.h")
			Result.put ("ecom_ipicture.h", "ecom_ipicture.h")
			Result.put ("ecom_picture", "ecom_picture")
			Result.put ("ecom_stdfont.h", "ecom_stdfont.h")
			Result.put ("ecom_stdpicture.h", "ecom_stdpicture.h")
		end

	Ecom_prefix: STRING is "ECOM_"
			-- Prefix for registration class

	Registration_suffix: STRING is "_REGISTRATION"
			-- Registration class suffix

end -- class WIZARD_VARIABLE_NAME_MAPPER

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

