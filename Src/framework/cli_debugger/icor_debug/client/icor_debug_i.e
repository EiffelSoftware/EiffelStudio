note
	description: "[
			Objects that ...
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_I

inherit
	ICOR_DEBUG_FACTORY_I

	SHARED_ICOR_OBJECTS_MANAGER

	ICOR_EXPORTER

	DISPOSABLE

feature {ICOR_EXPORTER} -- Initialisation

	make_by_pointer (a_item: POINTER)
			-- Make Current by pointer.
		deferred
		end

feature {ICOR_EXPORTER} -- Access

	item: POINTER
			-- Access to the underlying C object.
		deferred
		end

feature -- Status			

	item_not_null: BOOLEAN
		do
			Result := not item.is_default_pointer
		end

feature {ICOR_EXPORTER} -- Status

	last_call_success: INTEGER assign set_last_call_success
		deferred
		end

	last_call_succeed: BOOLEAN
			-- Is last call a success ?
		deferred
		end

	last_error_code: INTEGER
			-- Convert `last_call_success' to hex and keep the last word
		deferred
		end

	last_error_code_id: STRING
			-- Convert `last_error_code' to hex and keep the last word	
		deferred
		end

	check_last_call_succeed: BOOLEAN
			-- Check last call
		deferred
		end

feature -- Equality

	is_equal_as_icor_object (other: like Current): BOOLEAN
			-- Comparison of pointer
		require
			other_not_void: other /= Void
		deferred
		ensure
			symmetric: Result implies other.is_equal_as_icor_object (Current)
			consistent: is_equal_as_icor_object (other) implies Result
		end

feature -- Ref management

	add_ref
			-- Call to the AddRef feature
		deferred
		end

	release
			-- Call to the Release feature
		deferred
		end

feature {ICOR_OBJECTS_MANAGER} -- Special feature for ICOR_OBJECTS_MANAGER

	update_item (p: POINTER)
		require
			p_valid: not p.is_default_pointer
			item_previously_removed: item.is_default_pointer
		deferred
		ensure
			item_set: item = p
		end

feature {ICOR_EXPORTER} -- Disposal

	clean_on_dispose
			-- Call this, to clean the object as if it is about to be disposed
		deferred
		end

feature {ICOR_EXPORTER} -- Implementation

	set_last_call_success (n: like last_call_success)
		deferred
		ensure
			last_call_success = n
		end

	Api_error_code_formatter: ICOR_DEBUG_API_ERROR_CODE_FORMATTER
		deferred
		end

feature {NONE} -- Implementation

	sizeof_WCHAR: INTEGER
			-- Number of bytes in a value of type `WCHAR'
		deferred
		end

	sizeof_CORDB_ADDRESS: INTEGER
			-- Number of bytes in a value of type `CORDB_ADDRESS'
		deferred
		end

end
