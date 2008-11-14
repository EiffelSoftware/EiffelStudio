indexing
	description: "Manager of registered document types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	   	local
	   		l_type: STRING
	   	do
	   		l_type := a_type.twin
	   		l_type.to_lower
			Result := registered_document_types.has (l_type)
			if not Result then
				debug ("editor")
					print ("unknown document type")
				end
			end
	   	end

	get_class_from_type (a_type: STRING): DOCUMENT_CLASS is
			-- Get the document class from the type
		require
			known_type: known_document_type (a_type)
		local
			l_type: STRING
		do
			l_type := a_type.twin
			l_type.to_lower
			Result := registered_document_types.item (l_type)
		ensure
			has_result: Result /= Void
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

	default_document_class: DOCUMENT_CLASS is
	        -- Default text class
		once
			create Result.make ("Basic text", "txt", Void)
			register_document ("txt", Result)
			set_current_document_class (Result)
		end

feature {NONE} -- Implementation

	registered_document_types: HASH_TABLE [DOCUMENT_CLASS, STRING] is
	        -- Hash of registered document class types and associated text scanners
	  	once
	  	    create Result.make (2)
	  	    Result.compare_objects
	  	end

	current_class_cell: CELL [DOCUMENT_CLASS] is
	        -- Cell containing active document class
		once
		    create Result.put (Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DOCUMENT_TYPE_MANAGER
