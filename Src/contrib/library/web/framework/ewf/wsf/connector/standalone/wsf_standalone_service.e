note
	description: "[
			Service using standalone connector launcher.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STANDALONE_SERVICE [G -> WSF_EXECUTION create make end]

inherit
	WSF_LAUNCHABLE_SERVICE

feature {NONE} -- Initialization

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_launcher: WSF_STANDALONE_SERVICE_LAUNCHER [G]
		do
			create l_launcher.make_and_launch (opts)
		end	

end
