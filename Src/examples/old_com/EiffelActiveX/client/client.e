indexing
	description: "Objects that ..."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT

inherit
	EOLE_AUTOMATION_CLIENT

	EOLE_METHOD_FLAGS
		export
			{NONE} all
		end
	
	EOLE_ERROR_CODE
		export 
			{NONE} all
		end

feature -- Access

	class_id: STRING is "{2DB76EC0-9672-11D2-B961-00403392AC95}"

feature -- Basic operations

	sum (arg1, arg2: INTEGER): INTEGER is
		local
			d_arg1, d_arg2: EOLE_VARIANT
		do
			dispparams.init
			function_exception.init
			function_result.init

			!!d_arg1
			d_arg1.init
			d_arg1.set_integer4 (arg1)

			!!d_arg2
			d_arg2.init
			d_arg2.set_integer4 (arg2)

			dispparams.add_argument (d_arg1)
			dispparams.add_argument (d_arg2)

			dispatch.invoke (1, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer4
		end

feature {NONE} -- Implementation

	check_result is
			-- Check result of last routine and display
			-- a message box if there was an error.
		local
			mess_box: WEL_MSG_BOX
			error_string: STRING
		do
			!! mess_box.make
			!! error_string.make (20)
			if function_exception.error_code /= S_ok then
				error_string.append ("Error #")
				error_string.append_integer (function_exception.error_code)
				mess_box.error_message_box (Void, function_exception.error_description, error_string)
			end
			if dispatch.status.last_hresult /= S_ok then
				error_string.append ("Dispatch Error #")
				error_string.append_integer (dispatch.status.last_hresult)
				mess_box.error_message_box (Void, "Error during dispatcher call", error_string)
			end
		end

invariant
	invariant_clause: -- Your invariant here

end -- class CLIENT
