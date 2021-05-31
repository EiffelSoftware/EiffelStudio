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

	CONF_FILE_CONSTANTS
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
	make_15_11,
	make_18_01,
	make_19_11,
	make_21_05

feature {NONE} -- Creation

	default_create
			-- Initialize options to the defaults of the current version.
		do
			make_21_05
		end

	make_6_3
			-- Initialize options to the defaults of 6.3.
			-- First versioned settings.
		do
			create syntax.make (syntax_name, syntax_index_obsolete)
			create array.make (array_name, array_index_mismatch_warning)
			create void_safety.make (void_safety_name, void_safety_index_none)
			create catcall_detection.make (catcall_detection_values, catcall_detection_index_none)
			is_obsolete_routine_type := True
			is_obsolete_iteration := True
			create warning.make (warning_name, warning_index_none)
			create warning_obsolete_call.make (warning_term_name, warning_term_index_current)
		end

	make_6_4
			-- Initialize options to the defaults of 6.4.
			-- Difference from `make_6_3': transitional syntax.
		do
			make_6_3
			syntax.put_default_index (syntax_index_transitional)
		end

	make_7_0
			-- Initialize options to the defaults of 7.0.
			-- Difference from `make_6_4': standard syntax, class types attached by default.
		do
			make_6_4
			syntax.put_default_index (syntax_index_standard)
			is_attached_by_default := True
		end

	make_7_3
			-- Initialize options to the defaults of 7.3.
			-- Difference fom `make_7_0': transitional void safety, full class checking.
		do
			make_7_0
			void_safety.put_default_index (void_safety_index_transitional)
			is_full_class_checking := True
		end

	make_14_05
			-- Initialize options to the defaults of 14.05.
			-- Difference from `make_7_3': complete void safety.
		do
			make_7_3
			void_safety.put_default_index (void_safety_index_all)
		end

	make_15_11
			-- Initialize options to the defaults of 15.11.
			-- Difference from `make_14_05`: routine types without target parameter.
		do
			make_14_05
			is_obsolete_routine_type := False
		end

	make_16_11
			-- Initialize options to the defaults of 16.11.
			-- Difference from `make_15_11`: none. See `{CONF_TARGET_OPTION}`.
		do
			make_15_11
		end

	make_18_01
			-- Initialize options to the defaults of 18.01.
			-- Difference from `make_16_11`: manifest array type is computed without taking target type into account.
		do
			make_16_11
			array.put_default_index (array_index_standard)
		end

	make_19_05
			-- Initialize options to the defaults of 19.05.
			-- Difference from `make_18_01`: none. See `{CONF_TARGET_OPTION}`.
		do
			make_18_01
		end

	make_19_11
			-- Initialize options to the defaults of 19.11.
			-- Difference from `make_19_05`: warnings are reported.
		do
			make_19_05
			warning.put_default_index (warning_index_warning)
		end

	make_21_05
			-- Initialize options to the defaults of 21.05.
			-- Difference from `make_19_11`: loops without "is" keyword.
		do
			make_19_11
			is_obsolete_iteration := False
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

	is_msil_application_optimize_configured: BOOLEAN
			-- Is `is_msil_application_optimize' configured?

	is_full_class_checking_configured: BOOLEAN
			-- Is `is_full_class_checking' configued?

	is_attached_by_default_configured: BOOLEAN
			-- Is `is_attached_by_default' configured?

	is_obsolete_routine_type_configured: BOOLEAN
			-- Is `is_obsolete_routine_type' configured?

	is_obsolete_iteration_configured: BOOLEAN
			-- Is `is_obsolete_iteration` configured?

	is_empty: BOOLEAN
			-- Is `Current' empty? No settings are set?
		do
			Result := not (
				is_profile_configured or
				is_trace_configured or
				is_optimize_configured or
				is_debug_configured or
				is_msil_application_optimize_configured or
				is_full_class_checking_configured or
				catcall_detection.is_set or
				is_attached_by_default_configured or
				is_obsolete_routine_type_configured or
				is_obsolete_iteration_configured or
				void_safety.is_set or
				assertions /= Void or
				local_namespace /= Void or
				warnings /= Void or
				debugs /= Void or
				syntax.is_set or
				array.is_set or
				warning.is_set or
				warning_obsolete_call.is_set)
		end

	is_empty_for (n: detachable READABLE_STRING_32): BOOLEAN
			-- Is `Current' empty in a specific namespace `n`?
		do
			Result := not (
				is_profile_configured or
				is_trace_configured or
				is_optimize_configured or
				is_debug_configured or
				is_msil_application_optimize_configured or
				is_full_class_checking_configured or
				is_attached_by_default_configured or
				is_obsolete_routine_type_configured or
				is_obsolete_iteration_configured or
				assertions /= Void or
				local_namespace /= Void or
				warnings /= Void or
				debugs /= Void or
				syntax.is_set or
				array.is_set or
				warning.is_set or
				warning_obsolete_call.is_set or
					-- Void safety and catcall detection options are used only before `namespace_1_15_0`.
				(is_before_or_equal (n, namespace_1_15_0) and then
					(catcall_detection.is_set or
					void_safety.is_set)))
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

	unset_is_obsolete_iteration
			-- Unset `unset_is_obsolete_iteration`.
		do
			is_obsolete_iteration_configured := False
			is_obsolete_iteration := False
		ensure
			not is_obsolete_iteration_configured
			not is_obsolete_iteration
		end

	unset_is_obsolete_routine_type
			-- Unset `is_obsolete_routine_type`.
		do
			is_obsolete_routine_type_configured := False
			is_obsolete_routine_type := False
		ensure
			not is_obsolete_routine_type_configured
			not is_obsolete_routine_type
		end

feature -- Access, stored in configuration file

	assertions: detachable CONF_ASSERTIONS
			-- The assertion settings.

	namespace: detachable READABLE_STRING_32
			-- .NET namespace that is computed on demand.

	local_namespace: detachable READABLE_STRING_32
			-- .NET namespace set in configuration file

	is_profile: BOOLEAN
			-- Do profile?

	is_trace: BOOLEAN
			-- Do trace?

	is_optimize: BOOLEAN
			-- Do optimize?

	is_debug: BOOLEAN
			-- Do debug?

	is_msil_application_optimize: BOOLEAN
			-- Do .NET specific application optimizations?

	is_full_class_checking: BOOLEAN
			-- Do we perform a full class checking?

	is_attached_by_default: BOOLEAN
			-- Is type declaration considered attached by default?

	is_obsolete_iteration: BOOLEAN
			-- Is an obsolete iteration syntax used?
			-- Obsolete iteration syntax uses "is" with direct access to the iteration item,
			-- or uses "as" with direct access to the iteration cursor.
			-- Obsolete:
			-- 		across foo as x loop ... x.item ... x.key ... end
			-- 		across foo is x loop ... x ... @x.key ... end
			-- Contemporary:
			-- 		across foo as x loop ... x ... @x.key ... end

	is_obsolete_routine_type: BOOLEAN
			-- Is an obsolete routine type declaration used?

	description: detachable READABLE_STRING_32
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

feature -- Access: manifest array type

	array: CONF_VALUE_CHOICE
			-- Expected variant of manifest array typing rules.

	array_index_mismatch_error: NATURAL_8 = 1
			-- Option index for obsolete syntax

	array_index_mismatch_warning: NATURAL_8 = 2
			-- Option index for transitional syntax

	array_index_standard: NATURAL_8 = 3
			-- Option index for standard syntax

feature {NONE} -- Access: manifest array type

	array_name: ARRAY [READABLE_STRING_32]
			-- Available values for `array` option.
		once
			Result := <<{STRING_32} "mismatch_error", {STRING_32} "mismatch_warning", {STRING_32} "standard">>
		ensure
			result_attached: Result /= Void
		end

feature -- Warning: access

	warning: CONF_VALUE_CHOICE
			-- Expected way to report warnings.

	warning_index_none: NATURAL_8 = 1
			-- Option index to suppress warnings.

	warning_index_warning: NATURAL_8 = 2
			-- Option index to report warnings as warnings.

	warning_index_error: NATURAL_8 = 3
			-- Option index to report warnings as errors.

	warnings: detachable STRING_TABLE [BOOLEAN]
			-- Warning settings.

	warning_obsolete_call: CONF_VALUE_CHOICE
			-- Expected way to detect calls to obsolete features.
			-- Associated indexes are:
			-- • `warning_term_index_none`
			-- • `warning_term_index_current`
			-- • `warning_term_index_all`
			-- Associated names are `warning_term_name`.

	warning_term_index_none: NATURAL_8 = 1
			-- Option index to suppress warnings.
			-- Associated names are `warning_term_name`.

	warning_term_index_current: NATURAL_8 = 2
			-- Option index to report warnings relevant now.
			-- Associated names are `warning_term_name`.

	warning_term_index_all: NATURAL_8 = 3
			-- Option index to report all warnings.
			-- Associated names are `warning_term_name`.

feature -- Warning: status report

	is_valid_warning_term_index (i: like warning_term_index_none): BOOLEAN
			-- Does `i` represent a valid index of a term warning (such as `warning_obsolete_call`)?
		do
			inspect i
			when
				warning_term_index_none,
				warning_term_index_current,
				warning_term_index_all
			then
				Result := True
			else
					-- False by default.
			end
		ensure
			class
			definition: Result = (<<warning_term_index_none, warning_term_index_current, warning_term_index_all>>).has (i)
		end

	is_warning_enabled (a_warning: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_warning` enabled?
		require
			a_warning_valid: is_warning_known (a_warning) and then not a_warning.is_case_insensitive_equal (w_obsolete_feature)
		do
			Result := warning.index /= warning_index_none and then (attached warnings as w implies (w.has_key (a_warning) implies w.found_item))
		end

	is_warning_as_error: BOOLEAN
			-- Should a warning be reported as an error?
		do
			Result := warning.index = warning_index_error
		end

feature {NONE} -- Warning: access

	warning_name: ARRAY [READABLE_STRING_32]
			-- Available values for `warning` option.
		once
			Result := <<{STRING_32} "none", {STRING_32} "warning", {STRING_32} "error">>
		ensure
			result_attached: Result /= Void
		end

	warning_term_name: ARRAY [READABLE_STRING_32]
			-- Available values for `warning_obsolete_call` option.
			-- Associated indexes are:
			-- • `warning_term_index_none`
			-- • `warning_term_index_current`
			-- • `warning_term_index_all`
		once
			Result := <<{STRING_32} "none", {STRING_32} "current", {STRING_32} "all">>
		ensure
			result_attached: Result /= Void
		end

feature -- Warning: modification

	add_warning (a_name: READABLE_STRING_GENERAL; an_enabled: BOOLEAN)
			-- Add a warning.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.same_string (a_name.as_lower)
			known_warning: is_warning_known (a_name) and then not a_name.is_case_insensitive_equal (w_obsolete_feature)
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
			Result := <<
					{CONF_CONSTANTS}.void_safety_none_name.as_string_32,
					{CONF_CONSTANTS}.void_safety_conformance_name.as_string_32,
					{CONF_CONSTANTS}.void_safety_initialization_name.as_string_32,
					{CONF_CONSTANTS}.void_safety_transitional_name.as_string_32,
					{CONF_CONSTANTS}.void_safety_all_name.as_string_32
				>>
		ensure
			result_attached: Result /= Void
		end

feature -- Access, stored in configuration file.

	debugs: detachable STRING_TABLE [BOOLEAN]
			-- Debug settings.

feature -- Access queries

	is_debug_enabled (a_debug: STRING): BOOLEAN
			-- Is `a_debug' enabled?
		do
			Result := is_debug and then
					attached debugs as l_debugs and then l_debugs.item (a_debug)
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

	set_is_obsolete_iteration (v: BOOLEAN)
			-- Set `is_obsolete_iteration` to `v`.
			-- See also: `unset_is_obsolete_iteration`.
		do
			is_obsolete_iteration_configured := True
			is_obsolete_iteration := v
		ensure
			is_obsolete_iteration = v
			is_obsolete_iteration_configured
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
				array := other.array.twin
				warning := other.warning.twin
				if attached other.warnings as w then
					warnings := w.twin
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result :=
				assertions ~ other.assertions ∧…
				debugs ~ other.debugs ∧…
				description ~ other.description ∧…
				is_attached_by_default = other.is_attached_by_default ∧…
				is_attached_by_default_configured = other.is_attached_by_default_configured ∧…
				is_obsolete_iteration = other.is_obsolete_iteration ∧…
				is_obsolete_iteration_configured = other.is_obsolete_iteration_configured ∧…
				is_obsolete_routine_type = other.is_obsolete_routine_type ∧…
				is_obsolete_routine_type_configured = other.is_obsolete_routine_type_configured ∧…
				catcall_detection ~ other.catcall_detection ∧…
				is_debug = other.is_debug ∧…
				is_debug_configured = other.is_debug_configured ∧…
				is_full_class_checking = other.is_full_class_checking ∧…
				is_full_class_checking_configured = other.is_full_class_checking_configured ∧…
				is_msil_application_optimize = other.is_msil_application_optimize ∧…
				is_msil_application_optimize_configured = other.is_msil_application_optimize_configured ∧…
				is_optimize = other.is_optimize ∧…
				is_optimize_configured = other.is_optimize_configured ∧…
				is_profile = other.is_profile ∧…
				is_profile_configured = other.is_profile_configured ∧…
				is_trace = other.is_trace ∧…
				is_trace_configured = other.is_trace_configured ∧…
				local_namespace ~ other.local_namespace ∧…
				namespace ~ other.namespace ∧…
				void_safety ~ other.void_safety ∧…
				syntax ~ other.syntax ∧…
				array ~ other.array ∧…
				warning ~ other.warning ∧…
				warning_obsolete_call ~ other.warning_obsolete_call ∧…
				warnings ~ other.warnings
		end

	is_equal_options (other: like Current): BOOLEAN
			-- Are `current' and `other' equal considering the options that are in the compiled result?
		do
			Result :=
				assertions ~ other.assertions and
				is_debug = other.is_debug and
				is_optimize = other.is_optimize and
				is_profile = other.is_profile and
				is_full_class_checking = other.is_full_class_checking and
				catcall_detection.index = other.catcall_detection.index and
				is_attached_by_default = other.is_attached_by_default and
				is_obsolete_iteration = other.is_obsolete_iteration and
				is_obsolete_routine_type = other.is_obsolete_routine_type and
				is_trace = other.is_trace and
				void_safety.index = other.void_safety.index and
				syntax.index = other.syntax.index and
				array.index = other.array.index and
				warning.index = other.warning.index and
				local_namespace ~ other.local_namespace and
				debugs ~ other.debugs
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
				warning.set_safely (other.warning)
				warning_obsolete_call.set_safely (other.warning_obsolete_call)
				if not is_msil_application_optimize_configured then
					is_msil_application_optimize_configured := other.is_msil_application_optimize_configured or else is_msil_application_optimize /~ other.is_msil_application_optimize
					is_msil_application_optimize := other.is_msil_application_optimize
				end
			end
		end

	merge (other: like Current)
			-- Merge with other, if the values aren't defined in `Current' take the values of `other'.
			-- Apply this to all options.
		do
			if attached other then
				merge_client (other)
					-- Computation of `namespace' by using values in `other'.
				namespace :=
					if
						attached if attached other.namespace as n then n else other.local_namespace end as o
					then
						if attached local_namespace as l then o + "." + l else o.twin end
					elseif attached local_namespace as l then
						l.twin
					else
						Void
					end
				if not is_full_class_checking_configured then
					is_full_class_checking_configured := other.is_full_class_checking_configured or else is_full_class_checking /~ other.is_full_class_checking
					is_full_class_checking := other.is_full_class_checking
				end
				catcall_detection.set_safely (other.catcall_detection)
				if not is_obsolete_iteration_configured then
					is_obsolete_iteration_configured := other.is_obsolete_iteration_configured or else is_obsolete_iteration /~ other.is_obsolete_iteration
					is_obsolete_iteration := other.is_obsolete_iteration
				end
				if not is_obsolete_routine_type_configured then
					is_obsolete_routine_type_configured := other.is_obsolete_routine_type_configured or else is_obsolete_routine_type /~ other.is_obsolete_routine_type
					is_obsolete_routine_type := other.is_obsolete_routine_type
				end
				syntax.set_safely (other.syntax)
				array.set_safely (other.array)
				warning.set_safely (other.warning)
				void_safety.set_safely (other.void_safety)
					-- The merge for `is_attached_by_default' should happen after merging `void_safety'
					-- because the latter is used to default to `True' if the resulting project is not Void-safe.
				if not is_attached_by_default_configured then
					if not other.is_attached_by_default_configured and then void_safety.index = void_safety_index_none then
							-- Default attached-by-default to True, so that if a user decides to switch the option,
							-- he get's attached-by-default automatically.
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

	override_settings_from (other: like Current)
			-- Override settings from `other'.
		do
			is_full_class_checking_configured := other.is_full_class_checking_configured
			is_full_class_checking := other.is_full_class_checking
			catcall_detection.copy (other.catcall_detection)
			void_safety.copy (other.void_safety)
		end

invariant
	local_namespace_not_empty: not attached local_namespace as ns or else not ns.is_empty
	syntax_attached: syntax /= Void
	void_safety_attached: void_safety /= Void
	warnings_compare_objects: attached warnings as l_w implies l_w.object_comparison
	debugs_compare_objects: attached debugs as l_d implies l_d.object_comparison

note
	ca_ignore: "CA093", "CA093: manifest array type mismatch"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
