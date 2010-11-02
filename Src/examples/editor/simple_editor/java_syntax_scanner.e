note
	description: "Summary description for {JAVA_SYNTAX_SCANNER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_SYNTAX_SCANNER

inherit
	EDITOR_SYNTAX_SCANNER
		redefine
			do_a_token
		end

create
	make

feature -- Actions

	do_a_token (a_token: TOKEN)
			-- Handle `read_token'.
		local
			l_token: detachable EDITOR_TOKEN
    	do
    		if a_token.type > 0 then
    			l_token := java_token_builder.build_token (a_token)
    			if l_token /= Void then
		    		token_list.extend (l_token)
    			end
    		end
    	end

feature {NONE} -- Implementation

	java_token_builder: JAVA_TOKEN_BUILDER
	        -- Build of editor tokens
	  	once
	  	    create Result
	  	end

end
