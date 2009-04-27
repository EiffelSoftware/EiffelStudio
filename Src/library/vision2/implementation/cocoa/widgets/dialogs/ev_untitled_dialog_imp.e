indexing
	description: "Eiffel Vision dialog. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP

inherit
	EV_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_DIALOG_IMP}
		end

feature {NONE} -- Implementation

	interface: EV_UNTITLED_DIALOG;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_DIALOG_IMP

