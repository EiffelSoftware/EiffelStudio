indexing
	description: "Shared compiler properties"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PROJECT_PROPERTIES
	
feature -- Access

	html_document_generator: CELL [HTML_DOC_GENERATOR] is
			-- html document generator for a project
		once
			create Result.put (Void)
		end
		
	compiler: CELL [COMPILER] is
			-- compiler for project
		once
			create Result.put (Void)
		end
		
	main_window: MAIN_WINDOW is
			-- main windows for server
		once
			create Result.make_top ("Should not see me!")
		end
		
	generate_html_docs_msg: INTEGER is 0x500
			-- generate html docs message
			
	compile_melt_msg: INTEGER is 0x501
			-- melt compile system message

	compile_finalize_msg: INTEGER is 0x502
			-- finalize compile system message
			
	compile_precompile_msg: INTEGER is 0x503
			-- precompile compile system message
		
feature -- Status Setting

	set_html_document_generator (a_generator: HTML_DOC_GENERATOR) is
			-- set 'html_document_generator' cell item with 'a_generator'
		require
			non_void_generator: a_generator /= Void
		do
			html_document_generator.put (a_generator)
		end
		
	set_compiler (a_compiler: COMPILER) is
			-- set 'compile' cell item with 'a_compiler'
		require
			non_void_compiler: a_compiler /= Void
		do
			compiler.put (a_compiler)
		end
		

end -- class SHARED_PROJECT_PROPERTIES
