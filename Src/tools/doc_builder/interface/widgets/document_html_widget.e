indexing
	description: "HTML browser"
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_HTML_WIDGET

inherit
	OBSERVER
		undefine
			copy, default_create
		end
	
		-- To change to Microsoft Browser ASAP
	EV_TEXT
	
	SHARED_OBJECTS
		undefine
			copy, default_create
		end

create
	make
	
feature -- Creation

	make (a_document: DOCUMENT) is
			-- Make Current with `text'
		require
			document_not_void: a_document /= Void
		do
			default_create
			document := a_document
			document.attach (Current)
			filterer := Shared_project.filter_manager
			should_update := True
		ensure
			has_document: document /= Void
			has_filterer: filterer /= Void
		end

feature -- Commands

	build_html is
			-- Build html out of `document'
		local
			l_generator: HTML_GENERATOR
			l_dir: DIRECTORY
		do
			if is_updated then				
				create l_generator
				create l_dir.make (Shared_constants.Application_constants.Temporary_html_directory)
				l_generator.generate_file (document, l_dir)
--				filterer.filter_document (document)
--				set_text (filterer.filter.output_string)
			end			
		end		

feature -- Implementation

	is_updated: BOOLEAN
			-- Has Current been updated

	document: DOCUMENT
			-- Associated document

feature {OBSERVED} -- Observer Pattern

	update is
			-- Update Current
		do
			is_updated := True
		end

feature {NONE} -- Observer
		
	update_subject is
			-- Update subject of change so it may update its observers
		do			
		 	should_update := False
			 		-- Here shall convert `output_string' to XML, then write back to XML
			should_update := True
		end		

	filterer: FILTER_MANAGER
			-- Filter tool

invariant
	has_document: document /= Void
	has_filterer: filterer /= Void

end -- class DOCUMENT_HTML_WIDGET
