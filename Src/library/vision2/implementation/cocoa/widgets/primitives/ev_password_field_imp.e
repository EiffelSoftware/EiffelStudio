note
	description:
		"Eiffel Vision password field. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I
		undefine
			hide_border
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			initialize,
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization


		make (an_interface: like interface)
			-- Create Textfield on a user_pane
		do
			base_make (an_interface)
			create {NS_SECURE_TEXT_FIELD}text_field.new
			cocoa_item := text_field
		end


feature -- Access

	initialize
			-- Create password field with `*'.
		do
		end


feature {NONE} -- Implementation

	interface: EV_PASSWORD_FIELD;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_PASSWORD_FIELD_IMP

