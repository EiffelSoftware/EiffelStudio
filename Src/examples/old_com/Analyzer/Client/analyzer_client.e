indexing
	description: "Automation client of server Analyzer";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ANALYZER_CLIENT

inherit
	EOLE_AUTOMATION_CLIENT
	
	EOLE_METHOD_FLAGS
		export
			{NONE} all
		end
	
	ANALYZER_DISPID
		export
			{NONE} all
		end
	
	ANALYZER_CLSID
		export
			{NONE} all
		end
		
	EOLE_ERROR_CODE
		export 
			{NONE} all
		end

feature -- Access

	class_id: STRING is 
			-- Class identifier of Analyzer server
		once
			Result := Analyzer_clsid
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Update text in server
		local
			arg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			!! bstr.adapt (txt)
			!! arg
			arg.init
			arg.set_bstr (bstr)
			dispparams.add_argument (arg)
			dispatch.invoke (Dispid_text, Dispatch_propertyput, dispparams, Void, function_exception)
			check_result
		end
		
	text: STRING is
			-- Text in server
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_text, Dispatch_propertyget, dispparams, function_result, function_exception)
			check_result
			Result := function_result.bstr.to_string
		end
			
	word_count: INTEGER is
			-- Word count in server text
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_word_count, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
	
	line_count: INTEGER is
			-- Line count in server text
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_line_count, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
		
	sentence_count: INTEGER is
			-- Sentence count in server text
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_sentence_count, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
	
	occurrences (txt: STRING): INTEGER is
			-- Number of occurrences of `txt' in server text
		local
			arg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			function_result.init
			!! bstr.adapt (txt)
			!! arg
			arg.init
			arg.set_bstr (bstr)
			dispparams.add_argument (arg)
			dispatch.invoke (Dispid_occurrences, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end

	show is
			-- Show server window.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Dispid_show, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	hide is
			-- Hide server window.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Dispid_hide, dispatch_method, dispparams, Void, function_exception)
			check_result
		end
		
	terminate_server is
			-- End server.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Dispid_terminate, dispatch_method, dispparams, Void, function_exception)
			check_result
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
	
end -- class ANALYZER_CLIENT

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

