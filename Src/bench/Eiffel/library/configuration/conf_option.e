indexing
	description: "Objects that specify configuration options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_OPTION

inherit
	CONF_VALIDITY
		redefine
			default_create
		end

	CONF_ACCESS
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			create warnings.make
		end


feature -- Status

	is_profile_configured: BOOLEAN
			-- Is `is_profile' configured?

	is_trace_configured: BOOLEAN
			-- Is `is_trace' configured?

	is_optimize_configured: BOOLEAN
			-- Is `is_optimize' configured?

	is_debug_configured: BOOLEAN
			-- Is `is_debug' configured?

feature -- Status update

	unset_profile is
			-- Unset profile.
		do
			is_profile_configured := False
			is_profile := False
		end

	unset_trace is
			-- Unset trace.
		do
			is_trace_configured := False
			is_trace := False
		end

	unset_optimize is
			-- Unset optimize.
		do
			is_optimize_configured := False
			is_optimize := False
		end

	unset_debug is
			-- Unset debug.
		do
			is_debug_configured := False
			is_debug := False
		end

feature -- Access, stored in configuration file

	assertions: CONF_ASSERTIONS
			-- The assertion settings.

	warnings: CONF_WARNING
			-- Warning configuration.

	namespace: STRING
			-- .NET namespace.

	is_profile: BOOLEAN
			-- Do profile?

	is_trace: BOOLEAN
			-- Do trace?

	is_optimize: BOOLEAN
			-- Do optimize?

	is_debug: BOOLEAN
			-- Do debug?

	description: STRING
			-- A description about the options.

feature -- Access, stored in configuration file.

	debugs: CONF_HASH_TABLE [BOOLEAN, STRING]
			-- The debug settings.

feature -- Access queries

	is_debug_enabled (a_debug: STRING): BOOLEAN is
			-- Is `a_debug' enabled?
		do
			Result := is_debug and then debugs /= Void and then debugs.item (a_debug)
		end


feature {CONF_ACCESS} -- Update, stored in configuration file.

	set_assertions (an_assertions: like assertions) is
			-- Set `assertions' to `an_assertions'.
		do
			assertions := an_assertions
		ensure
			assertions_set: assertions = an_assertions
		end

	set_debugs (a_debugs: like debugs) is
			-- Set `debugs' to `a_debugs'.
		do
			debugs := a_debugs
		ensure
			debugs_set: debugs = a_debugs
		end

	add_debug (a_name: STRING; an_enabled: BOOLEAN) is
			-- Add a debug.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			if debugs = Void then
				create debugs.make (1)
			end
			debugs.force (an_enabled, a_name)
		ensure
			added: debugs.has (a_name) and then debugs.item (a_name) = an_enabled
		end

	set_warnings (a_warnings: like warnings) is
			-- Set `warnings' to `a_warnings'.
		do
			warnings := a_warnings
		ensure
			warnings_set: warnings = a_warnings
		end

	add_warning (a_name: STRING; an_enabled: BOOLEAN) is
			-- Add a warning.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
			valid_warning: valid_warning (a_name)
		do
			if warnings = Void then
				create warnings.make
			end
			if an_enabled then
				warnings.enable (a_name)
			else
				warnings.disable (a_name)
			end
		ensure
			added: warnings.is_enabled (a_name) = an_enabled
		end

	set_namespace (a_namespace: like namespace) is
			-- Set `namespace' to `a_namespace'.
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end

	enable_profile is
			-- Set `is_profile' to true.
		do
			is_profile_configured := True
			is_profile := True
		ensure
			is_profile: is_profile
			is_profile_configured: is_profile_configured
		end

	disable_profile is
			-- Disable `is_profile'
		do
			is_profile_configured := True
			is_profile := False
		ensure
			not_is_profile: not is_profile
			is_profile_configured: is_profile_configured
		end

	enable_trace is
			-- Set `is_trace' to true.
		do
			is_trace_configured := True
			is_trace := True
		ensure
			is_trace_configured: is_trace_configured
			is_trace: is_trace
		end

	disable_trace is
			-- Set `is_trace' to false.
		do
			is_trace_configured := True
			is_trace := False
		ensure
			is_trace_configured: is_trace_configured
			not_is_trace: not is_trace
		end

	enable_optimize is
			-- Set `is_optimize' to true.
		do
			is_optimize_configured := True
			is_optimize := True
		ensure
			is_optimize_configured: is_optimize_configured
			is_optimize: is_optimize
		end

	disable_optimize is
			-- Set `is_optimize' to false.
		do
			is_optimize_configured := True
			is_optimize := False
		ensure
			is_optimize_configured: is_optimize_configured
			not_is_optimize: not is_optimize
		end

	enable_debug is
			-- Set `is_debug' to true.
		do
			is_debug_configured := True
			is_debug := True
		ensure
			is_debug_configured: is_debug_configured
			is_debug: is_debug
		end

	disable_debug is
			-- Set `is_debug' to false.
		do
			is_debug_configured := True
			is_debug := False
		ensure
			is_debug_configured: is_debug_configured
			not_is_debug: not is_debug
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature -- Comparison

	is_equal_options (other: like Current): BOOLEAN is
			-- Are `current' and `other' equal considering the options that are in the compiled result?
		do
			Result := equal (assertions, other.assertions) and is_debug = other.is_debug
				and is_optimize = other.is_optimize and is_profile = other.is_profile
				and is_trace = other.is_trace and equal(namespace, other.namespace)
				and equal (debugs, other.debugs)
		end

feature -- Merging

	merge (other: like Current) is
			-- Merge with other, if the values aren't defined in `Current' take the values of `other'.
		do
			if other /= Void then
				if assertions = Void then
					assertions := other.assertions
				end
				if debugs = Void then
					debugs := other.debugs
				end
				warnings.merge (other.warnings)
				if namespace = Void then
					namespace := other.namespace
				end
				if not is_profile_configured then
					is_profile_configured := other.is_profile_configured
					is_profile := other.is_profile
				end
				if not is_trace_configured then
					is_trace_configured := other.is_trace_configured
					is_trace := other.is_trace
				end
				if not is_optimize_configured then
					is_optimize_configured := other.is_optimize_configured
					is_optimize := other.is_optimize
				end
				if not is_debug_configured then
					is_debug_configured := other.is_debug_configured
					is_debug := other.is_debug
				end
			end
		end

invariant
	warnings_not_void: warnings /= Void

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
