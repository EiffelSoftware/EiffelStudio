note
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
			copy,
			default_create,
			is_equal
		end

	CONF_ACCESS
		redefine
			copy,
			default_create,
			is_equal
		end

create
	default_create,
	make_6_3,
	make_6_4,
	make_7_0,
	make_7_3,
	make_14_05,
	make_15_11

feature {NONE} -- Creation

	default_create
			-- Initialize options to the defaults of the current version.
		do
			make_15_11
		end

	make_6_3
			-- Initialize options to the defaults of 6.3.
		do
			create syntax.make (syntax_name, syntax_index_obsolete)
			create void_safety.make (void_safety_name, void_safety_index_none)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_obsolete_routine_type := True
		end

	make_6_4
			-- Initialize options to the defaults of 6.4.
		do
			create syntax.make (syntax_name, syntax_index_transitional)
			create void_safety.make (void_safety_name, void_safety_index_none)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_obsolete_routine_type := True
		end

	make_7_0
			-- Initialize options to the defaults of 7.0.
		do
			create syntax.make (syntax_name, syntax_index_standard)
			create void_safety.make (void_safety_name, void_safety_index_none)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_attached_by_default := True
			is_obsolete_routine_type := True
		end

	make_7_3
			-- Initialize options to the defaults of 7.3.
		do
			create syntax.make (syntax_name, syntax_index_standard)
			create void_safety.make (void_safety_name, void_safety_index_transitional)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_attached_by_default := True
			is_full_class_checking := True
			is_obsolete_routine_type := True
		end

	make_14_05
			-- Initialize options to the defaults of 14.05.
		do
			create syntax.make (syntax_name, syntax_index_standard)
			create void_safety.make (void_safety_name, void_safety_index_all)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_attached_by_default := True
			is_full_class_checking := True
			is_obsolete_routine_type := True
		end

	make_15_11
			-- Initialize options to the defaults of 15.11.
		do
			create syntax.make (syntax_name, syntax_index_standard)
			create void_safety.make (void_safety_name, void_safety_index_all)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_attached_by_default := True
			is_full_class_checking := True
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

	is_warning_configured: BOOLEAN
			-- Is `is_warning' configured?

	is_msil_application_optimize_configured: BOOLEAN
			-- Is `is_msil_application_optimize' configured?

	is_full_class_checking_configured: BOOLEAN
			-- Is `is_full_class_checking' configued?

	is_attached_by_default_configured: BOOLEAN
			-- Is `is_attached_by_default' configured?

	is_obsolete_routine_type_configured: BOOLEAN
			-- Is `is_obsolete_routine_type' configured?

	is_empty: BOOLEAN
			-- Is `Current' empty? No settings are set?
		do
			Result := not (
				is_profile_configured or
				is_trace_configured or
				is_optimize_configured or
				is_debug_configured or
				is_warning_configured or
				is_msil_application_optimize_configured or
				is_full_class_checking_configured or
				catcall_detection.is_set or
				is_attached_by_default_configured or
				is_obsolete_routine_type_configured or
				void_safety.is_set or
				assertions /= Void or
				local_namespace /= Void or
				warnings /= Void or
				debugs /= Void or
				syntax.is_set)
		end

feature -- Status update

	unset_profile
			-- Unset profile.
		do
			is_profile_configured := False
			is_profile := False
		end

	unset_trace
			-- Unset trace.
		do
			is_trace_configured := False
			is_trace := False
		end

	unset_optimize
			-- Unset optimize.
		do
			is_optimize_configured := False
			is_optimize := False
		end

	unset_debug
			-- Unset debug.
		do
			is_debug_configured := False
			is_debug := False
		end

	unset_warning
			-- Unset warning.
		do
			is_warning_configured := False
			is_warning := False
		end

	unset_msil_application_optimize
			-- Unset .NET application optimizations
		do
			is_msil_application_optimize_configured := False
			is_msil_application_optimize := False
		end

	unset_full_class_checking
			-- Unset full class checking.
		do
			is_full_class_checking_configured := False
			is_full_class_checking := False
		end

	unset_is_attached_by_default
			-- Unset `is_attached_by_default'.
		do
			is_attached_by_default_configured := False
			is_attached_by_default := False
		end

	unset_is_obsolete_routine_type
			-- Unset `is_obsolete_routine_type'.
		do
			is_obsolete_routine_type_configured := False
			is_obsolete_routine_type := False
		end

feature -- Access, stored in configuration file

	assertions: detachable CONF_ASSERTIONS
			-- The assertion settings.

	namespace: detachable STRING_32
			-- .NET namespace that is computed on demand.

	local_namespace: detachable STRING_32
			-- .NET namespace set in configuration file

	is_profile: BOOLEAN
			-- Do profile?

	is_trace: BOOLEAN
			-- Do trace?

	is_optimize: BOOLEAN
			-- Do optimize?

	is_debug: BOOLEAN
			-- Do debug?

	is_warning: BOOLEAN
			-- Show warnings?

	is_msil_application_optimize: BOOLEAN
			-- Do .NET specific application optimizations?

	is_full_class_checking: BOOLEAN
			-- Do we perform a full class checking?

	is_attached_by_default: BOOLEAN
			-- Is type declaration considered attached by default?

	is_obsolete_routine_type: BOOLEAN
			-- Is an obsolete routine type declaration used?

	description: detachable STRING_32
			-- A description about the options.

feature -- Access: syntax

	syntax: CONF_VALUE_CHOICE
			-- Expected variant of source code syntax

	syntax_index_obsolete: NATURAL_8 = 1
			-- Option index for obsolete syntax

	syntax_index_transitional: NATURAL_8 = 2
			-- Option index for transitional syntax

	syntax_index_standard: NATURAL_8 = 3
			-- Option index for standard syntax

	syntax_index_provisional: NATURAL_8 = 4
			-- Option index for provisional syntax

feature {NONE} -- Access: syntax

	syntax_name: ARRAY [READABLE_STRING_32]
			-- Available values for `syntax' option
		once
			Result := <<{STRING_32} "obsolete", {STRING_32} "transitional", {STRING_32} "standard", {STRING_32} "provisional">>
		ensure
			result_attached: Result /= Void
		end

feature -- Access: catcall

	catcall_detection: CONF_VALUE_CHOICE
			-- Various levels of catcall prevention: none, conformance, complete.

	catcall_detection_index_none: NATURAL_8 = 1
			-- Option index for no catcall check.

	catcall_detection_index_conformance: NATURAL_8 = 2
			-- Option index for conformance checks for frozen/variant annotations.

	catcall_detection_index_all: NATURAL_8 = 3
			-- Option index for catcall checks.

feature {NONE} -- Access: catcall detection

	catcall_detection_values: ARRAY [READABLE_STRING_32]
			-- Available values for `catcall_detection' option.
		once
			Result := <<{STRING_32} "none", {STRING_32} "conformance", {STRING_32} "all">>
		ensure
			result_attached: Result /= Void
		end

feature -- Access: void safety

	void_safety: CONF_VALUE_CHOICE
			-- Void safety option.

	void_safety_index_none: NATURAL_8 = 1
			-- Option index for no void safety.

	void_safety_index_conformance: NATURAL_8 = 2
			-- Option index for void safety with selected conformance checks.

	void_safety_index_initialization: NATURAL_8 = 3
			-- Option index for void safety with selected initialization checks.

	void_safety_index_transitional: NATURAL_8 = 4
			-- Option index for void safety with CAP for preconditions and check instructions and without unqualified agent checks.

	void_safety_index_all: NATURAL_8 = 5
			-- Option index for total void safety.

feature {NONE} -- Access: void safety

	void_safety_name: ARRAY [READABLE_STRING_32]
			-- Available values for `void_safety' option.
		once
			Result := <<{STRING_32} "none", {STRING_32} "conformance", {STRING_32} "initialization", {STRING_32} "transitional", {STRING_32} "all">>
		ensure
			result_attached: Result /= Void
		end

feature -- Access, stored in configuration file.

	debugs: detachable STRING_TABLE [BOOLEAN]
			-- Debug settings.

	warnings: detachable STRING_TABLE [BOOLEAN]
			-- Warning settings.

feature -- Access queries

	is_debug_enabled (a_debug: STRING): BOOLEAN
			-- Is `a_debug' enabled?
		do
			Result := is_debug and then
					attached debugs as l_debugs and then l_debugs.item (a_debug)
		end

	is_warning_enabled (a_warning: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_warning' enabled?
		require
			a_warning_valid: is_warning_known (a_warning)
		do
			Result := is_warning and then (not attached warnings as w or else (not w.has_key (a_warning) or else w.found_item))
		end

feature {CONF_ACCESS} -- Update, stored in configuration file.

	set_assertions (an_assertions: like assertions)
			-- Set `assertions' to `an_assertions'.
		do
			assertions := an_assertions
		ensure
			assertions_set: assertions = an_assertions
		end

	add_debug (a_name: READABLE_STRING_GENERAL; an_enabled: BOOLEAN)
			-- Add a debug.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		local
			l_debugs: like debugs
		do
			l_debugs := debugs
			if l_debugs = Void then
				create l_debugs.make_equal (1)
				debugs := l_debugs
			end
			l_debugs.force (an_enabled, a_name)
		ensure
			debugs_set: attached debugs as el_debugs
			added: el_debugs.has (a_name) and then el_debugs.item (a_name) = an_enabled
		end

	add_warning (a_name: READABLE_STRING_GENERAL; an_enabled: BOOLEAN)
			-- Add a warning.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.same_string (a_name.as_lower)
			known_warning: is_warning_known (a_name)
		local
			w: like warnings
		do
			w := warnings
			if w = Void then
				create w.make_equal (1)
				warnings := w
			end
			w.force (an_enabled, a_name)
		ensure
			warnings_set: attached warnings as el_warnings
			added: el_warnings.has (a_name) and then el_warnings.item (a_name) = an_enabled
		end

	set_local_namespace (a_namespace: like local_namespace)
			-- Set `local_namespace' from `a_namepace' and reset `namespace'.
		do
			if a_namespace /= Void and then a_namespace.is_empty then
				local_namespace := Void
			else
				local_namespace := a_namespace
			end
			namespace := Void
		ensure
			local_namespace_set:
				a_namespace = Void or else not a_namespace.is_empty implies local_namespace = a_namespace
			local_namespace_reset:
				a_namespace /= Void and then a_namespace.is_empty implies local_namespace = Void
			namespace_reset: namespace = Void
		end

	set_profile (a_enabled: BOOLEAN)
			-- Set `is_profile' to `a_enabled'.
		do
			is_profile_configured := True
			is_profile := a_enabled
		ensure
			is_profile_set: is_profile = a_enabled
			is_profile_configured: is_profile_configured
		end

	set_trace (a_enabled: BOOLEAN)
			-- Set `is_trace' to `a_enabled'.
		do
			is_trace_configured := True
			is_trace := a_enabled
		ensure
			is_trace_set: is_trace = a_enabled
			is_trace_configured: is_trace_configured
		end

	set_optimize (a_enabled: BOOLEAN)
			-- Set `is_optimize' to `a_enabled'.
		do
			is_optimize_configured := True
			is_optimize := a_enabled
		ensure
			is_optimize_set: is_optimize = a_enabled
			is_optimize_configured: is_optimize_configured
		end

	set_debug (a_enabled: BOOLEAN)
			-- Set `is_debug' to `a_enabled'.
			-- Enables/disables debug clauses in general.
		do
			is_debug_configured := True
			is_debug := a_enabled
		ensure
			is_debug_set: is_debug = a_enabled
			is_debug_configured: is_debug_configured
		end

	set_warning (a_enabled: BOOLEAN)
			-- Set `is_warning' to `a_enabled'.
			-- Enables/disables warning clauses in general.
		do
			is_warning_configured := True
			is_warning := a_enabled
		ensure
			is_warning_set: is_warning = a_enabled
			is_warning_configured: is_warning_configured
		end

	set_msil_application_optimize (a_enabled: BOOLEAN)
			-- Set `is_msil_application_optimize' to `a_enable'.
			-- Enabled/disables .NET application optimizations in general.
		do
			is_msil_application_optimize_configured := True
			is_msil_application_optimize := a_enabled
		ensure
			is_msil_application_optimize_set: is_msil_application_optimize = a_enabled
			is_msil_application_optimize_configured: is_msil_application_optimize_configured
		end

	set_full_class_checking (a_enabled: BOOLEAN)
			-- Set `is_full_class_checking' to `a_enabled'.
		do
			is_full_class_checking_configured := True
			is_full_class_checking := a_enabled
		ensure
			is_full_class_checking_set: is_full_class_checking = a_enabled
			is_full_class_checking_configured: is_full_class_checking_configured
		end

	set_is_attached_by_default (v: BOOLEAN)
			-- Set `is_attached_by_default' to `v'.
		do
			is_attached_by_default_configured := True
			is_attached_by_default := v
		ensure
			is_attached_by_default_set: is_attached_by_default = v
			is_attached_by_default_configured: is_attached_by_default_configured
		end

	set_is_obsolete_routine_type (v: BOOLEAN)
			-- Set `is_obsolete_routine_type' to `v'.
		do
			is_obsolete_routine_type_configured := True
			is_obsolete_routine_type := v
		ensure
			is_obsolete_routine_type_set: is_obsolete_routine_type = v
			is_obsolete_routine_type_configured: is_obsolete_routine_type_configured
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature -- Duplication

	copy (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		do
			if other /= Current then
				standard_copy (other)
				if attached other.assertions as a then
					assertions := a.twin
				end
				if attached other.debugs as d then
					debugs := d.twin
				end
				if attached other.description as s then
					description := s.twin
				end
				if attached other.local_namespace as l then
					local_namespace := l.twin
				end
				if attached other.namespace as n then
					namespace := n.twin
				end
				void_safety := other.void_safety.twin
				catcall_detection := other.catcall_detection.twin
				syntax := other.syntax.twin
				if attached other.warnings as w then
					warnings := w.twin
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			if equal (assertions, other.assertions)
			and then equal (debugs, other.debugs)
			and then equal (description, other.description)
			and then is_attached_by_default = other.is_attached_by_default
			and then is_attached_by_default_configured = other.is_attached_by_default_configured
			and then is_obsolete_routine_type = other.is_obsolete_routine_type
			and then is_obsolete_routine_type_configured = other.is_obsolete_routine_type_configured
			and then catcall_detection.is_equal (other.catcall_detection)
			and then is_debug = other.is_debug
			and then is_debug_configured = other.is_debug_configured
			and then is_full_class_checking = other.is_full_class_checking
			and then is_full_class_checking_configured = other.is_full_class_checking_configured
			and then is_msil_application_optimize = other.is_msil_application_optimize
			and then is_msil_application_optimize_configured = other.is_msil_application_optimize_configured
			and then is_optimize = other.is_optimize
			and then is_optimize_configured = other.is_optimize_configured
			and then is_profile = other.is_profile
			and then is_profile_configured = other.is_profile_configured
			and then is_trace = other.is_trace
			and then is_trace_configured = other.is_trace_configured
			and then is_warning = other.is_warning
			and then is_warning_configured = other.is_warning_configured
			and then equal (local_namespace, other.local_namespace)
			and then equal (namespace, other.namespace)
			and then void_safety.is_equal (other.void_safety)
			and then syntax.is_equal (other.syntax)
			and then equal (warnings, other.warnings)
			then
				Result := True
			end
		end

	is_equal_options (other: like Current): BOOLEAN
			-- Are `current' and `other' equal considering the options that are in the compiled result?
		do
			Result := equal (assertions, other.assertions) and
				is_debug = other.is_debug and
				is_optimize = other.is_optimize and
				is_profile = other.is_profile and
				is_full_class_checking = other.is_full_class_checking and
				catcall_detection.index = other.catcall_detection.index and
				is_attached_by_default = other.is_attached_by_default and
				is_obsolete_routine_type = other.is_obsolete_routine_type and
				is_trace = other.is_trace and
				void_safety.index = other.void_safety.index and
				syntax.index = other.syntax.index and
				equal(local_namespace, other.local_namespace) and
				equal (debugs, other.debugs)
		end

	is_void_safety_supported (other: CONF_OPTION): BOOLEAN
			-- Does current setting provide the same or better void-safety level than `other'?
		do
			inspect other.void_safety.index
			when void_safety_index_none then
				Result := True
			when void_safety_index_conformance then
				Result := void_safety.index /= void_safety_index_none
			when void_safety_index_initialization then
				Result :=
					void_safety.index /= void_safety_index_none and then
					void_safety.index /= void_safety_index_conformance
			when void_safety_index_transitional then
				Result :=
					void_safety.index = void_safety_index_transitional or else
					void_safety.index = void_safety_index_all
			when void_safety_index_all then
				Result := void_safety.index = void_safety_index_all
			else
				Result := void_safety.index = other.void_safety.index
			end
		end

	is_void_safety_sufficient (other: CONF_OPTION): BOOLEAN
			-- Does current setting provide the void-safety level than is sufficient to be used by the client with the setting `other'?
		do
			inspect other.void_safety.index
			when
				void_safety_index_none,
				void_safety_index_conformance,
				void_safety_index_initialization
			then
					-- Targets of feature calls are not checked,
					-- so it's OK to mix different levels as a feature call on void target is still possible.
				Result := True
			else
				Result := is_void_safety_supported (other)
			end
		ensure
			sufficient_if_supported: is_void_safety_supported (other) implies Result
		end

feature -- Merging

	merge_client (other: like Current)
			-- Merge with client options `other', if the values aren't defined in `Current' take the values of `other'.
			-- Apply this only for options that can be overridden by the client.
		local
			l_tmp: like debugs
			l_warnings: like warnings
			l_debugs: like debugs
		do
			if other /= Void then
				if assertions = Void then
					assertions := other.assertions
				end
				l_debugs := debugs
				if l_debugs = Void then
					l_debugs := other.debugs
					debugs := l_debugs
				elseif attached other.debugs as l_other_debugs then
					l_tmp := l_other_debugs.twin
					l_tmp.merge (l_debugs)
					debugs := l_tmp
				end
				l_warnings := warnings
				if l_warnings = Void then
					l_warnings := other.warnings
					warnings := l_warnings
				elseif attached other.warnings as l_other_warnings then
					l_warnings := l_other_warnings.twin
					l_warnings.merge (l_warnings)
					warnings := l_warnings
				end
				if not is_profile_configured then
					is_profile_configured := other.is_profile_configured or else is_profile /~ other.is_profile
					is_profile := other.is_profile
				end
				if not is_trace_configured then
					is_trace_configured := other.is_trace_configured or else is_trace /~ other.is_trace
					is_trace := other.is_trace
				end
				if not is_optimize_configured then
					is_optimize_configured := other.is_optimize_configured or else is_optimize /~ other.is_optimize
					is_optimize := other.is_optimize
				end
				if not is_debug_configured then
					is_debug_configured := other.is_debug_configured or else is_debug /~ other.is_debug
					is_debug := other.is_debug
				end
				if not is_warning_configured then
					is_warning_configured := other.is_warning_configured or else is_warning /~ other.is_warning
					is_warning := other.is_warning
				end
				if not is_msil_application_optimize_configured then
					is_msil_application_optimize_configured := other.is_msil_application_optimize_configured or else is_msil_application_optimize /~ other.is_msil_application_optimize
					is_msil_application_optimize := other.is_msil_application_optimize
				end
			end
		end

	merge (other: like Current)
			-- Merge with other, if the values aren't defined in `Current' take the values of `other'.
			-- Apply this to all options.
		local
			l_namespace: like local_namespace
		do
			if other /= Void then
				merge_client (other)
					-- Computation of `namespace' by using values in `other'.
				if attached other.namespace as l_other_namespace then
					l_namespace := l_other_namespace
				else
					l_namespace := other.local_namespace
				end
				if attached local_namespace as l_local_namespace then
					if l_namespace /= Void then
						namespace := l_namespace + "." + l_local_namespace
					else
						namespace := l_local_namespace.twin
					end
				elseif l_namespace /= Void then
					namespace := l_namespace.twin
				else
					namespace := Void
				end

				if not is_full_class_checking_configured then
					is_full_class_checking_configured := other.is_full_class_checking_configured or else is_full_class_checking /~ other.is_full_class_checking
					is_full_class_checking := other.is_full_class_checking
				end
				catcall_detection.set_safely (other.catcall_detection)
				if not is_obsolete_routine_type_configured then
					is_obsolete_routine_type_configured := other.is_obsolete_routine_type_configured or else is_obsolete_routine_type /~ other.is_obsolete_routine_type
					is_obsolete_routine_type := other.is_obsolete_routine_type
				end
				syntax.set_safely (other.syntax)
				void_safety.set_safely (other.void_safety)
					-- The merge for `is_attached_by_default' should happen after merging `void_safety'
					-- because the latter is used to default to `True' if the resulting project is not Void-safe.
				if not is_attached_by_default_configured then
					if not other.is_attached_by_default_configured and then void_safety.index = void_safety_index_none then
							-- Default attached-by-default to True, so that if a user decides to switch the option,
							-- it get's attached-by-default automatically.
						is_attached_by_default_configured := not other.is_attached_by_default
						is_attached_by_default := True
					else
							-- Use general merging scheme.
						is_attached_by_default_configured := other.is_attached_by_default_configured or else is_attached_by_default /~ other.is_attached_by_default
						is_attached_by_default := other.is_attached_by_default
					end
				end
			end
		end

invariant
	local_namespace_not_empty: not attached local_namespace as ns or else not ns.is_empty
	syntax_attached: syntax /= Void
	void_safety_attached: void_safety /= Void
	warnings_compare_objects: attached warnings as l_w implies l_w.object_comparison
	debugs_compare_objects: attached debugs as l_d implies l_d.object_comparison

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
