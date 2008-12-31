note
	description: "Automation client of server Analyzer"
	legal: "See notice at end of class.";
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

	class_id: STRING 
			-- Class identifier of Analyzer server
		once
			Result := Analyzer_clsid
		end

feature -- Element change

	set_text (txt: STRING)
			-- Update text in server
		local
			arg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			create bstr.adapt (txt)
			create arg
			arg.init
			arg.set_bstr (bstr)
			dispparams.add_argument (arg)
			dispatch.invoke (Dispid_text, Dispatch_propertyput, dispparams, Void, function_exception)
			check_result
		end
		
	text: STRING
			-- Text in server
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_text, Dispatch_propertyget, dispparams, function_result, function_exception)
			check_result
			Result := function_result.bstr.to_string
		end
			
	word_count: INTEGER
			-- Word count in server text
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_word_count, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
	
	line_count: INTEGER
			-- Line count in server text
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_line_count, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
		
	sentence_count: INTEGER
			-- Sentence count in server text
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Dispid_sentence_count, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
	
	occurrences (txt: STRING): INTEGER
			-- Number of occurrences of `txt' in server text
		local
			arg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			function_result.init
			create bstr.adapt (txt)
			create arg
			arg.init
			arg.set_bstr (bstr)
			dispparams.add_argument (arg)
			dispatch.invoke (Dispid_occurrences, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end

	show
			-- Show server window.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Dispid_show, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	hide
			-- Hide server window.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Dispid_hide, dispatch_method, dispparams, Void, function_exception)
			check_result
		end
		
	terminate_server
			-- End server.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Dispid_terminate, dispatch_method, dispparams, Void, function_exception)
			check_result
		end
		
feature {NONE} -- Implementation

	check_result
			-- Check result of last routine and display
			-- a message box if there was an error.
		local
			mess_box: WEL_MSG_BOX
			error_string: STRING
		do
			create mess_box.make
			create error_string.make (20)
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
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ANALYZER_CLIENT

