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

	process_message (hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
			-- Was declared in WEL_COMPOSITE_WINDOW as synonym of `composite_process_message'.
		do
			inspect msg
			when generate_html_docs_msg then
				check
					non_void_html_document_generator: html_document_generator /= Void
				end
				html_document_generator.item.generate_docs
				Result := 0
			when compile_msg then
				check
					non_void_compiler: compiler /= Void
				end
				compiler.item.compile (lparam)
				Result := 0
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

feature {HTML_DOC_GENERATOR}

	process_generate_message is
			-- process the generate HTML docs message
		do
			cwin_post_message (item, generate_html_docs_msg, 0, 0)
		end

feature {COMPILER}
		
	process_compile (mode: INTEGER) is
			-- process melt compile system message
		do
			cwin_post_message (item, compile_msg, 0, mode)
		end
		
end -- class MAIN_WINDOW
