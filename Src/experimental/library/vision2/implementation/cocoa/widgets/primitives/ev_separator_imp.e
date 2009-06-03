note
	description:
		"Eiffel Vision separator. Cocoa implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			make,
			interface,
			set_default_minimum_size
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the separator control.
		local
			box: NS_BOX
		do
			base_make (an_interface)
			create {NS_BOX}cocoa_item.make
			box ?= cocoa_item
			box.set_box_type ({NS_BOX}.box_separator)
		end

feature -- Layout handling

	set_default_minimum_size
			-- Minimum height/width that the widget may occupy.
		do
			internal_set_minimum_size (1, 1) -- Hardcoded value
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SEPARATOR;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_SEPARATOR_IMP

