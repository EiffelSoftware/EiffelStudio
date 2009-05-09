note
	description: "Eiffel Vision sensitive. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "sensitive"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SENSITIVE_IMP

inherit
	EV_SENSITIVE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			Result := True
		end

feature -- Status setting

	enable_sensitive
			-- Allow the object to be sensitive to user input.
		do
		end

	disable_sensitive
			-- Set the object to ignore all user input.
		do
		end

feature {EV_ANY_I} -- Implementation

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent: EV_ANY
		deferred
		end

	parent_is_sensitive: BOOLEAN
			-- (export status {NONE})
		local
			sensitive_parent: EV_SENSITIVE
		do
			sensitive_parent ?= parent
			if sensitive_parent /= Void then
				Result := sensitive_parent.is_sensitive
			end
		end

	interface: EV_SENSITIVE;
			-- Interface object for implementation

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- EV_SENSITIVE_IMP

