note
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

	is_error: BOOLEAN
			-- Was there an error?
		do
			Result := attached last_errors as l_errors and then not l_errors.is_empty
		end

	is_warning: BOOLEAN
			-- Was there a warning?
		do
			Result := attached last_warnings as l_warnings and then not l_warnings.is_empty
		end

	last_errors: detachable ARRAYED_LIST [CONF_ERROR]
			-- The last errors.

	last_warnings: detachable ARRAYED_LIST [CONF_ERROR]
			-- The last warnings.

feature -- Visit nodes

	process_redirection (a_redirect: CONF_REDIRECTION)
			-- Visit `a_redirect'.
		require
			a_redirect_not_void: a_redirect /= Void
		deferred
		end

	process_system (a_system: CONF_SYSTEM)
			-- Visit `a_system'.
		require
			a_system_not_void: a_system /= Void
		deferred
		end

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		require
			a_target_not_void: a_target /= Void
		deferred
		end

	process_group (a_group: CONF_GROUP)
			-- Visit `a_group'.
		require
			a_group_not_void: a_group /= Void
		deferred
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		deferred
		end

	process_physical_assembly (an_assembly: CONF_PHYSICAL_ASSEMBLY_INTERFACE)
			-- Visit `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		deferred
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		require
			a_library_not_void: a_library /= Void
		deferred
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		require
			a_precompile_not_void: a_precompile /= Void
		deferred
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		deferred
		end

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER)
			-- Visit `a_cluster'.
		require
			a_test_cluster_not_void: a_test_cluster /= Void
		deferred
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		require
			an_override_not_void: an_override /= Void
		deferred
		end

	process_namespace (n: CONF_NAMESPACE)
			-- Visit a namespace node `n`.
		deferred
		end

feature {NONE} -- Implementation

	add_error (an_error: CONF_ERROR)
			-- Add `an_error' without raising an exception.
		require
			an_error_not_void: an_error /= Void
		local
			l_last_errors: like last_errors
		do
			l_last_errors := last_errors
			if l_last_errors = Void then
				create l_last_errors.make (1)
				last_errors := l_last_errors
			end
			l_last_errors.extend (an_error)
		end

	add_and_raise_error (an_error: CONF_ERROR)
			-- Add `an_error' and raise an exception.
		require
			an_error_not_void: an_error /= Void
		do
			add_error (an_error)
			raise_error
		ensure
			False
		end

	add_warning (a_warning: CONF_ERROR)
			-- Add `a_warning'.
		require
			a_warning_not_void: a_warning /= Void
		local
			l_last_warnings: like last_warnings
		do
			l_last_warnings := last_warnings
			if l_last_warnings = Void then
				create l_last_warnings.make (1)
				last_warnings := l_last_warnings
			end
			l_last_warnings.extend (a_warning)
		end

	checksum
			-- Check if we have an error and throw an exception.
		do
			if is_error then
				raise_error
			end
		end

	raise_error
			-- Raise an exception because we have errors.
		require
			is_error: is_error
		local
			l_conf_exception: CONF_EXCEPTION
		do
			create l_conf_exception
			l_conf_exception.set_description (configuration_error_tag)
			l_conf_exception.raise
		ensure
			False
		end

feature {NONE} -- Implementation

	configuration_error_tag: STRING_32 = "Configuration error";
			-- Tag used when raising an exception error.

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
end
