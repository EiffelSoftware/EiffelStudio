class CLASS_C_PLUS

creation 
	make

feature -- initialization

	make (cl : CLASS_DATA; text_area: TEXT_AREA) is
	do
		class_data := cl
		text := TEXT_AREA
	end

feature {NONE} -- properties

	class_data : CLASS_DATA

	text : TEXT_AREA

feature -- commands

 	generate is
	do		
		generate_arguments

		
		text.append_keyword("class")
		text.append_space
		generate_name
	    
		if  class_data.heir_links /= Void  and then not class_data.heir_links.empty then 
			generate_inheritance
		end
		text.new_line
		text.append_string("{") 
        text.new_line    
  	  generate_feature_list
  	      
  	  text.append_string("}")    
    end    	    

	generate_features is do end

	generate_feature_list  is
            -- Generate the feature names 
        local
            feat: FEATURE_CLAUSE_DATA;
			feat_list : FEATURE_CLAUSE_LIST
        do
            feat_list := class_data.feature_clause_list
			text.indent;
            from
                feat_list.start
            until
                feat_list.after
            loop
				feat_list.item.generate_c(text,FALSE)
                feat_list.forth
            end;
            text.exdent;
            text.new_line;
        end;
    


    generate_inheritance is
    local
        link_data:LINKABLE_DATA
    do
    	text.append_string(": public ")
        from 
    		class_data.heir_links.start
        until
    		class_data.heir_links.after
        loop
     	   link_data := class_data.heir_links.item.parent
            class_data.heir_links.forth
            link_data.generate_name ( text)    
            if not class_data.heir_links.after
                then text.append_string(", ")
            end
        end
    end
        

    generate_name is
    do
        text.append_clickable_string(class_data.stone,class_data.name)
    end

    generate_arguments is
    do
        if not class_data.generics.empty then
            from 
    			text.append_string ("Template < ")
                class_data.generics.start
            until
    			class_data.generics.after    
            loop
     		   class_data.generics.item.generate ( text, class_data )
                class_data.generics.forth
                if not class_data.generics.after then
                        text.append_string (", ")
                end
      	  end
      	  text.append_string(" > ")
			text.new_line
		end
	end

end
