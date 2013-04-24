note
	description: "Manager of registered document types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_TYPE_MANAGER

feature -- Element Change

	register_document (a_type_name: STRING; a_class: DOCUMENT_CLASS)
	        -- Register new document type
	   	require
	   	do
	   	 	registered_document_types.put (a_class, a_type_name)
	   	end

feature -- Query

	known_document_type (a_type: READABLE_STRING_GENERAL): BOOLEAN
	        -- Is `a_type' a known document type?
	   	do
			Result := registered_document_types.has (a_type.as_lower.as_string_32)
			if not Result then
				debug ("editor")
					print ("unknown document type")
				end
			end
	   	end

	get_class_from_type (a_type: READABLE_STRING_GENERAL): DOCUMENT_CLASS
			-- Get the document class from the type
		require
			known_type: known_document_type (a_type)
		local
			l_result: detachable DOCUMENT_CLASS
		do
			l_result := registered_document_types.item (a_type.as_lower.as_string_32)
			check l_result /= Void end -- Implied by precondition
			Result := l_result
		ensure
			has_result: Result /= Void
		end

	current_class_set: BOOLEAN
			-- Is `current_class' set?
		do
			Result := current_class_cell.item /= Void
		end

feature -- Status Setting

	set_current_document_class (doc_class: like current_class)
	        -- Update the current document class to reflect type of text loaded in text panel
	    do
	      	current_class_cell.replace (doc_class)
	    end

feature -- Access

	current_class: DOCUMENT_CLASS
			-- Current document class
		require
			current_class_set: current_class_set
		local
			l_class: detachable like current_class
		do
			l_class := current_class_cell.item
			check l_class /= Void end -- Implied by precondition.
			Result := l_class
		end

	default_document_class: DOCUMENT_CLASS
	        -- Default text class
		once
			create Result.make ("Basic text", "txt", Void)
			register_document ("txt", Result)
			set_current_document_class (Result)
		end

feature {NONE} -- Implementation

	registered_document_types: HASH_TABLE [DOCUMENT_CLASS, STRING_32]
	        -- Hash of registered document class types and associated text scanners
	  	once
	  	    create Result.make (2)
	  	    Result.compare_objects
	  	end

	current_class_cell: CELL [detachable DOCUMENT_CLASS]
	        -- Cell containing active document class
		once
		    create Result.put (Void)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DOCUMENT_TYPE_MANAGER
