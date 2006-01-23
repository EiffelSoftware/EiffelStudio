indexing
	description: "Document class information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_CLASS

create
    make

feature -- Creation

	make (a_name, a_filetype, a_syntax_definition_file: STRING) is
	        -- Make new document class with `a_filetype'
	   	require
	   	    filetype_not_void: a_filetype /= Void
	   	    filetype_valid: not a_filetype.is_empty	
	  	do
	  		name := a_name
	  		create filetypes.make (2)
	  		filetypes.compare_objects
	  		filetypes.extend (a_filetype)
	  		syntax_definition := a_syntax_definition_file
	  		initialize_scanner
	  	ensure
	  	    has_filetype: filetypes.has (a_filetype)
	  	end

feature -- Initialization

	initialize_scanner is
	        -- Initialize `scanner'.  A scanner will be built from the syntax definition file.  If this fails a simple
	        -- default text scanner will be used.  To use a custom scanner override with `set_scanner'.
	    local
	        l_error: BOOLEAN
	  	do
	  		if syntax_definition /= Void then		  		
		  		if (create {PLAIN_TEXT_FILE}.make (syntax_definition)).exists then
    	  		    l_error := parse_syntax_file (syntax_definition)			
    			else
    			    l_error := True
    	  		end
    	  	else
    	  	    l_error := True
    	  	end
	  		if l_error then
	  			scanner := basic_lexer	    
	  		end
	  	ensure
	  	    scanner_not_void: scanner /= Void
	  	end		

feature -- Access

	name: STRING
			-- Name description

	syntax_definition: STRING
			-- Name of file containing syntax definition

	scanner: EDITOR_SCANNER
			-- Scanner

feature -- Query

	known_filetype (a_type: STRING): BOOLEAN is
	        -- 
		do		   
			Result := filetypes.has (a_type) 
		end
		
feature -- Status setting

	set_scanner (a_scanner: like scanner) is
	        -- Set `scanner'.  This can be used to override using the generic scanner.
	    require
	        scanner_not_void: scanner /= Void
	 	do
	 	    scanner := a_scanner
	 	ensure
	 	    scanner_set: scanner = a_scanner
	 	end		

feature -- Element change

	add_file_type (a_type: STRING) is
	        -- Add new type to associate with this class
	  	require
	  	    type_not_void: a_type /= Void
	  	   	type_not_known: not known_filetype (a_type)
	  	do
	  	    filetypes.extend (a_type)
	  	ensure
	  	    type_known: known_filetype (a_type)
	  	end		
	  	
	remove_file_type (a_type: STRING) is
	        -- Remove type
	  	require
	  	    type_not_void: a_type /= Void
	  	   	type_known: known_filetype (a_type)
	  	do
	  	    filetypes.prune (a_type)
	  	ensure
	  	    type_not_known: not known_filetype (a_type)
	  	end	

feature {NONE} -- Parsing

	parse_syntax_file (a_syn_file: STRING): BOOLEAN is
	        -- To implement.  Return True if there is an error.
	   	local
	   	    l_syntax: EDITOR_SYNTAX_SCANNER
   	 	do
	   		create l_syntax.make (a_syn_file)
	   		scanner := l_syntax
			l_syntax.analyze (a_syn_file)
	   		Result := l_syntax.analyzer = Void
	   	end		

feature {NONE} -- Implementation

	filetypes: ARRAYED_LIST [STRING]
			-- Filetypes using this document class

	basic_lexer: EDITOR_BASIC_SCANNER is
			-- Basic default text lexer
		once
			create Result.make
		end

invariant
	has_at_least_one_filetype: not filetypes.is_empty

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




end -- class DOCUMENT_CLASS
