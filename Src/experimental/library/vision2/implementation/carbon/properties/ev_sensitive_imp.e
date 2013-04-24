note
	description: "Eiffel Vision sensitive. Carbon implementation." -- WHAT DOES THIS CLASS DO?
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
	HIVIEW_FUNCTIONS_EXTERNAL

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			Result := hiview_is_enabled_external ( c_object, null ).to_boolean
		end

feature -- Status setting

	enable_sensitive
			-- Allow the object to be sensitive to user input.
		local
			ret: INTEGER
		do
			ret := hiview_set_enabled_external (c_object, 1)
		end

	disable_sensitive
			-- Set the object to ignore all user input.
		local
			ret: INTEGER
		do
			ret := hiview_set_enabled_external (c_object, 0)
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
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- EV_SENSITIVE_IMP

