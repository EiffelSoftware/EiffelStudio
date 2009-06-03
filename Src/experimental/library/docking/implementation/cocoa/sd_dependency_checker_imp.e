note
	description: "Cocoa implementation for SD_DEPENDENCY_CHECKER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DEPENDENCY_CHECKER_IMP

inherit
	SD_DEPENDENCY_CHECKER

	EV_ANY_HANDLER

feature -- Command

	check_dependency (a_parent_window: EV_WINDOW)
			-- Does nothing on gtk, so we do nothing
		do
		end

	is_solaris_cde: BOOLEAN
			-- Mac OS /= Solaris :)
		do
			Result := False
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
