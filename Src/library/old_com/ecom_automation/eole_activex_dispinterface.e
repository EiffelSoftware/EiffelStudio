indexing
	description: "ActiveX dispinterface"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
		EOLE_ACTIVEX_DISPINTERFACE

inherit
	EOLE_DISPATCH
		redefine
			make, 
			on_release, on_add_ref,
			interface_identifier_list
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize OLE interface
		do
			Precursor
			create_ole_interface_ptr
		end

feature -- Access

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (class_factory.dispinterface_id)
		end

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
