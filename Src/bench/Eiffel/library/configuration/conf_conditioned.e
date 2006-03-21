indexing
	description: "Objects that are only for a certain platform/build combination."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITIONED

inherit
	CONF_VALIDITY

feature -- Status report

	is_enabled (a_platform, a_build: INTEGER): BOOLEAN is
			-- Is `Current' enabled for `a_build' on `a_platform'?
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
		local
			l_flags: INTEGER
		do
			Result := internal_enabled = Void or else internal_enabled.is_empty
			if not Result then
				l_flags := a_platform | a_build
				from
					internal_enabled.start
				until
					Result or internal_enabled.after
				loop
					Result := internal_enabled.item & l_flags = l_flags
					internal_enabled.forth
				end
			end
		end

feature {CONF_ACCESS} -- Status update

	enable (a_platform, a_build: INTEGER) is
			-- Enable `Current' for `a_build' on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
		do
			if internal_enabled = Void then
				create internal_enabled.make (1)
			end
			internal_enabled.extend (a_platform | a_build)
		end

	inverse_enable (a_platform, a_build: INTEGER) is
			-- Enable `Current' for everything but `a_build' on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
			valid_build: valid_build (a_build)
		do
			if internal_enabled = Void then
				create internal_enabled.make (1)
			end
			if a_platform = pf_all then
				inverse_enable_build (a_build)
			elseif a_build = build_all then
				inverse_enable_platform (a_platform)
			else
				internal_enabled.extend ((a_platform | a_build).bit_not)
			end
		end

	inverse_enable_platform (a_platform: INTEGER) is
			-- Enable `Current' for everything but `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
		do
			if internal_enabled = Void then
				create internal_enabled.make (1)
			end
			internal_enabled.extend (a_platform.bit_not)
		end

	inverse_enable_build (a_build: INTEGER) is
			-- Enable `Current' for everything but `a_build'.
		require
			valid_build: valid_build (a_build)
		do
			if internal_enabled = Void then
				create internal_enabled.make (1)
			end
			internal_enabled.extend (a_build.bit_not)
		end



	wipe_out is
			-- Clear all enable flags.
		do
			internal_enabled.wipe_out
		end


feature {CONF_VISITOR} -- Implementation, attributes stored in configuration file

	internal_enabled: ARRAYED_LIST [INTEGER]
			-- The list of enabled bits.

end
