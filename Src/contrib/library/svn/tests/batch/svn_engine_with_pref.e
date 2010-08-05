note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_ENGINE_WITH_PREF

inherit
	SVN_ENGINE
		redefine
			default_create
		end

	SVN_SHARED_PREFERENCES
		redefine
			default_create
		end

feature
	default_create
		do
			Precursor {SVN_ENGINE}
			update_from_preferences
			preferences.svn_executable_pref.change_actions.extend (agent update_from_preferences)
		end

feature {NONE} -- impl

	update_from_preferences
		do
			create svn_executable_path.make_from_string (preferences.svn_executable_pref.value)
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
