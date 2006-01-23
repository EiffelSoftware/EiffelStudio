indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MEMBER_INFORMATION

--inherit
--	IMEMBER_INFO_IMPL_STUB
----		rename
----			parameters as enum_parameters
--		redefine
--			name,
--			summary,
--			parameters,
--			returns
--		end

create
	make
	
feature -- Initialization
	
	make is
			-- Initialization.
		do
			create name.make_empty
			create summary.make_empty
			create parameters.make (10)
--			create enum_parameters.make (parameters)
			create returns.make_empty
		ensure
			non_void_name: name /= Void
			non_void_summary: summary /= Void
			non_void_parameters: parameters /= Void
			non_void_returns: returns /= Void
		end

feature -- Access

	name: STRING
	
	summary: STRING
	
	parameters: ARRAYED_LIST [PARAMETER_INFORMATION]
	
	returns: STRING
	

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_a_name: a_name /= Void
		do
			name := a_name	
		ensure
			name_set: name = a_name
		end

	set_summary (a_summary: like summary) is
			-- Set `summary' with `a_summary'.
		require
			non_void_a_summary: a_summary /= Void
		do
			summary := a_summary	
		ensure
			summary_set: summary = a_summary
		end

	set_returns (a_returns: like returns) is
			-- Set `returns' with `a_returns'.
		require
			non_void_a_returns: a_returns /= Void
		do
			returns := a_returns	
		ensure
			returns_set: returns = a_returns
		end


feature -- Basic Operations
	
	add_parameter (a_parameter: PARAMETER_INFORMATION) is
			-- Add `a_parameter' to `parameters'.
		require
			non_void_a_parameter: a_parameter /= Void
		do
			parameters.extend (a_parameter)
		ensure
			a_parameter_added: parameters.has (a_parameter)
		end

	reset is
			-- reinitialize object.
		do
			name.wipe_out
			summary.wipe_out
			parameters.wipe_out
			returns.wipe_out
		ensure
			empty_name: name.is_empty
			empty_summary: summary.is_empty
			empty_parameters: parameters.count = 0
			empty_returns: returns.is_empty
		end
		
invariant
	non_void_name: name /= Void
	non_void_summary: summary /= Void
	non_void_parameters: parameters /= Void
	non_void_returns: returns /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class MEMBER_INFORMATION
