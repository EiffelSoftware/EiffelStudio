indexing
 
	description:
		"Options explicitely set in the Ace file";
	date: "$Date$";
	revision: "$Revision $"
 
class ACE_OPTIONS

feature -- Properties

	has_assertion: BOOLEAN
	has_hide: BOOLEAN
	has_profile: BOOLEAN
	has_external_profile: BOOLEAN
	has_trace: BOOLEAN

	has_dead_code_removal: BOOLEAN
	array_optimization: BOOLEAN
	inlining: BOOLEAN
	collect: BOOLEAN
	exception_trace: BOOLEAN
	precompiled: BOOLEAN
	override_cluster: BOOLEAN

feature -- Setting

	set_has_assertion (b: BOOLEAN) is
			-- Set `has_assertion' to `b'.
		do
			has_assertion := b
		end

	set_has_hide (b: BOOLEAN) is
			-- Set `has_hide' to `b'.
		do
			has_hide := b
		end

	set_has_profile (b: BOOLEAN) is
			-- Set `has_profile' to `b'.
		do
			has_profile := b
		end

	set_has_external_profile (b: BOOLEAN) is
		do
			has_external_profile := b
		end

	set_has_trace (b: BOOLEAN) is
			-- Set `has_trace' to `b'.
		do
			has_trace := b
		end

feature -- Default value

	reset is
			-- Reset all the boolean values to `False'.
			--| We do not reset the value of `has_multithreaded' because
			--| we want to keep the previous value to know wether or not
			--| we will launch a C-compilation.
		do
			has_assertion := False
			has_hide := False
			has_profile := False
			has_external_profile := False
			has_trace := False

			has_dead_code_removal := False
			array_optimization := False
			inlining := False
			collect := False
			exception_trace := False
			precompiled := False
			override_cluster := False
		end

end -- class ACE_OPTIONS
