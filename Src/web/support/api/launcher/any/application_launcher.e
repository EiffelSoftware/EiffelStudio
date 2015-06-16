note
	description: "[
				Effective class for APPLICATION_LAUNCHER_I

				You can put modification in this class
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_LAUNCHER [G -> WSF_EXECUTION create make end]

inherit
	APPLICATION_LAUNCHER_I [G]

feature -- Custom

	is_console_output_supported: BOOLEAN
		do
			Result := False
		end

end

