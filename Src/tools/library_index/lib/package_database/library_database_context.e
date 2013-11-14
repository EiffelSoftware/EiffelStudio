note
	description: "Summary description for {LIBRARY_DATABASE_CONTEXT}."
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
			set_platform (Void)
			set_concurrency (Void)
			build := {CONF_CONSTANTS}.build_finalize_name
		end

feature -- Access

	platform: READABLE_STRING_8 assign set_platform

	concurrency: READABLE_STRING_8 assign set_concurrency

	is_il_generation: BOOLEAN

	build: READABLE_STRING_8

feature -- Change

	set_platform (a_platform: detachable like platform)
		do
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
			if a_concurrency = Void then
				concurrency := {CONF_CONSTANTS}.concurrency_none_name
			else
				concurrency := a_concurrency
			end
		end

	set_is_il_generation (b: BOOLEAN)
		do
			is_il_generation := b
		end

feature -- Conversion

	to_table: STRING_TABLE [READABLE_STRING_8]
		do
			create Result.make (3)
			Result.force (platform, "platform")
			Result.force (concurrency, "concurrency")
			Result.force (is_il_generation.out, "is_il_generation")
			Result.force (build, "build")
		end

feature -- Status report

	debug_output: STRING_8
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
