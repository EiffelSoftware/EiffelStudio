indexing
	description: "Task used for creating wizard descriptors from type library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date"
	revision: "$revision"

class
	WIZARD_TYPE_LIBRARY_ANALYSIS_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

feature -- Access

	title: STRING is "Analyzing type library"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task	
		local
			l_file_name: STRING
			l_type_lib: ECOM_TYPE_LIB
		do
			create library_guids.make (10)
			library_guids.compare_objects
			l_file_name := environment.type_library_file_name
			if l_file_name /= Void and then (create {RAW_FILE}.make (l_file_name)).exists then
				create l_type_lib.make_from_name (environment.type_library_file_name)
				Result := type_library_analysis_steps_count (l_type_lib)
				l_type_lib.release
				Result := Result + 5 -- 5 steps in `{WIZARD_SYSTEM_DESCRIPTOR}.generate'
			else
				environment.set_abort (No_type_library)
				if l_file_name /= Void then
					environment.set_error_data (l_file_name)
				end
			end
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		do
			set_system_descriptor (create {WIZARD_SYSTEM_DESCRIPTOR}.make)
			message_output.add_title ("Analyzing type library")
			system_descriptor.generate (environment.type_library_file_name)
		end

	type_library_analysis_steps_count (a_type_library: ECOM_TYPE_LIB): INTEGER is
			-- Number of steps needed to analyze `a_type_desc' in `a_type_info'.
		local
			i, l_count: INTEGER
		do
			library_guids.extend (a_type_library.library_attributes.guid)
			l_count := a_type_library.type_info_count
			Result := l_count
			from
				i := 0
			until
				i = l_count or environment.abort
			loop
				Result := Result + type_info_analysis_steps_count (a_type_library.type_info (i))
				i := i + 1
			end
		end

	type_info_analysis_steps_count (a_type_info: ECOM_TYPE_INFO): INTEGER is
			-- Number of steps needed to analyze `a_type_info'
		local
			l_type, i, l_count: INTEGER
			l_handle: NATURAL_32
		do
			l_type := a_type_info.type_attr.type_kind
			if l_type = Tkind_record then
				l_count := a_type_info.type_attr.count_variables
				from
				until
					i = l_count
				loop
					Result := Result + data_type_analysis_steps_count (a_type_info, a_type_info.var_desc (i).elem_desc.type_desc)
					i := i + 1
				end
			elseif l_type = Tkind_interface or l_type = Tkind_dispatch then
				if a_type_info.type_attr.count_implemented_types > 0 then
					Result := referred_type_analysis_steps_count (a_type_info, a_type_info.ref_type_of_impl_type (0))
				end
			elseif l_type = Tkind_coclass then
				l_count := a_type_info.type_attr.count_implemented_types
				from
					i := 0
				until
					i = l_count
				loop
					l_handle := a_type_info.ref_type_of_impl_type (i)
					Result := Result + referred_type_analysis_steps_count (a_type_info, l_handle)
					Result := Result + type_info_analysis_steps_count (a_type_info.type_info (l_handle))
					i := i + 1
				end
			elseif l_type = Tkind_alias then
				Result := data_type_analysis_steps_count (a_type_info, a_type_info.type_attr.type_alias)
			elseif l_type = Tkind_union then
				from
					i := 0
					l_count := a_type_info.type_attr.count_variables
				until
					i = l_count
				loop
					Result := data_type_analysis_steps_count (a_type_info, a_type_info.var_desc (i).elem_desc.type_desc)
					i := i + 1
				end
			end
		end

	data_type_analysis_steps_count (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC) : INTEGER is
			-- Number of steps needed to analyze `a_type_desc' in `a_type_info'.
		local
			l_var_type: INTEGER
		do
			l_var_type := a_type_desc.var_type
			if is_user_defined (l_var_type) then
				Result := referred_type_analysis_steps_count (a_type_info, a_type_desc.href_type)
			elseif is_carray (l_var_type) then
				Result := data_type_analysis_steps_count (a_type_info, a_type_desc.array_desc.type_desc)
			elseif is_ptr (l_var_type) or is_safearray (l_var_type) then
				Result := data_type_analysis_steps_count (a_type_info, a_type_desc.type_desc)
			end
		end

	referred_type_analysis_steps_count (a_type_info: ECOM_TYPE_INFO; a_handle: NATURAL_32): INTEGER is
			-- Number of steps needed to analyze type referred to by `a_handle' in `a_type_info'
		require
			non_void_void_type_info: a_type_info /= Void
			valid_handle: a_type_info.type_info (a_handle) /= Void
		local
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
		do
			l_type_lib := a_type_info.type_info (a_handle).containing_type_lib
			l_guid := l_type_lib.library_attributes.guid
			if not library_counted (l_guid) then
				Result := type_library_analysis_steps_count (l_type_lib)
			end
		end

	library_counted (a_guid: ECOM_GUID): BOOLEAN is
			-- Were steps for library with GUID `a_guid' already counted?
		do
			Result := library_guids.has (a_guid)
		end

feature {NONE} -- Private Access

	library_guids: ARRAYED_LIST [ECOM_GUID];
			-- GUIDs of type libraries whose steps have already been counted

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
end -- class WIZARD_TYPE_LIBRARY_ANALYSIS_TASK

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
