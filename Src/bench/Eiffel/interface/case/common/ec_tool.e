indexing
	description: "Window Skeleton:Basic Window with menu, toolbar and a container"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EC_TOOL

inherit
	ECASE_WINDOW


feature -- Properties

	menu: EC_MENU
		-- Menu basics for each editor

	toolbar: ECASE_TOOLBAR

	global_container: EV_CONTAINER


end -- class EC_TOOL
