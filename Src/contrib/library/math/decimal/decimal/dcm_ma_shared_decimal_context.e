note
	description:
		"Access to the shared decimal context; used to be a singleton"
	copyright: "Copyright (c) 2004, Paul G. Crismer and others."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"


class DCM_MA_SHARED_DECIMAL_CONTEXT

feature -- Access

	shared_decimal_context: DCM_MA_DECIMAL_CONTEXT
			-- Decimal context for operations where it does not explicitly appear in the signature;
			-- Return `default_context' by default, but can be changed by calling `set_shared_decimal_context'
		do
			Result := cell.item
		ensure
			shared_decimal_context_not_void: Result /= Void
		end

	default_context: DCM_MA_DECIMAL_CONTEXT
			-- Default context for general purpose arithmetic
		once
			create Result.make_default
		ensure
			default_context_not_void: Result /= Void
		end

feature -- Setting

	set_shared_decimal_context (new_context: DCM_MA_DECIMAL_CONTEXT)
			-- Set `shared_decimal_context' to `new_context'.
			-- It is best practice to call this routine once and for all
			-- at the beginning of the application to avoid unexpected
			-- behaviors.
		require
			new_context_not_void: new_context /= Void
		do
			cell.put (new_context)
		ensure
			context_set: shared_decimal_context = new_context
		end

feature {NONE} -- Implementation

	cell: CELL [DCM_MA_DECIMAL_CONTEXT]
			-- Cell containing shared decimal context
		once
			create Result.put (default_context)
		ensure
			cell_not_void: Result /= Void
			context_not_void: cell.item /= Void
		end

note
	copyright: "Copyright (c) 2004, Paul G. Crismer and others."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by Paul G. Crismer as part of Gobo. 
			Revised by Jocelyn Fiat for void safety.
		]"

end
