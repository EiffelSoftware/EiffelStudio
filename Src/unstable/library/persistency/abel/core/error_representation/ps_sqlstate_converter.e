note
	description: "Converts SQLState error codes to corresponding ABEL error objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLSTATE_CONVERTER

feature

	convert_error (sqlstate: READABLE_STRING_GENERAL): PS_ERROR
			--Converts SQLState errors to ABEL error objects
		require
			exact_length: sqlstate.count = 5
		local
			category: IMMUTABLE_STRING_32
			subcode: IMMUTABLE_STRING_32
		do
			create category.make_from_string_general (sqlstate.substring (1, 2))
			create subcode.make_from_string_general (sqlstate.substring (3, 5))


			-- TODO: all error categories and subcategories
			-- See http://publib.boulder.ibm.com/infocenter/dzichelp/v2r2/index.jsp?topic=%2Fcom.ibm.db2z9.doc.codes%2Fsrc%2Ftpc%2Fdb2z_sqlstatevalues.htm

			if category.is_equal ("00") then -- No error
				Result := no_error
			elseif category.is_equal ("01") then -- Warning
				Result := no_error
			elseif category.is_equal ("02") then -- No data
				Result := message_not_understood_error
			elseif category.is_equal ("07") then -- Dynamic SQL error (mainly prepared statements)
				Result := message_not_understood_error
			elseif category.is_equal ("08") then -- Connection errors
				Result := connection_setup_error
			elseif category.is_equal ("09") then -- Triggered Action exception
				Result := backend_runtime_error
			elseif category.is_equal ("0A") then -- Feature not supported
				Result := message_not_understood_error
			elseif category.is_equal ("0F") then -- Invalid Token
				Result := invalid_operation_error
			elseif category.is_equal ("0K") then -- Resignal when handler not active
				Result := invalid_operation_error
			elseif category.is_equal ("0N") then -- SQL/XML mapping error
				Result := message_not_understood_error
			elseif category.is_equal ("10") then -- XQuery error
				Result := message_not_understood_error
			elseif category.is_equal ("20") then --Case Not Found for Case Statement
				Result := message_not_understood_error
			elseif category.is_equal ("21") then -- Cardinality error
				Result := invalid_operation_error

			elseif category.is_equal ("22") then -- Data exception
				-- TODO
				check not_implemented: False end
				Result:= error


			elseif category.is_equal ("23") then -- Constraint violation
				Result := integrity_constraint_violation_error
			elseif category.is_equal ("24") then -- Invalid cursor state
				Result := invalid_operation_error
			elseif category.is_equal ("25") then -- Invalid transaction state
				Result := transaction_aborted_error
			elseif category.is_equal ("26") then -- Invalid SQL statement identifier
				Result := message_not_understood_error
			elseif category.is_equal ("2D") then -- Invalid Transaction termination
				Result := invalid_operation_error


				-- TODO: all other categories...
			elseif category.is_equal ("TODO") then
				Result := error


			else
				Result := error
			end

		end


feature {NONE} -- Factory functions

	no_error: PS_NO_ERROR
		do
			create Result
		end

	error: PS_ERROR
		do
			create Result
		end

	authorization_error: PS_AUTHORIZATION_ERROR
		do
			create Result
		end

	access_right_violation_error: PS_ACCESS_RIGHT_VIOLATION_ERROR
		do
			create Result
		end

	backend_runtime_error: PS_BACKEND_RUNTIME_ERROR
		do
			create Result
		end

	connection_setup_error: PS_CONNECTION_SETUP_ERROR
		do
			create Result
		end

	integrity_constraint_violation_error: PS_INTEGRITY_CONSTRAINT_VIOLATION_ERROR
		do
			create Result
		end

	internal_error: PS_INTERNAL_ERROR
		do
			create Result
		end

	invalid_operation_error: PS_INVALID_OPERATION_ERROR
		do
			create Result
		end

	message_not_understood_error: PS_MESSAGE_NOT_UNDERSTOOD_ERROR
		do
			create Result
		end

	transaction_aborted_error: PS_TRANSACTION_ABORTED_ERROR
		do
			create Result
		end

	version_mismatch_error: PS_VERSION_MISMATCH_ERROR
		do
			create Result
		end
end
