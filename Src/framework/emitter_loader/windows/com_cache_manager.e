note
	description: "[
		Eiffel interface class for EiffelSoftware.MetadataConsumer.exe or EiffelSoftware.MetadataConsumer.dll assemblies
		Encapsulates the COM_CACHE_MANAGER class
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_CACHE_MANAGER

inherit
	COM_OBJECT
		rename
			is_successful as is_com_successful
		export
			{ANY} last_call_success
		end

create
	make_by_pointer

feature -- Initialization

	initialize
			-- Initialize current.
		do
			last_call_success := c_initialize (item)
			is_initialized := last_call_success = 0
		ensure
			success: last_call_success = 0
		end

	initialize_with_path (a_path: UNI_STRING)
			-- Initialize current with `a_path' as ISE_EIFFEL var.
		require
			a_path_not_void: a_path /= Void
		local
			l_path: BSTR_STRING
		do
			create l_path.make_by_uni_string (a_path)
			last_call_success := c_initialize_with_path (item, l_path.item)
			is_initialized := last_call_success = 0
		ensure
			success: last_call_success = 0
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Has Current been correctly initiliazed?

	is_successful: BOOLEAN
			-- Was last operation successful?
		require
			initialized: is_initialized
		local
			res: INTEGER
		do
			last_call_success := c_is_successful (item, $res)
			Result := res /= 0
		ensure
			success: last_call_success = 0
		end

	last_error_message: detachable UNI_STRING
			-- Last error message of a failed operation
		require
			initialized: is_initialized
		local
			res: POINTER
		do
			last_call_success := c_last_error_message (item, $res)
			if res /= default_pointer then
				create Result.make_by_pointer (res)
			end
		ensure
			success: last_call_success = 0
		end

feature -- Basic Oprtations

	consume_assembly (a_name, a_version, a_culture, a_key: UNI_STRING; a_info_only: BOOLEAN)
			-- Consume an assembly into the EAC from at least `a_name'
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			bstr_name: BSTR_STRING
			bstr_version: BSTR_STRING
			bstr_culture: BSTR_STRING
			bstr_key: BSTR_STRING
		do
			create bstr_name.make_by_uni_string (a_name)
			if a_version /= Void then
				create bstr_version.make_by_uni_string (a_version)
			else
				create bstr_version.make_by_pointer (default_pointer)
			end
			if a_culture /= Void then
				create bstr_culture.make_by_uni_string (a_culture)
			else
				create bstr_culture.make_by_pointer (default_pointer)
			end
			if a_key /= Void then
				create bstr_key.make_by_uni_string (a_key)
			else
				create bstr_key.make_by_pointer (default_pointer)
			end

			last_call_success := c_consume_assembly (item, bstr_name.item, bstr_version.item, bstr_culture.item, bstr_key.item, a_info_only)
		ensure
			success: last_call_success = 0
		end

	consume_assembly_from_path (a_assembly_paths: UNI_STRING; a_info_only: BOOLEAN; a_references: detachable UNI_STRING)
			-- consume assembly found at 'a_assembly_paths' and all of its dependacies into EAC.
			-- GAC dependacies will be put into the EAC
		require
			initialized: is_initialized
			non_void_path: a_assembly_paths /= Void
			valid_path: not a_assembly_paths.is_empty
		local
			bstr_path: BSTR_STRING
			bstr_refs: BSTR_STRING
		do
			create bstr_path.make_by_uni_string (a_assembly_paths)
			if a_references /= Void then
				create bstr_refs.make_by_uni_string (a_references)
				last_call_success := c_consume_assembly_from_path (item, bstr_path.item, a_info_only, bstr_refs.item)
			else
				last_call_success := c_consume_assembly_from_path (item, bstr_path.item, a_info_only, default_pointer)
			end
		end

	unload
			-- unloads initialized app domain and cache releated objects to preserve resources
		do
			last_call_success := c_unload (item)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	c_initialize (ap: POINTER): INTEGER
			-- initialize COM object
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature ():EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"initialize"
		end

	c_initialize_with_path (ap:POINTER; ap2: POINTER): INTEGER
			-- initialize COM object with alternative ISE_EIFFEL path ?
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature (BSTR):EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"initialize_with_path"
		end

	c_is_initalized (ap:POINTER; aret_val: POINTER): INTEGER
			-- was the last operation successful?
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature (VARIANT_BOOL*):EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"is_initialized"
		end

	c_is_successful (ap:POINTER; aret_val: POINTER): INTEGER
			-- was the last operation successful?
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature (VARIANT_BOOL*):EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"is_successful"
		end

	c_last_error_message (ap:POINTER; aret_val: POINTER): INTEGER
			-- last error message of a failed operation
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature (LPWSTR*):EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"last_error_message"
		end

	c_consume_assembly (ap, a_name, a_version, a_culture, a_key: POINTER; a_info_only: BOOLEAN): INTEGER
			-- Consume an assembly into the EAC from at least `a_name'
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature (BSTR, BSTR, BSTR, BSTR, VARIANT_BOOL): EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"consume_assembly"
		end

	c_consume_assembly_from_path (ap, a_assembly_paths: POINTER; a_info_only: BOOLEAN; a_references: POINTER): INTEGER
			-- Consume referenced assembly `a_assembly_path' an all of its dependacies into EAC
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature (BSTR, VARIANT_BOOL, BSTR): EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"consume_assembly_from_path"
		end

	c_unload (ap: POINTER): INTEGER
			-- -- retrieve the assembly information from a assembly
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER signature ():EIF_INTEGER use <ole2.h>, %"metadata_consumer.h%""
		alias
			"unload"
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class COM_CACHE_MANAGER
