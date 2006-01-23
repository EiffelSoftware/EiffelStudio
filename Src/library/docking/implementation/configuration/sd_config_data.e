indexing
	description: "Objects that represent the data about inner container's structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONFIG_DATA

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method.
		do
			create internal_inner_container_datas.make (1)
			create internal_auto_hide_zones_data.make
			create menu_datas.make (1)
		end

feature -- Properties
	inner_container_datas: like internal_inner_container_datas is
			--
		do
			Result := internal_inner_container_datas
		end

	set_inner_container_datas (a_data: like internal_inner_container_datas) is
			--
		require
			a_data_not_void: a_data /= Void
		do
			internal_inner_container_datas := a_data
		ensure
			a_data_set: a_data = internal_inner_container_datas
		end

	auto_hide_panels_datas: like internal_auto_hide_zones_data is
			--
		do
			Result := internal_auto_hide_zones_data
		end

	menu_datas: ARRAYED_LIST [SD_MENU_DATA]
			-- Four direction menu data. 1 is top, 2 is bottom, 3 is left, 4 is right.

feature {NONE}  -- Implementation

	internal_inner_container_datas: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]

	internal_auto_hide_zones_data: SD_AUTO_HIDE_PANEL_DATA;

--	internal_inner_container_void: BOOLEAN
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
