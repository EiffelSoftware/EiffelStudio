indexing
	description: "Objects that implement is_in_default_state%
		%to return True for descendents of Vision2 if we do not%
		%care about the real result."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_DEFAULT_STATE

inherit
	
	ANY
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- We do not care about this, so
			-- return True.
		do
			Result := True
		end
		
	default_create is
		deferred
		end
		
	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		deferred
		end
	
	is_equal (other: like Current): BOOLEAN is
		deferred
		end
		
		
end -- class GB_DEFAULT_STATE
