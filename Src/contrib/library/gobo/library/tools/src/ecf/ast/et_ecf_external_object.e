note

	description:

		"ECF external objects"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ECF_EXTERNAL_OBJECT

inherit

	ET_ECF_CONDITIONED

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_pathname: like pathname)
			-- Create a new external object.
		require
			a_pathname_not_void: a_pathname /= Void
		do
			pathname := a_pathname
		ensure
			pathname_set: pathname = a_pathname
		end

feature -- Access

	pathname: STRING
			-- Pathname

feature -- Element change

	fill_external_objects (a_universe: ET_ECF_INTERNAL_UNIVERSE; a_state: ET_ECF_STATE)
			-- Add to `a_universe.current_system' the current external object pathname
			-- of conditions satisfy `a_state'.
		require
			a_universe_not_void: a_universe /= Void
			a_state_not_void: a_state /= Void
		local
			l_pathname: STRING
		do
			if is_enabled (a_state) then
				if pathname.starts_with ("$ECF_CONFIG_PATH") then
					l_pathname := file_system.dirname (a_universe.filename) + pathname.substring (17, pathname.count)
				elseif pathname.starts_with ("$(ECF_CONFIG_PATH)") or pathname.starts_with ("${ECF_CONFIG_PATH}") then
					l_pathname := file_system.dirname (a_universe.filename) + pathname.substring (19, pathname.count)
				else
					l_pathname := pathname
				end
				a_universe.current_system.external_object_pathnames.force_last (l_pathname)
			end
		end

invariant

	pathname_not_void: pathname /= Void

end
