indexing
	description: "Constants used by C++ encapsulation."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_CONSTANTS

feature -- Property

	valid_type (a_type: INTEGER): BOOLEAN is
			-- Does `a_type' belong to list of predefined constants.
		do
			inspect
				a_type
			when
				normal_type, creator_type, field_type,
				static_field_type, set_field_type,
				set_static_field_type, static_type,
				get_property_type, set_property_type,
				deferred_type, operator_type, creator_call_type,
				enum_field_type
			then
				Result := True
			else
				Result := False
			end
		end

	need_current (a_type: INTEGER): BOOLEAN is
			-- Does `a_type' correspond to either a static method
			-- or a static field access.
		require
			valid_type: valid_type (a_type)
		do
			Result := a_type /= static_type and
						a_type /= set_static_field_type and
						a_type /= static_field_type and
						a_type /= enum_field_type
		ensure
			current_needed: not Result implies
				(a_type = static_type or a_type = set_static_field_type or
				a_type = static_field_type or a_type = enum_field_type)
		end

feature -- Constants

	normal_type: INTEGER is 1
	creator_type: INTEGER is 2
	field_type: INTEGER is 3
	static_field_type: INTEGER is 4
	set_field_type: INTEGER is 5
	set_static_field_type: INTEGER is 6
	static_type: INTEGER is 7
	get_property_type: INTEGER is 8
	set_property_type: INTEGER is 9
	deferred_type: INTEGER is 10
	operator_type: INTEGER is 11
	creator_call_type: INTEGER is 12
	enum_field_type: INTEGER is 13
			-- Constants used to differentiate all type of IL externals.

	msil_language: INTEGER is 1
	java_language: INTEGER is 2
			-- Constants used to determine language of externals


end -- class SHARED_IL_CONSTANTS
