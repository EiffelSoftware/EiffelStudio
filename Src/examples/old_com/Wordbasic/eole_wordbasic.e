indexing
	description: "OLE WordBasic automation client"
	legal: "See notice at end of class.";
	note: "Some feature names (in the Element change category) %
			%do not follow Eiffel conventions, but follow Word Basic %
			%conventions instead. For example `file_new_default' would %
			%normally be called `create_default_file' but corresponds %
			%to WordBasic's `FileNewDefault' function.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_WORDBASIC

inherit
	EOLE_AUTOMATION_CLIENT
	
	EOLE_METHOD_FLAGS
		export
			{NONE} all
		end
	
	EOLE_WORDBASIC_DISPID
		export
			{NONE} all
		end
	
	EOLE_ERROR_CODE
		export 
			{NONE} all
		end

feature -- Access

	class_id: STRING is 
			-- Class identifier of WordBasic
		once
			Result := "{000209FE-0000-0000-C000-000000000046}"
		end

feature -- Element change

	file_new_default is
			-- Create new file from default template.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Filenewdefault_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end
		
	file_save is
			-- Save active document.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Filesave_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	file_open (filename: FILE_NAME) is
			-- Open a document
		local
			variantarg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			create bstr.adapt (filename)
			variantarg.set_bstr (bstr)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Fileopen_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end
		
	file_exit is
			-- Ask whether to save changes before exiting.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Fileexit_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	insert (text: STRING) is
			-- Insert `text' at insertion point.
		local
			variantarg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			create bstr.adapt (text)
			variantarg.set_bstr (bstr)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Insert_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	center_para is
			-- Center selected paragraphs.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Centerpara_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	left_para is
			-- Left-align selected paragraphs.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Leftpara_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	right_para is
			-- Right-align selected paragraphs.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Rightpara_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	line_up (count: INTEGER) is
			-- Move insertion point up by `count' lines.
			-- (If `count' is negative, move down by -`count'.)
		local
			variantarg: EOLE_VARIANT
			integer_ref: INTEGER_REF
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			variantarg.set_integer2 (count)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Lineup_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	line_down (count: INTEGER) is
			-- Move insertion point down by `count' lines.
			-- (If `count' is negative, move up by -`count'.)

		local
			variantarg: EOLE_VARIANT
			integer_ref: INTEGER_REF
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			variantarg.set_integer2 (count)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Linedown_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	bold is
			-- Turn selection to boldface.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Bold_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	italic is
			-- Turn selection to italics.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Italic_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	underline is
			-- Underline selection.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Underline_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	border_line_style (style: INTEGER) is
			-- Make `style' the line style to be used for subsequent calls
			-- to `border_top'.
		local
			variantarg: EOLE_VARIANT
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			variantarg.set_integer2 (style)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Borderlinestyle_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	border_top is
			-- Draw a border at the top of current
			-- paragraph, table cell or graphic.
			-- Use `border_line_style'.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Bordertop_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	tools_spelling is
			-- Check spelling in the current selection or,
			-- if there isn't a selection from insertion point
			-- to end of document.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Toolsspelling_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	tools_grammar is
			-- Display Grammar dialog box and begin 
			-- checking grammar in active document.
		do
			dispparams.init
			function_exception.init
			dispatch.invoke (Toolsgrammar_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	app_show is
			-- Display application window.
		local
			variantarg: EOLE_VARIANT
			bstr: EOLE_BSTR
			mb: WEL_MSG_BOX
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			create bstr.adapt ("Microsoft Word")
			variantarg.set_bstr (bstr)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Appshow_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end

	app_hide is
			-- Hide application window.
		local
			variantarg: EOLE_VARIANT
			bstr: EOLE_BSTR
		do
			dispparams.init
			function_exception.init
			create variantarg
			variantarg.init
			create bstr.adapt ("Microsoft Word")
			variantarg.set_bstr (bstr)
			dispparams.add_argument (variantarg)
			dispatch.invoke (Apphide_dispid, dispatch_method, dispparams, Void, function_exception)
			check_result
		end
		
	count_windows: INTEGER is
			-- Count of active windows
		do
			dispparams.init
			function_exception.init
			function_result.init
			dispatch.invoke (Countwindows_dispid, dispatch_method, dispparams, function_result, function_exception)
			check_result
			Result := function_result.integer2
		end
		
	get_id (func: STRING): INTEGER is
			-- Get the dispatch identifier of `func'
		local
			a: ARRAY [STRING]
		do
			create a.make (1,1)
			a.put (func,1)
			Result := dispatch.get_IDs_of_names (a).item (1)
		end
	
	error_description: STRING is
			-- Last error description
		do
			if function_exception.is_attached and function_exception.error_code /= S_ok then
				Result := function_exception.error_description
			else
				Result := "No error happened !"
			end
		end
		
	error_code: INTEGER is
			-- Last error code
		do
			Result := function_exception.error_code
		end
		
feature {NONE} -- Implementation

	check_result is
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
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EOLE_WORDBASIC

