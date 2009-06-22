note
	description: "Eiffel Vision sensitive. Cocoa implementation."
	author: "Daniel Furrer"
	keywords: "sensitive"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SENSITIVE_IMP

inherit
	EV_SENSITIVE_I

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			Result := not is_not_sensitive
		end

feature -- Status setting

	enable_sensitive
			-- Allow the object to be sensitive to user input.
		do
			is_not_sensitive := False
		end

	disable_sensitive
			-- Set the object to ignore all user input.
		do
			is_not_sensitive := True
		end

feature {EV_ANY_I} -- Implementation

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent: detachable EV_ANY
		deferred
		end

	parent_is_sensitive: BOOLEAN
			-- (export status {NONE})
		do
			if attached {EV_SENSITIVE} parent as sensitive_parent then
				Result := sensitive_parent.is_sensitive
			end
		end

	is_not_sensitive: BOOLEAN

end -- EV_SENSITIVE_IMP
