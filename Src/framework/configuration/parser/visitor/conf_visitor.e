indexing
	description: "Visitor to visit configuration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_VISITOR

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Status

	is_error: BOOLEAN is
			-- Was there an error?
		do
			Result := last_errors /= Void and then not last_errors.is_empty
		end

	is_warning: BOOLEAN is
			-- Was there a warning?
		do
			Result := last_warnings /= Void and then not last_warnings.is_empty
		end

	last_errors: ARRAYED_LIST [CONF_ERROR]
			-- The last errors.

	last_warnings: ARRAYED_LIST [CONF_ERROR]
			-- The last warnings.

feature -- Visit nodes

	process_system (a_system: CONF_SYSTEM) is
			-- Visit `a_system'.
		require
			a_system_not_void: a_system /= Void
		deferred
		end

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		require
			a_target_not_void: a_target /= Void
		deferred
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		require
			a_group_not_void: a_group /= Void
		deferred
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		deferred
		end

	process_physical_assembly (an_assembly: CONF_PHYSICAL_ASSEMBLY_INTERFACE) is
			-- Visit `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		deferred
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		require
			a_library_not_void: a_library /= Void
		deferred
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		require
			a_precompile_not_void: a_precompile /= Void
		deferred
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		deferred
		end

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER) is
			-- Visit `a_cluster'.
		require
			a_test_cluster_not_void: a_test_cluster /= Void
		deferred
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		require
			an_override_not_void: an_override /= Void
		deferred
		end

feature {NONE} -- Implementation

	add_error (an_error: CONF_ERROR) is
			-- Add `an_error' without raising an exception.
		require
			an_error_not_void: an_error /= Void
		do
			if not is_error then
				create last_errors.make (1)
			end
			last_errors.extend (an_error)
		end

	add_and_raise_error (an_error: CONF_ERROR) is
			-- Add `an_error' and raise an exception.
		require
			an_error_not_void: an_error /= Void
		do
			if not is_error then
				create last_errors.make (1)
			end
			last_errors.extend (an_error)
			raise_error
		end

	add_warning (a_warning: CONF_ERROR) is
			-- Add `a_warning'.
		require
			a_warning_not_void: a_warning /= Void
		do
			if last_warnings = Void  then
				create last_warnings.make (1)
			end
			last_warnings.extend (a_warning)
		end

	checksum is
			-- Check if we have an error and throw an exception.
		do
			if is_error then
				raise_error
			end
		end

	raise_error is
			-- Raise an exception because we have errors.
		require
			is_error: is_error
		do
			raise (configuration_error_tag)
		end

feature {NONE} -- Implementation

	configuration_error_tag: STRING is "Configuration error";
			-- Tag used when raising an exception error.

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
end
