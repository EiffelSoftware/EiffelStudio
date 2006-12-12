deferred class
	OTHER_CLASS

inherit
	SYSTEM_OBJECT
	
	IDISPOSABLE
		rename
			dispose as idisposable_dispose
		end

feature -- Initialization

	init is
		deferred
		end

feature {NONE} -- IDisposable implementation

	frozen idisposable_dispose is
			-- Explicit implementation of IDisposable
		do
		end

end