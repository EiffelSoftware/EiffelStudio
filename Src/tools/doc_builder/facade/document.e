indexing
	description: "Documents."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT

inherit
	OBSERVED
	
	SHARED_OBJECTS
		undefine 
			copy,
			default_create
		end
	
	UTILITY_FUNCTIONS
		undefine 
			copy,
			default_create
		end
	
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		undefine 
			copy,
			default_create		
		end
		
create
	make_new,
	make_from_file

feature -- Creation

	make_new (a_name: STRING) is
			-- Make new document
		require
			a_name_not_void: a_name /= Void
		do
			initialize
			name := a_name
			create text.make_empty
		end
		
	make_from_file (a_file: PLAIN_TEXT_FILE) is
			-- Make from existing file
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do		
			name := a_file.name
			file := a_file
			read
			initialize
		ensure
			has_file: file /= Void
		end		
		
	initialize is
			-- Initialization
		do			
			create observers.make (2)
			create schema_validator
			create links.make (3)
			create invalid_links.make_empty ("Invalid links")		
			attach (Application_window)
		end

feature -- Access	
	
	name: STRING
			-- Name
			
	text: STRING
			-- Text			

feature -- File

	file: PLAIN_TEXT_FILE
			-- File on disk

feature --Validation

	error_report: ERROR_REPORT
			-- Validation error string
			
	is_valid_xml,
	is_valid_to_schema: BOOLEAN is
			-- Valid XML?		
		do
			Result := xml /= Void			
		end		
		
feature -- XML

	xml: DOCUMENT_XML is
			-- XML Document built from `text'.  Void if text is not valid.
		do
			Result := internal_xml
			if Result = Void or is_modified then				
				create Result.make_from_document (Current)
				if Result.valid then					
					internal_xml := Result
				else
					Result := Void
				end
			end
		end
			
	title: STRING is
			-- Document Title, Void if none or if Current is not valid xml.
		local
			l_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
		do
			if xml /= Void then
				l_element ?= xml.root_element
				if l_element /= Void then
					l_att := l_element.attribute_by_name ("title")
					if l_att /= Void then
						Result := l_att.value
					end
				end
			end
			if Result = Void then
				Result := (create {MESSAGE_CONSTANTS}).unknown_toc_title
			end
		ensure
			has_result: Result /= Void
		end
		
	output_filter_text: STRING is
			-- Document level output filter text (default: "all")
		local
			l_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
			l_value: STRING
		do
			if xml /= Void then
				l_element ?= xml.root_element
				if l_element /= Void then
					l_att := l_element.attribute_by_name ("output")
					if l_att /= Void then
						l_value := l_att.value
					end					
				end
			end
			if l_value = Void or l_value.is_equal ("all") then
				Result := "Unfiltered"
			elseif l_value.is_equal ("envision") then
				Result := "ENViSioN!"
			elseif l_value.is_equal ("studio") then
				Result := "EiffelStudio"
			end
		ensure
			has_result: Result /= Void
		end		
			
feature -- GUI
	
	widget: DOCUMENT_WIDGET is
			-- Widget
		do
			if internal_widget = Void then
				create internal_widget.make (Current)
			end
			Result := internal_widget
		end

	properties: DOCUMENT_PROPERTIES_DIALOG is
			-- Properties dialog for Current
		require
			is_valid_to_schema
		do
			create Result.make (Current)
		end		

feature -- Query

	is_modified: BOOLEAN
			-- Has current been modified since it was opened for editing?	
		
	do_update_link: BOOLEAN
			-- Can links in Current be updated?

	can_display, can_transform: BOOLEAN is
			-- Can we display/transform Current based on `output_filter'?
		local
			l_doc_filter, l_curr_filter: STRING
		do
			l_doc_filter := output_filter_text
			l_curr_filter := Shared_project.filter_manager.filter.description
			
			Result := 
						-- Application defines no filtering
				l_curr_filter.is_equal ("Unfiltered") or
						-- Document defines no filtering
				l_doc_filter.is_equal ("Unfiltered") or			
						-- Application level filterinf matches document level filter type
				l_curr_filter.is_equal (l_doc_filter)				
		end	

	is_persisted: BOOLEAN is
			-- Is document persisted to physical disk?
		do
			Result := file /= Void and then file.exists
		end
	
feature -- Status Setting

	add_link (a_url: DOCUMENT_LINK) is
			-- Add `a_url' to list of links
		require
			url_not_void: a_url /= Void
		do
			links.extend (a_url)
		end		
	
	change_name (a_new_name: STRING) is
			-- Change name of current on disk to `a_new_name'
		local
			l_dir: FILE_NAME
		do
			if is_persisted then
				create file.make (name)
				file.delete
				create l_dir.make_from_string (directory_no_file_name (name))
				l_dir.extend (a_new_name)
				name := l_dir.string
			else
				name := a_new_name
			end
			set_modified (True)
		end	
		
	set_modified (flag: BOOLEAN) is
			-- Set current to indicate it has been modified by user and
			-- notify observers of change
		do
			is_modified := flag
			Shared_document_manager.add_modified_document (Current)
			notify_observers
		end

	set_text (a_text: STRING) is
			-- Set `text'
		do
			text := a_text
			set_modified (True)
		end

	save is
			-- Save `text' to disk
		local
			l_save_dialog: EV_FILE_SAVE_DIALOG
		do
			if not is_persisted then
				create l_save_dialog
				l_save_dialog.show_modal_to_window (Application_window)
				if l_save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
					internal_save (l_save_dialog.file_name)
				end
			else
				internal_save (name)
			end
			Application_window.update_toolbar
		end	

feature {DOCUMENT_LINK, LINK_MANAGER} -- Links
	
	links: ARRAYED_LIST [DOCUMENT_LINK]
			-- Links in Current	

	invalid_links: ERROR_REPORT
			-- Invalid link errors	

	check_links is
			-- Check links.  Put invalid links into `invalid_links'.
		require
			valid_xml: is_valid_xml
			is_persisted: is_persisted
		local
			l_formatter: XM_DOCUMENT_FORMATTER
		do
			if invalid_links /= Void then
				invalid_links.clear	
			end
			create l_formatter.make_with_document (Current)
			l_formatter.process_document (xml)
			if not links.is_empty then
				create invalid_links.make_empty ("Invalid Links")
				from
					links.start
				until
					links.after
				loop
					if not links.item.exists then
						invalid_links.append_error ("File: " + name + " (Url: " + links.item.url + ")", 0, 0)
					end
					links.forth
				end
			end
		end

	update_link (a_old, a_new: DOCUMENT_LINK) is
			-- Update all links in Current to `a_old' to link to `a_new'
		require
			old_link_not_void: a_old /= Void
			new_link_not_void: a_new /= void
		local
			l_formatter: XM_DOCUMENT_FORMATTER
		do
			do_update_link := True
			create l_formatter.make_with_document (Current)
			l_formatter.set_links (a_old, a_new)
			l_formatter.process_document (xml)
			save_xml_document (xml, create {FILE_NAME}.make_from_string (name))
			do_update_link := False
		end			

	set_links_relative is
			-- Set all links in Current to relative links
		do			
		end
		
	set_links_absolute is
			-- Set all links in Current to absolute links
		do			
		end

feature {NONE} -- Implementation

	read is
			-- Read `file' and put result in `text'
		require
			persisted: is_persisted
		do			
			file.open_read
			file.read_stream (file.count)
			text := file.last_string
			file.close			
		end

	internal_xml: like xml
			-- Internal XML
			
	internal_widget: like widget
			-- Widget
			
	schema_validator: SCHEMA_VALIDATOR
			-- Schema Validator

	internal_save (a_filename: STRING) is
			-- Save with `a_filename'
		do
			if not is_persisted then
				name := a_filename
			end
			write_to_disk
		end		

	write_to_disk is
			-- Write Current text to disk
		do			
			if file /= Void and then not file.is_closed then
				file.close
			end
			create file.make_open_write (name)
			if file.is_open_write then
				file.putstring (text)
				file.flush
				file.close
				set_modified (False)
			end
		end

invariant
	has_name: name /= Void
		
end -- class DOCUMENT
