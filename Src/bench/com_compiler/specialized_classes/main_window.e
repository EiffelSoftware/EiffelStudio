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
		local
			called: BOOLEAN
		do
			inspect msg
			when generate_html_docs_msg then
				check
					non_void_html_document_generator: html_document_generator /= Void
				end
				html_document_generator.item.generate_docs
				Result := 0
			when compile_melt_msg then
				check
					non_void_compiler: compiler /= Void
				end
				compiler.item.compile
				Result := 0
			when compile_finalize_msg then
				check
					non_void_compiler: compiler /= Void
				end
				compiler.item.finalize
				Result := 0
			when compile_precompile_msg then
				check
					non_void_compiler: compiler /= Void
				end
				compiler.item.precompile
				Result := 0
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

feature {HTML_DOC_GENERATOR}

	process_generate_message is
			-- process the generate HTML docs message
		local
			l_res: INTEGER
		do
			cwin_post_message (item, generate_html_docs_msg, 0, 0)
		end

feature {COMPILER}
		
	process_compile is
			-- process melt compile system message
		do
			cwin_post_message (item, compile_melt_msg, 0, 0)
		end
		
	process_finalize is
			-- process finalize compile system message
		do
			cwin_post_message (item, compile_finalize_msg, 0, 0)
		end
		
	process_precompile is
			-- process precompile compile system message
		do
			cwin_post_message (item, compile_precompile_msg, 0, 0)
		end

end -- class MAIN_WINDOW
