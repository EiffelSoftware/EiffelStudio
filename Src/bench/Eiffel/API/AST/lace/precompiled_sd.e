indexing
	description: "Precompiled options in Ace";
	date: "$Date$";
	revision: "$Revision$"

class PRECOMPILED_SD

inherit
	OPTION_SD
		redefine
			is_precompiled, is_system_level,
			process_system_level_options
		end

feature -- Access

	option_name: STRING is "precompiled"

feature -- Status report

	is_precompiled: BOOLEAN is True
			-- Is `Current' a precompiled option?

	is_system_level: BOOLEAN is True
			-- Is `Current' a system level option?

feature {COMPILER_EXPORTER}

	adapt (value: OPT_VAL_SD; classes: EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		do
		end

	process_system_level_options (value: OPT_VAL_SD) is
		do
			if value = Void or else not value.is_name then
				error (value)
			end
		end

end -- class PRECOMPILED_SD
