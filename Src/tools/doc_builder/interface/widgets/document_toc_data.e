indexing
	description: "Table of contents meta data for associated node."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_TOC_DATA

inherit	
	XML_ROUTINES
	
	UTILITY_FUNCTIONS
		undefine
			copy,
			is_equal
		end
	
	SHARED_CONSTANTS
		undefine
			copy,
			is_equal
		end

create
	make,
	make_with_title

feature -- Creation
		
	make (a_title, a_location, a_filename: STRING) is
			-- Create
		require
			title_not_void: a_title /= Void
			location_not_void: a_location /= Void
			filename_not_void: a_filename /= Void
		do
			title := a_title
			toc_location := a_location
			filename := a_filename
		end		

	make_with_title (a_title: STRING) is
			-- Make with `a_title'
		require
			title_not_void: a_title /= Void
		do
			title := a_title				
		end		

feature -- Access

	document: DOCUMENT
			-- Document

	title: STRING
			-- The title Current should use
		
	toc_location: STRING
			-- Full location of Current in TOC, NOT including file name. E.g `C:\A_dir\a_subdir'
	
	filename: STRING
			-- File name of file associated with Current, including path. E.g `C:\A_dir\a_subdir\file.xml'
		
	relative_location: STRING is
			-- Location of Current relative to project
		do
			Result := file_no_extension (filename.substring 
				(document.Shared_project.root_directory.out.count + 1, filename.count))
		end		
		
	real_location: STRING is
			-- The real physical location from which Current is constructed, excluding
			-- filename. E.g `C:\A_dir\a_subdir'
		do
			Result := directory_no_file_name (filename)
		end
		
feature -- Query

	is_parent_node: BOOLEAN is
			-- Is Current a parent, i.e. is an index file?
		do
			Result := file_no_extension (short_name (filename)).is_equal (Application_constants.index_file_name)
		end		

	is_toc_location_same_as_physical: BOOLEAN is
			-- Is the hierarchical location for `document' in the TOC the same as 
			-- the physical hierarchical structure on disk?
		do
			Result := real_location.is_equal (toc_location)
		end	

feature -- Status Setting

	set_document (a_doc: DOCUMENT) is
			-- Set with `a_doc'
		do
			document := a_doc			
		end

invariant
	has_title: title /= Void

end -- class DOCUMENT_TOC_DATA
