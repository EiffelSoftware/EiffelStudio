indexing
   description: "Class for parsing XML documents"
   status: "See notice at end of class."
   author: "Andreas Leitner"

class
   EXPAT_EVENT_PARSER

inherit
   XML_EVENT_PARSER_I

   EXPAT_NP

   XML_ERROR_CODES

   KL_IMPORTED_STRING_ROUTINES

   KL_IMPORTED_INPUT_STREAM_ROUTINES
   KL_IMPORTED_STRING_BUFFER_ROUTINES

   C_STRING_HELPER
   

creation
   make

feature {NONE}  -- Initialisation
   make is
      do
	 initialize
	 -- the '|' character will be used to seperate uris from
	 -- elements names. (Does '|' have any complications?)
--	 item := parser_create_ns (default_pointer,'|')
	 item := parser_create (default_pointer)

	 exml_register_start_end_tag_hook (item)
	 exml_register_start_end_namespace_decl_hook (item)
	 exml_register_content_hook (item)
	 exml_register_processing_instruction_hook (item)
	 --	exml_register_default_hook (item)
	 -- registering the default hook, prevents the parser
	 -- from expanding internal  entity-references
	 exml_register_unparsed_entity_declaration_hook (item)
	 exml_register_notation_declaration_hook (item)
	 exml_register_external_entity_reference_hook (item)
	 exml_register_unknown_encoding (item)
	 exml_register_comment_hook (item)

	 set_eiffel_object_as_user_data
      end

feature {ANY} -- Access
   
   is_incremental: BOOLEAN is True
   
   source: XML_SOURCE
	 -- source of the xml document beeing parserd.
	 -- if void the source is unkown.
   
feature {ANY} -- Element change
   set_source (a_source: XML_SOURCE) is
	 -- set the source of the xml document to parse.
      do
	 source := a_source
      end

   
feature {ANY} -- Parsing   
   
   parse_from_file_name (a_file_name: UCSTRING) is
	 -- Parse XML Document from file
      local
	 in_file: like INPUT_STREAM_TYPE
      do
	 !EXPAT_URI_SOURCE! source.make (a_file_name)
	 in_file := INPUT_STREAM_.make_file_open_read (a_file_name.to_utf8)
	 check
	    file_is_open: INPUT_STREAM_.is_open_read (in_file)
	 end
	 parse_from_stream (in_file)
	 INPUT_STREAM_.close (in_file)
      end
   
   parse_from_stream (a_stream: like INPUT_STREAM_TYPE) is
      do
	 parse_incremental_from_stream (a_stream)
	 set_end_of_document
      end
   
   parse_from_string_buffer (a_buffer: like STRING_BUFFER_TYPE) is
      do
	 parse_incremental_from_string_buffer (a_buffer)
      end
   
   parse_from_string (a_string: STRING) is
      do
	 parse_incremental_from_string (a_string)
	 set_end_of_document
      end
   
   
   
feature {ANY} -- Incremental Parsing
   
   parse_incremental_from_stream (a_stream: like INPUT_STREAM_TYPE) is
	 -- Parse partial XML document from GOBO input stream.
	 -- After the last part of the data has been fed into the parser,
	 -- call set_end_of_document to get any pending error messages.
      local
	 a_string: STRING
	 nc: INTEGER
      do
	 from
	 until
	    INPUT_STREAM_.end_of_input (a_stream)
	 loop
	    a_string := STRING_.make_buffer (read_block_size)
	    nc := INPUT_STREAM_.read_stream (a_stream, a_string, 1, read_block_size)
	    parse_incremental_from_string (a_string)
	 end
      end

   parse_incremental_from_string_buffer (a_buffer: like STRING_BUFFER_TYPE) is
      do
	 if
	    parse_buffer_imp (a_buffer) = 0
	    -- function call with side effect !!!!
	    -- returns 0 on error
	 then
	   last_error := Xml_err_unknown
	   last_internal_error := get_error_code (item)
	 end
      end
   
   
   parse_incremental_from_string (data: STRING) is
      do
	 if
	    parse_string_imp (data) = 0
	    -- function call with side effect !!!!
	    -- returns 0 on error
	 then
	   last_error := Xml_err_unknown
	   last_internal_error := get_error_code (item)
	 end
      end

   set_end_of_document is
      local
	 int_result: INTEGER
      do
	 int_result := parse (item, default_pointer, 0, 1)
	    -- function call with side effect !!!!
	    -- returns 0 on error
	 if
	    int_result = 0
	  then
	    last_error := Xml_err_unknown
	    last_internal_error := get_error_code (item)
	 end
      end

feature {ANY} -- Status
   last_error: INTEGER

   last_error_description: STRING is
      do
	 Result := make_string_from_c_zero_terminated_string (error_string (last_internal_error))
      end

   last_line_number: INTEGER is
      do
	 Result := get_current_line_number (item) + 1
      end

   last_column_number: INTEGER is
      do
	 Result := get_current_column_number (item) + 1
      end

   last_byte_index: INTEGER is
      do
	 Result := get_current_byte_index (item) + 1
	 -- for some reason expat sometimes gives me -1.
	 -- this is a dirty hack and should be removed as
	 -- soon as the problem is understood (help, anybody?)
	 if
	    Result <= 0
	  then
	    Result := 1
	 end
      end

   position: XML_POSITION is
      do
	 !EXPAT_POSITION! Result.make (source, last_byte_index, last_column_number, last_line_number)
      end

   file_name: UCSTRING
	 -- currently parsed file. If information is not available or
	 -- data does not origin from a file, this is void

feature {NONE} -- Implementation   
   
   read_block_size: INTEGER is 10240
	 -- 10 kB
   
feature {NONE} -- (low level) frozen callbacks (called from eXML clib)

   last_internal_error: INTEGER
	 -- Expat specific error code

   frozen on_start_tag_procedure (tag_name_ptr, attribute_specifications_ptr: POINTER) is
      local
	 name: UCSTRING
	 ns_prefix: UCSTRING
	 att_list: DS_BILINKED_LIST [DS_PAIR [DS_PAIR[UCSTRING, UCSTRING], UCSTRING]]
      do
	 name := make_ucstring_from_c_utf8_zero_terminated_string (tag_name_ptr)
	 create ns_prefix.make (0)
	 extract_name_and_prefix_from_name (name, ns_prefix)
	 att_list := make_attribute_list_from_c (attribute_specifications_ptr)
	 on_start_tag (name, ns_prefix, att_list)
      end

   frozen on_end_tag_procedure (tag_name_ptr: POINTER) is
      local
	 name: UCSTRING
	 ns_prefix: UCSTRING
      do
	 name := make_ucstring_from_c_utf8_zero_terminated_string (tag_name_ptr)
	 create ns_prefix.make (0)
	 extract_name_and_prefix_from_name (name, ns_prefix)
	 on_end_tag (name, ns_prefix)
      end

   frozen on_start_namespace_decl_procedure (prefix_ptr, uri_ptr: POINTER) is
--      local 
--	 expat_name_space: EXPAT_NAMESPACE
--	 name_space: XML_NAME_SPACE
      do
--	 !! expat_name_space.make_from_c (prefix_ptr, uri_ptr)
--	 !! name_space.make_from_imp (expat_name_space)
--	 on_name_space_start_decl (name_space)
      end

   frozen on_end_namespace_decl_procedure (prefix_ptr: POINTER) is
--      local 
--	 expat_name_space: EXPAT_NAMESPACE
--	 name_space: XML_NAME_SPACE
--	 ns_prefix: UCSTRING
      do
--	 !! ns_prefix.make_from_utf8 (make_string_from_c_zero_terminated_string (prefix_ptr))
--	 look_up_name_space_from_c_ptr
--	 on_name_space_end_decl (name_space)
      end

   
   frozen on_content_procedure (chr_data_ptr: POINTER; len: INTEGER) is
      local
	 chr_data: UCSTRING
      do
	 chr_data := make_ucstring_from_c_utf8_runlength_string (chr_data_ptr, len)
	 on_content (chr_data)
      end

   frozen on_processing_instruction_procedure (target_ptr, data_ptr: POINTER) is
      local
	 target, data: UCSTRING
      do
	 target := make_ucstring_from_c_utf8_zero_terminated_string_safe (target_ptr)
	 data := make_ucstring_from_c_utf8_zero_terminated_string_safe (data_ptr)
	 on_processing_instruction (target, data)
      end

   frozen on_default_procedure (data_ptr: POINTER; len: INTEGER) is

      local
	 chr_data: UCSTRING
      do
	 !! chr_data.make_from_utf8 (make_string_from_c_runlength_string (data_ptr, len))
	 --on_default (chr_data)
      end

   frozen on_notation_declaration_procedure (notation_name, base, system_id, public_id: POINTER) is
      do

	 print ("found notation_declaration (Not yet implemented)%N")
	 -- TODO: Don't really know yet. If you know please let me know too (:
      end

   frozen on_external_entity_reference_procedure (context_ptr, base_ptr, system_id_ptr, public_id_ptr: POINTER): INTEGER is
	 -- return zero if parsing of external entity was not successfull
	 -- 'base' is a char* pointing to data previously set with 'set_base'
--      local
--	 expat_ext_ent_ref: EXPAT_EXTERNAL_ENTITY_REF
--	 ext_ent_ref: XML_EXTERNAL_ENTITY_REF
      do
--  	 !! expat_ext_ent_ref.make_from_c (context_ptr, base_ptr, system_id_ptr, public_id_ptr)
--  	 !! ext_ent_ref.make_from_imp (expat_ext_ent_ref)
--  	 on_external_entity_ref (ext_ent_ref)
  	 Result := 1
	 
	 
	 
	 -- TODO: don't create 2 references for one entity (use a 
	 -- parser global pool)
	 
	 --	 external_entity_manager.find_or_create_ref_from_c (context_ptr, base_ptr, system_id_ptr, public_id_ptr)
	 
--	 print ("found external_entity_reference (Not yet implemented)%N")
--	 print ("context:")
--  	 if 
--  	    open_entity_name /= default_pointer
--  	  then
--  	    s := make_string_from_c_zero_terminated_string (open_entity_name)
--  	 else
--  	    s := "";
--  	 end
--  	 print (s)
--  	 print ("%N")
--  	 print ("base:")
--  	 if
--  	    base /= default_pointer
--  	  then
--  	    s := make_string_from_c_zero_terminated_string (base)
--  	 else
--  	    s := ""
--  	 end
--  	 print (s)
--  	 print ("%N")
--  	 print ("sys_id:")
--  	 if
--  	    system_id /= default_pointer
--  	  then
--  	    s := make_string_from_c_zero_terminated_string (system_id)
--  	 else
--  	    s := ""
--  	 end
	    
--  	 print (s)
--  	 print ("%N")
--  	 print ("pub_id:")
--  	 if
--  	    public_id /= default_pointer
--  	  then
--  	    s := make_string_from_c_zero_terminated_string (public_id)
--  	 else
--  	    s := ""
--  	 end
--  	 print (s)
--  	 print ("%N")
--  	 Result := 1
	 
	 -- TODO: Well,, I guess I need to start another parser here - always?
	 -- maybe this should be configurable
	 -- anyway there needs to be some expat stuff encapsulated first (XML_ExternalEntityParserCreate)
	 -- this function is used to create a parse, that parses those external references.
	 -- I assume this will be a heir from XML_PARSER.
      end
   
   frozen on_unparsed_entity_declaration_procedure (enitity_name, base, system_id, public_id, notation_name: POINTER) is
      do
	 print ("found unparsed_entity_declaration (HELP!!!)%N")
	 -- TODO: Don't really know yet. If you know please let me know too (:

      end
   
   
   frozen on_unknown_encoding_procedure (a_name, a_info: POINTER): INTEGER is
      do
	 print ("found unknown_encoding (HELP!!! - What shall I do?)%N")
	 -- TODO: Don't really know yet. If you know please let me know too (:
      end

   frozen on_comment_procedure (data_ptr: POINTER) is
	 -- data is a 0 terminated C string
      local
	 comment: UCSTRING
      do
	 comment := make_ucstring_from_c_utf8_zero_terminated_string (data_ptr)
	 on_comment (comment)
      end
feature {NONE} -- Implementation
   
   make_attribute_list_from_c (attr_spec_ptr: POINTER) : DS_BILINKED_LIST [DS_PAIR[DS_PAIR [UCSTRING, UCSTRING], UCSTRING]] is
      require
	 ptr_not_void: attr_spec_ptr /= Void
      local
	 a_name: UCSTRING
	 a_prefix: UCSTRING
	 a_value: UCSTRING
	 ptr1, ptr2: POINTER
	 pair1: DS_PAIR [UCSTRING, UCSTRING]
	 pair2: DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]
      do
	 !! Result.make

	 -- dirty C to Eiffel converstion

	 ptr1 := attr_spec_ptr
	 from
	    ptr2 := ptr_contents (ptr1)
	 until
	    ptr2 = default_pointer
	 loop
	    create a_name.make_from_utf8 (make_string_from_c_zero_terminated_string (ptr2))
	    create a_prefix.make (0)
	    extract_name_and_prefix_from_name (a_name, a_prefix)
	    ptr2 := ptr_contents (ptr_move (ptr1, 1))

	    create a_value.make_from_utf8 (make_string_from_c_zero_terminated_string (ptr2))
	    create pair1.make (a_name, a_prefix)
	    create pair2.make (pair1, a_value)
	    Result.force_last (pair2)

	    ptr1 := ptr_move (ptr1, 2)
	    ptr2 := ptr_contents (ptr1)
	 end
      end
   
   
   extract_name_and_prefix_from_name (a_name, ns_prefix: UCSTRING) is
	 -- extracts name and prefix from `a_name'.
	 -- Both `a_name' and `ns_prefix' will be modified
      require
	 a_name_not_void: a_name /= Void
	 ns_prefix_not_void: ns_prefix /= Void
      local
	 colon_index: INTEGER
	 tmp: UCSTRING
      do
	 colon_index := a_name.substring_index (uc_colon, 1)
	 ns_prefix.wipe_out
	 if
	    colon_index /= 0
	  then
	    ns_prefix.append_ucstring (a_name.substring (1, colon_index - 1))
	    tmp := clone (a_name)
	    a_name.wipe_out
	    a_name.append_ucstring (tmp.substring (colon_index + 1, tmp.count))
	 end
      end
   
   uc_colon: UCSTRING is
      once
	 !! Result.make_from_string (":")
      end
   
   
end -- EXPAT_EVENT_PARSER

--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------
