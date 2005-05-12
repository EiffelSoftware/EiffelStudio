indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			process_message
		end
		
	SHARED_PROJECT_PROPERTIES
		export
			{NONE} all
		end
		
create 
	make_top
	
feature {WEL_DISPATCHER}

	process_message (hwnd: POINTER; msg:INTEGER; wparam, lparam: POINTER): POINTER is
			-- Was declared in WEL_COMPOSITE_WINDOW as synonym of `composite_process_message'.
		do
			inspect msg
			when generate_html_docs_msg then
				check
					non_void_html_document_generator: html_document_generator /= Void
				end
				html_document_generator.item.generate_docs
				Result := default_pointer
			when compile_msg then
				check
					non_void_compiler: compiler /= Void
				end
				compiler.item.compile (lparam.to_integer_32)
				Result := default_pointer
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

feature {HTML_DOC_GENERATOR}

	process_generate_message is
			-- process the generate HTML docs message
		do
			cwin_post_message (item, generate_html_docs_msg, default_pointer, default_pointer)
		end

feature {COMPILER}
		
	process_compile (mode: INTEGER) is
			-- process melt compile system message
		do
			cwin_post_message (item, compile_msg, default_pointer, default_pointer + mode)
		end
		
end -- class MAIN_WINDOW
