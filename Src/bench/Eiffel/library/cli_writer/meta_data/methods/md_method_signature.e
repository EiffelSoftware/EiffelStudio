indexing
	description: "[
		Represent a method signature both for reference
		and definition as we do not consume varargs.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_SIGNATURE

inherit
	MD_SIGNATURE
		redefine
			make
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			state := Method_type_setting_state
		ensure
			state_set: state = Method_type_setting_state
		end

feature -- Access

	set_method_type (t: INTEGER_8) is
			-- Set type of method.
			-- See MD_SIGNATURE_CONSTANTS for possible values.
		require
			valid_state: state = method_type_setting_state
		do
			internal_put (t, current_position)
			current_position := current_position + 1
			state := Parameter_count_state
		ensure
			state_set: state = Parameter_count_state
		end
		
	set_parameter_count (n: INTEGER) is
			-- Set number of method parameters.
			-- To be compressed.
		require
			valid_state: state = Parameter_count_state
		do
			state := Return_type_state
			compress_data (n)
		ensure
			state_set: state = Return_type_state
		end
	
	set_return_type (element_type: INTEGER_8; token: INTEGER) is
			-- Set return type of method.
		require
			valid_state: state = Return_type_state
			token_valid: (element_type = feature {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = feature {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				token /= 0
		do
			state := Parameters_state
			internal_put (element_type, current_position)
			current_position := current_position + 1
			if
				element_type = feature {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = feature {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype
			then
				compress_type_token (token)
			end
		ensure
			state_set: state = Parameters_state
		end

feature -- State

	state: INTEGER
			-- Current state of signature settings.

	method_type_setting_state: INTEGER is 1
	parameter_count_state: INTEGER is 2
	return_type_state: INTEGER is 3
	parameters_state: INTEGER is 4
	
end -- class MD_METHOD_SIGNATURE
