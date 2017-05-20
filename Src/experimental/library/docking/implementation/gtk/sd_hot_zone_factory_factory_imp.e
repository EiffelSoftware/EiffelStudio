note
	description: "Gtk implementation for SD_HOT_ZONE_ABSTRACT_FACTORY"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_FACTORY_FACTORY_IMP

inherit
	SD_HOT_ZONE_FACTORY_FACTORY

feature -- Hot zone factory

	hot_zone_factory (m: SD_DOCKER_MEDIATOR): SD_HOT_ZONE_ABSTRACT_FACTORY
			-- <Precursor>
		do
			create {SD_HOT_ZONE_OLD_FACTORY} Result.make (m)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
