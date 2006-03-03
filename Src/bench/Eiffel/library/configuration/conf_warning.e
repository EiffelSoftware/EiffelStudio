indexing
	description: "Warning configuration."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_WARNING

inherit
	CONF_VALIDITY

create
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			create internal_warnings.make (2)
		end

feature -- Access, stored in configuration file

	is_enabled (a_warning: STRING): BOOLEAN is
			-- Is `a_warning' enabled?
		require
			a_warning_valid: valid_warning (a_warning)
		do
			if internal_warnings.has (a_warning) then
				Result := internal_warnings.item (a_warning)
			else
				Result := True
			end
		end


feature {CONF_ACCESS} -- Update, stored in configuration file

	enable (a_warning: STRING) is
			-- Enable `a_warning'.
		require
			a_warning_valid: valid_warning (a_warning)
		do
			internal_warnings.force (True, a_warning)
		end

	disable (a_warning: STRING) is
			-- Disable `a_warning'.
		require
			a_warning_valid: valid_warning (a_warning)
		do
			internal_warnings.force (False, a_warning)
		end


feature -- Merging

	merge (other: like Current) is
			-- Merge warning options.
		local
			l_tmp: like internal_warnings
		do
			l_tmp := other.internal_warnings.twin
			l_tmp.merge (internal_warnings)
			internal_warnings := l_tmp
		end

feature {CONF_WARNING, CONF_VISITOR} -- Implementation, attributes stored in configuration file

	internal_warnings: HASH_TABLE [BOOLEAN, STRING]
			-- The status of the warnings.

end
