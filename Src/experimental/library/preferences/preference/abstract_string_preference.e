note
	description: "String preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_STRING_PREFERENCE [G -> READABLE_STRING_GENERAL]

inherit
	TYPED_PREFERENCE [G]
		redefine
			init_value_from_string
		end

feature {NONE} -- Initialization

	init_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Set initial value from String `a_value'
		local
			v: G
		do
			if is_value_compatible (a_value) then
				v := to_value (a_value)
			else
				v := to_adapted_value (a_value)
			end
			internal_value := v
			Precursor {TYPED_PREFERENCE} (v)
		end

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String representation of `value'.
		do
			Result := value.as_string_32
		end

feature -- Access

	string_type: STRING
			-- String description of this preference type.
		deferred
		end

feature -- Query

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		do
				-- True.  A string preference may be empty and precondition ensures it is not void.
			Result := True
		end

feature -- Change

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		do
			set_value (to_value (a_value))
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "TEXT"
		end

feature {NONE} -- Implementation

	is_value_compatible (a_value: READABLE_STRING_GENERAL): BOOLEAN
			-- Is value `a_value' compatible with Current type of `value'?
		deferred
		end

	to_value (a_value: READABLE_STRING_GENERAL): G
			-- `a_value' to type of `value'.
		require
			is_value_compatible: is_value_compatible (a_value)
		deferred
		end

	to_adapted_value (a_value: READABLE_STRING_GENERAL): G
			-- Adapted conversion of `a_value' to type of `value'.
			--| This exists only for backward compatibility
		deferred
		end

	auto_default_value: G
			-- Value to use when Current is using auto by default (until real auto is set)
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class STRING_PREFERENCE
