indexing
	description: "Manager of registered document types."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_TYPE_MANAGER

feature -- Element Change

	register_document (a_type_name: STRING; a_class: DOCUMENT_CLASS) is
	        -- Register new document type
	   	require
	   	do
	   	 	registered_document_types.put (a_class, a_type_name)
	   	end	

feature -- Query

	known_document_type (a_type: STRING): BOOLEAN is
	        -- Is `a_type' a known document type?
	   	require
	   	do
			Result := registered_document_types.has (a_type)
	   	end		

feature -- Status Setting

	set_current_document_class (doc_class: like current_class) is
	        -- Update the current document class to reflect type of text loaded in text panel
	    do
	      	current_class_cell.replace (doc_class)
	    end	

feature -- Access

	current_class: DOCUMENT_CLASS is
			-- Current document class
		do
			Result := current_class_cell.item
		end

	registered_document_types: HASH_TABLE [DOCUMENT_CLASS, STRING] is
	        -- Hash of registered document class types and associated text scanners
	  	once
	  	    create Result.make (2)
	  	    Result.compare_objects
	  	end		

	default_document_class: DOCUMENT_CLASS is
	        -- Default text class
		once
			create Result.make ("Basic text", "txt", Void)
			register_document ("txt", Result)
			set_current_document_class (Result)
		end

feature {NONE} -- Implementation

	current_class_cell: CELL [DOCUMENT_CLASS] is
	        -- Cell containing active document class
		once
		    create Result
		end

end -- class DOCUMENT_TYPE_MANAGER
