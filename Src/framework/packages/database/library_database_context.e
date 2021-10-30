note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE_CONTEXT

inherit
	ANY
		redefine
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize_defaults
		end

	initialize_defaults
		do
			any_settings := False
			set_platform (Void)
			set_concurrency (Void)
			set_void_safety (Void)
			build := {CONF_CONSTANTS}.build_finalize_name
		end

feature -- Access

	any_settings: BOOLEAN
			-- Any setting.

	platform: READABLE_STRING_8 -- assign set_platform

	concurrency: READABLE_STRING_8 -- assign set_concurrency

	is_il_generation: BOOLEAN

	build: READABLE_STRING_8

	void_safety: READABLE_STRING_8

feature -- Setting

	is_any_settings: BOOLEAN
		do
			Result := any_settings or not (is_platform_set and is_concurrency_set and is_void_safety_set)
		end

	is_platform_set: BOOLEAN

	is_concurrency_set: BOOLEAN

	is_void_safety_set: BOOLEAN

	is_build_set: BOOLEAN

feature -- Change

	use_any_settings (b: BOOLEAN)
			-- Set `is_any_settings' to `b'.
		do
			any_settings := b
		end

	set_platform (a_platform: detachable like platform)
		do
			is_platform_set := a_platform /= Void

			is_il_generation := False
			if a_platform = Void then
				is_il_generation := False
				if {PLATFORM}.is_dotnet then
					platform := {CONF_CONSTANTS}.pf_windows_name
					is_il_generation := True
				elseif {PLATFORM}.is_windows then
					platform := {CONF_CONSTANTS}.pf_windows_name
				elseif {PLATFORM}.is_unix then
					platform := {CONF_CONSTANTS}.pf_unix_name
				elseif {PLATFORM}.is_mac then
					platform := {CONF_CONSTANTS}.pf_macintosh_name
				elseif {PLATFORM}.is_vms then
					platform := {CONF_CONSTANTS}.pf_unix_name
				elseif {PLATFORM}.is_vxworks then
					platform := {CONF_CONSTANTS}.pf_vxworks_name
				else
					platform := {CONF_CONSTANTS}.pf_unix_name
				end
			else
				platform := a_platform
			end
		end

	set_concurrency (a_concurrency: detachable like concurrency)
		do
			is_concurrency_set := a_concurrency /= Void
			if a_concurrency = Void then
				concurrency := {CONF_CONSTANTS}.concurrency_none_name
			else
				concurrency := a_concurrency
			end
		end

	set_void_safety (v: detachable like void_safety)
		do
			is_void_safety_set := v /= Void
			if v = Void then
				void_safety := "none"
			else
				void_safety := v
			end
		end

	set_build (v: detachable like build)
		do
			is_build_set := v /= Void
			if v = Void then
				build := {CONF_CONSTANTS}.build_finalize_name
			else
				build := v
			end
		end

	set_is_il_generation (b: BOOLEAN)
		do
			is_il_generation := b
		end

feature -- Conversion

	to_table: STRING_TABLE [READABLE_STRING_8]
		do
			create Result.make (6)
			Result.force (is_any_settings.out, "is_any")
			Result.force (platform, "platform")
			Result.force (concurrency, "concurrency")
			Result.force (is_il_generation.out, "is_il_generation")
			Result.force (void_safety.out, "void_safety")
			Result.force (build, "build")
		end

feature -- Status report

	debug_output: READABLE_STRING_8
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := platform + " - " + concurrency
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := platform.is_case_insensitive_equal (other.platform) and
				concurrency.is_case_insensitive_equal (other.concurrency) and
				is_il_generation = other.is_il_generation
		end

end
