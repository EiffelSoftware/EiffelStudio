indexing
	description: "ActiveX dispinterface"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
		EOLE_ACTIVEX_DISPINTERFACE

inherit
	EOLE_DISPINTERFACE
		redefine 
			on_release, on_add_ref
		end
	creation
	make

feature -- Access

	class_factory:	EOLE_ACTIVEX
			-- Reference to class factory that created `Current'

feature {EOLE_CLASS_FACTORY} -- Callback

	set_class_factory (a_class_factory: EOLE_ACTIVEX) is
			-- Set `class_factory'
		do
			class_factory := a_class_factory
		end

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_release: INTEGER is
			-- Decrement counter. Decrement server lock counter
			-- Destroy associated C++ interface
			-- if reference counter = 0.
		do
			Result := Precursor
			class_factory.lock_server (False)
		end

	on_add_ref: INTEGER is
			-- Increment counter.
			-- Increment server lock counter
		do
			Result := Precursor
			class_factory.lock_server (True)
		end

invariant
	
end -- class EOLE_ACTIVEX_DISPINTERFACE
