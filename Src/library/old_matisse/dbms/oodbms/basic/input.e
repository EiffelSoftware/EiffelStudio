indexing
	description:"Abstraction for formatted input."
	version:    "%%I%%"
	date:       "%%D%%"
	source:     "%%P%%"
	keywords:   "range"
	copyright:   "See notice at end of class"

deferred class INPUT[G]

feature -- Initialisation
	set_from_canonical(s:STRING; v:G) is
			-- initialise from a "standard" string of form defined for G
		require
			Args_valid: is_canonical(s)
		deferred
		end

feature -- Validation
 	is_canonical(s:STRING):BOOLEAN is
		require
		      Args_valid: s /= Void and then not s.empty
	        deferred
	        end

end
