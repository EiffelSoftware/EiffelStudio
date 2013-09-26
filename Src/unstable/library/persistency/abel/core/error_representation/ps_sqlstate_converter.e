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

			-- References:
			-- http://publib.boulder.ibm.com/infocenter/dzichelp/v2r2/index.jsp?topic=%2Fcom.ibm.db2z9.doc.codes%2Fsrc%2Ftpc%2Fdb2z_sqlstatevalues.htm
			-- http://www.postgresql.org/docs/9.1/static/errcodes-appendix.html#ERRCODES-TABLE
			-- http://starlet.deltatel.ru/rdb$doc/oraclerdb/sqlrm7/sql_pro_205.html
			-- https://mariadb.com/kb/en/error-sqlstates/

			-- SQL 2008 standard (draft):
			-- http://www.wiscorp.com/sql200n.zip

			-- SQL 2011 standard (draft):
			-- http://jtc1sc32.org/doc/N1951-2000/32N1964T-text_for_ballot-FCD_9075-2.pdf

			if category.is_equal ("00") then -- No error
				Result := no_error
			elseif category.is_equal ("01") then -- Warning
				Result := no_error
			elseif category.is_equal ("02") then -- No data
				-- TODO: check if this is really an error
				Result := message_not_understood_error
			elseif category.is_equal ("03") then -- SQL statement not yet complete
				Result := invalid_operation_error
			elseif category.is_equal ("07") then -- Dynamic SQL error
				Result := message_not_understood_error
			elseif category.is_equal ("08") then -- Connection errors
				-- TODO: investigate if further distinction necessary
				Result := connection_setup_error
			elseif category.is_equal ("09") then -- triggered action exception
				Result := backend_runtime_error
			elseif category.is_equal ("0A") then -- Feature not supported
				Result := message_not_understood_error
			elseif category.is_equal ("0B") then -- Invalid Transaction Initiation
				Result := invalid_operation_error
			elseif category.is_equal ("0D") then -- Invalid target type specification
				Result := invalid_operation_error
			elseif category.is_equal ("0E") then -- Invalid schema name list specification
				Result := invalid_operation_error
			elseif category.is_equal ("0F") then -- locator exception
				Result := invalid_operation_error
			elseif category.is_equal ("0K") then -- Resignal when handler not active
				Result := invalid_operation_error
			elseif category.is_equal ("0L") then -- invalid grantor
				Result := message_not_understood_error
			elseif category.is_equal ("0M") then -- invalid SQL-invoked procedure reference
				Result := message_not_understood_error
			elseif category.is_equal ("0N") then -- SQL/XML mapping error
				Result := message_not_understood_error
			elseif category.is_equal ("0P") then -- invalid role specification
				Result := message_not_understood_error
			elseif category.is_equal ("0S") then -- invalid transform group name specification
				Result := invalid_operation_error
			elseif category.is_equal ("0T") then -- target table disagrees with cursor specification
				Result := invalid_operation_error
			elseif category.is_equal ("0U") then -- Attempt to assign to non-updatable column
				Result := invalid_operation_error
			elseif category.is_equal ("0V") then -- Attempt to assign to ordering column
				Result := invalid_operation_error
			elseif category.is_equal ("0W") then -- prohibited statement encountered during trigger execution
				Result := invalid_operation_error
			elseif category.is_equal ("0Z") then -- diagnostics exception
				Result := invalid_operation_error
			elseif category.is_equal ("10") then -- XQuery error
				Result := message_not_understood_error
			elseif category.is_equal ("20") then --Case Not Found for Case Statement
				Result := message_not_understood_error
			elseif category.is_equal ("21") then -- Cardinality violation
				Result := invalid_operation_error

			elseif category.is_equal ("22") then -- Data exception
				-- TODO: check subcodes
				check not_implemented: False end
				Result:= error


			elseif category.is_equal ("23") then -- Integrity constraint violation
				Result := integrity_constraint_violation_error
			elseif category.is_equal ("24") then -- Invalid cursor state
				Result := invalid_operation_error
			elseif category.is_equal ("25") then -- Invalid transaction state
				Result := transaction_aborted_error
			elseif category.is_equal ("26") then -- Invalid SQL statement name
				Result := message_not_understood_error
			elseif category.is_equal ("27") then -- triggered data change violation
				Result := invalid_operation_error
			elseif category.is_equal ("28") then -- invalid authorization specification
				Result := message_not_understood_error
			elseif category.is_equal ("2B") then -- dependent privilege descriptors still exist
				Result := invalid_operation_error
			elseif category.is_equal ("2C") then -- invalid character set name
				Result := message_not_understood_error
			elseif category.is_equal ("2D") then -- Invalid transaction termination
				Result := invalid_operation_error
			elseif category.is_equal ("2E") then -- Invalid connection name
				Result := message_not_understood_error
			elseif category.is_equal ("2F") then -- SQL routine exception
				Result := invalid_operation_error
			elseif category.is_equal ("2H") then -- Invalid collation name
				Result := message_not_understood_error
			elseif category.is_equal ("30") then -- Invalid SQL statement identifier
				Result := message_not_understood_error
			elseif category.is_equal ("33") then -- Invalid SQL descriptor name
				Result := message_not_understood_error
			elseif category.is_equal ("34") then -- Invalid cursor name
				Result := message_not_understood_error
			elseif category.is_equal ("35") then -- Invalid condition number
				Result := message_not_understood_error
			elseif category.is_equal ("36") then -- Cursor Sensitivity Exception
				Result := invalid_operation_error
			elseif category.is_equal ("37") then -- Syntax Error (obsolete)
				Result := message_not_understood_error
			elseif category.is_equal ("38") then -- External routine exception
				Result := invalid_operation_error
			elseif category.is_equal ("39") then -- External routine invocation exception
				Result := invalid_operation_error
			elseif category.is_equal ("3B") then -- Savepoint exception
				Result := invalid_operation_error
			elseif category.is_equal ("3C") then -- Ambiguous Cursor Name
				Result := message_not_understood_error
			elseif category.is_equal ("3D") then -- Invalid catalog name
				Result := message_not_understood_error
			elseif category.is_equal ("3F") then -- Invalid schema name
				Result := message_not_understood_error
			elseif category.is_equal ("40") then -- Transaction Rollback
				Result := transaction_aborted_error

			elseif category.is_equal ("42") then -- Syntax Error or Access Rule Violation
				-- TODO: check subcodes
				-- SQL standard doesn't specify sucboces... might become problematic
				check not_implemented: False end
				Result := error

			elseif category.is_equal ("44") then -- WITH CHECK OPTION violation
				Result := invalid_operation_error
			elseif category.is_equal ("46") then -- Java errors
				Result := invalid_operation_error

			-- SQLState codes starting with 5 are implementation-specific...	

--			elseif category.is_equal ("51") then -- Invalid Application state
--				Result := invalid_operation_error
--			elseif category.is_equal ("53") then -- Invalid Operand or Inconsistent Specification -- TODO: check
--				Result := invalid_operation_error
--			elseif category.is_equal ("54") then -- SQL or Product limit exceeded
--				Result := message_not_understood_error
--			elseif category.is_equal ("55") then -- Object not in prerequisite state
--				Result := invalid_operation_error
--			elseif category.is_equal ("56") then -- Miscellaneous SQL or Product error
--				Result := invalid_operation_error
--			elseif category.is_equal ("57") then -- Resource not available or Operator Invention
--				Result := backend_runtime_error
--			elseif category.is_equal ("58") then -- System Error
--				Result := backend_runtime_error
--			elseif category.is_equal ("5U") then -- Common Utilities and Tools
--				Result := invalid_operation_error

			elseif category.is_equal ("HZ") then -- Remote Database Access
				Result := backend_runtime_error
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
