note
	description: "Automatically initialize the C compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_SETUP

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialize

	initialize (options: RESOURCE_TABLE; a_force_32bit: BOOLEAN)
			-- Properly configure the C compiler.
		require
			options_not_void: options /= Void
		local
			l_smart_checking: BOOLEAN
			l_vs_setup: VS_SETUP
		do
				-- Check if a smart checking should be done.
			l_smart_checking := options.get_boolean ("smart_checking", True)
			if eiffel_layout.eiffel_c_compiler.is_equal ("msc") and l_smart_checking then
					-- Visual Studio C compiler.
				create l_vs_setup.make (a_force_32bit)
			end
		end

end
