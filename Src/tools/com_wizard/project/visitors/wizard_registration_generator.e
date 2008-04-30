indexing
	description: "Registration code generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_REGISTRATION_GENERATOR

inherit
	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES
		export
			{NONE} all
		end

	ANY

feature -- Access

	generate is
			-- Generated Eiffel registration code.
		deferred
		end

	ccom_dll_register_server: STRING is "ccom_dll_register_server"
			-- Used for code generation.

	ccom_dll_unregister_server: STRING is "ccom_dll_unregister_server"
			-- Used for code generation.

	ccom_dll_get_class_object: STRING is "ccom_dll_get_class_object"
			-- Used for code generation.

	ccom_dll_can_unload_now: STRING is "ccom_dll_can_unload_now"
			-- Used for code generation.

	Ccom_initialize_com: STRING is "ccom_initialize_com"
			-- Used for code generation.

	Ccom_cleanup_com: STRING is "ccom_cleanup_com"
			-- Used for code generation.

	Ccom_register_server: STRING is "ccom_register_server"
			-- Used for code generation.

	Ccom_unregister_server: STRING is "ccom_unregister_server"
			-- Used for code generation.

feature -- Basic operations

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		deferred
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
end -- class WIZARD_REGISTRATION_GENERATOR


