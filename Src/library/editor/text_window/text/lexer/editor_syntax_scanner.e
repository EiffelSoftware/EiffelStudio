indexing
	description: "Basic text scanner for applying syntax highlighting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_SYNTAX_SCANNER

inherit
	SCANNING
		rename
			make as scanning_make
		redefine
		    do_a_token,
		    begin_analysis,
		    end_analysis,
		    store_analyzer,
		    build
		end
		
	EDITOR_BASIC_SCANNER
		rename
		    case_diff as ut_case_diff,
		    make as make_editor_scanner
		undefine
		    is_equal,
		    copy		
		redefine
		    execute		    
		end
	
create 
	make

feature -- Creation

	make (syntax_file: STRING) is
			-- Create a lexical analyser to analyze text according to the rules in `syntax_file'.
		require
		    file_not_void: syntax_file /= Void
		do			
			token_list.wipe_out
			scanning_make
			build (syntax_file + "_bin", syntax_file)		
		end
		
feature -- Actions

	build (store_file_name, grammar_file_name: STRING) is
			-- Create a lexical analyzer.
			-- If `store_file_name' is the name of an existing file,
			-- use analyzer stored in that file.
			-- Otherwise read grammar from `grammar_file_name',
			-- create an analyzer, and store it in `store_file_name'.
		do
			build_from_grammar (store_file_name, grammar_file_name)			
		end; 

	store_analyzer (file_name: STRING) is
			-- Store `analyzer' in file named `file_name'.
			-- This is overridden feature does NOT store to disk in `file_name', only to memory.
		do
			if analyzer = Void then
				create analyzer.make
			end
		end

	execute (a_string: STRING) is
			-- Analyze a string.		
		require else
		   	has_analyzer: analyzer /= Void	
		do						
			from					
				first_token := Void
				end_token := Void
				token_list.wipe_out
				analyzer.set_string (a_string)
				begin_analysis
			until
				analyzer.end_of_text
			loop
				analyzer.get_any_token
				do_a_token (analyzer.last_token)
			end	
			end_analysis
		end
		
	do_a_token (a_token: TOKEN) is
			-- Handle `read_token'.
		local
			l_token: EDITOR_TOKEN
    	do    		
    		if a_token.type > 0 then    			
    			l_token := token_builder.build_token (a_token)
    			if l_token /= Void then    				
		    		token_list.extend (l_token)			
    			end
    		end
    	end
    	
    begin_analysis is
    		-- Redefined just so no put_string's are called
    	do    		
    	end    	
    	
    end_analysis is
            -- End of analysis
        local
            l_prev_token: EDITOR_TOKEN
      	do
      	 	if not token_list.is_empty then	  	   		
	  	   		first_token := token_list.first
	  	   		end_token := token_list.last
      	   		from
      	   	        token_list.start
      	   	    until
      	   	        token_list.after
      	   	    loop
      	   	    	if l_prev_token /= Void then
      	   	    	    l_prev_token.set_next_token (token_list.item)
      	   	    	    token_list.item.set_previous_token (l_prev_token)
      	   	    	end
      	   	        l_prev_token := token_list.item
      	   	        token_list.forth      	   	        
      	   	    end      	   	     
      	   	end
      	end    	
    	
feature {NONE} -- Implementation

	token_list: ARRAYED_LIST [EDITOR_TOKEN] is
			-- List of EDITOR_TOKENs corresponding to analyzed list of lexer TOKENs from input string
		once
		    create Result.make (5)
		end

	token_builder: TOKEN_BUILDER is
	        -- Build of editor tokens
	  	once
	  	    create Result
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




end -- class EDITOR_SYNTAX_SCANNER
