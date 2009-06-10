note
	description: "[
		{XH_FORM}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_FORM

create
	make

feature -- Initialization

	make
			-- Initilizator
		do
		end

feature	-- Basic Functionality

	is_valid: BOOLEAN
			-- Are all of the form values valid?
		do
			-- FIXME: Validate correctly with all the validators
			Result := True
		end

	get_real_bean: ANY
			-- Returns the "real world" bean with the values set from the form
			-- Executes all the setter agents
		do
			-- FIXME: Return the real object with all its values set
			Result := "ERROR"
		ensure
			result_attached: attached Result
		end

	update_validation_errors (a_validation_errors: HASH_TABLE [LIST [STRING], STRING])
			-- Fills the table with errors from the validation
			-- `a_validation_table': Mapping between field and validation errors
		require
			a_validation_errors_attached: attached a_validation_errors
		do
			-- FIXME TODO
		end

	add_validator (a_key: STRING; a_validator: XWA_VALIDATOR)
			-- Adds a validator to the list of validators for a specific key
		require
			a_key_valid: attached a_key and then not a_key.is_empty
			a_validator_attached: attached a_validator
		do
			-- FIXME TODO
		end

	add_attribute_setter (a_key: STRING; a_setter: PROCEDURE [ANY, TUPLE [ANY]])
			-- Sets the bean attribute setter for a specific key
		require
			a_key_valid: attached a_key and then not a_key.is_empty
			a_setter_attached: attached a_setter
		do
			-- FIXME TODO
		end

	retrieve (a_key: STRING): STRING
			-- Retrieves the value for a certain key
		require
			a_key_valid: attached a_key and then not a_key.is_empty
		do
			-- FIXME TODO
		ensure
			result_attached: attached Result
		end
end
