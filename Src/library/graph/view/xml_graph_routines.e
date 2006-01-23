indexing
	description: "[
			Common routines for XML extraction, saving and deserialization
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_GRAPH_ROUTINES

inherit
	EXCEPTIONS
    	rename
    		tag_name as exceptions_tag_name,
    		class_name as exceptions_class_names
    	redefine
    		default_create
    	end

	XM_CALLBACKS_FILTER_FACTORY
		export 
			{NONE} all 
		redefine
			default_create
		end

create {EG_XML_STORABLE}
	make, default_create

feature {NONE} -- Initialization

	default_create is
			-- Create an XML_ROUTINE
		do
			create valid_tag_read_actions
		end

	make (a_relative_window: like relative_window) is
			-- Initialization
		require
			non_void_relative_window: a_relative_window /= Void
		do
			default_create
			relative_window := a_relative_window
		ensure
			relative_window_set : relative_window = a_relative_window
		end
		
feature {NONE} -- Access

	relative_window: EV_WINDOW
			-- relative window

feature {EG_XML_STORABLE} -- Access
			
	number_of_tags (node: XM_ELEMENT): INTEGER is
			-- Number of tags in node and all childrens of node.
		require
			node_not_void: node /= Void
		local
			l_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			l_item: XM_ELEMENT
			attr: XM_ATTRIBUTE
		do
			from
				l_cursor := node.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item ?= l_cursor.item
				if l_item /= Void then
					Result := Result + number_of_tags (l_item)
				else
					attr ?= l_cursor.item
					if attr = Void then
						Result := Result + 1
					end
				end
				l_cursor.forth
			end
		end

feature {EG_XML_STORABLE} -- Status report

	valid_tags: INTEGER
			-- Number of valid tags read.
	
	valid_tag_read_actions: EV_NOTIFY_ACTION_SEQUENCE

feature {EG_XML_STORABLE} -- Status setting
	
	reset_valid_tags is
			-- Reset `valid_tags'.
		do
			valid_tags := 0
		ensure
			valid_tags_is_nul: valid_tags = 0
		end

	valid_tags_read is
			-- A valid tag was just read.
		do
			valid_tags := valid_tags + 1
			valid_tag_read_actions.call (Void)
		ensure
			valid_tags_incremented: valid_tags = old valid_tags + 1
		end

feature {EG_XML_STORABLE} -- Processing

	xml_integer (elem: XM_ELEMENT; a_name: STRING): INTEGER is
			-- Find in sub-elememt of `elem' integer item with tag `a_name'.
		local
			e: XM_ELEMENT
			int_str: STRING
		do
			e ?= elem.item_for_iteration
			if e /= Void and then e.name.is_equal (a_name) then
				int_str := e.text
				if int_str /= Void and then int_str.is_integer then
					Result := int_str.to_integer
					valid_tags_read
				else
					display_warning_message ("Value of element " + a_name + " is not valid.")
				end
			else
				display_warning_message ("Element " + a_name + " expected but not found.")
			end		
			elem.forth
		end

	xml_boolean (elem: XM_ELEMENT; a_name: STRING): BOOLEAN is
			-- Find in sub-elememt of `elem' boolean item with tag `a_name'.
		local
			e: XM_ELEMENT
			bool_str: STRING
		do
			e ?= elem.item_for_iteration
			if e /= Void and then e.name.is_equal (a_name) then
				bool_str := e.text
				if bool_str /= Void and then bool_str.is_boolean then
					Result := bool_str.to_boolean
					valid_tags_read
				else
					display_warning_message ("Value of element " + a_name + " is not valid.")
				end
			else
				display_warning_message ("Element " + a_name + " expected but not found.")
			end
			elem.forth
		end

	xml_double (elem: XM_ELEMENT; a_name: STRING): DOUBLE is
			-- Find in sub-elememt of `elem' integer item with tag `a_name'.
		local
			e: XM_ELEMENT
			double_str: STRING
		do
			e ?= elem.item_for_iteration
			if e /= Void and then e.name.is_equal (a_name) then
				double_str := e.text
				if double_str /= Void and then double_str.is_double then
					Result := double_str.to_double
					valid_tags_read
				else
					display_warning_message ("Value of element " + a_name + " is not valid.")
				end
			else
				display_warning_message ("Element " + a_name + " expected but not found.")
			end
			elem.forth
		end

	xml_string (elem: XM_ELEMENT; a_name: STRING): STRING is
			-- Find in sub-elememt of `elem' string item with tag `a_name'.
		local
			e: XM_ELEMENT
		do
			e ?= elem.item_for_iteration
			if e /= Void and then e.name.is_equal (a_name) then
				Result := e.text
				valid_tags_read
			else
				display_warning_message ("Element " + a_name + " expected but not found.")
			end
			elem.forth
		end

	xml_color (elem: XM_ELEMENT; a_name: STRING): EV_COLOR is
			-- Find in sub-elememt of `elem' color item with tag `a_name'.
		local
			e: XM_ELEMENT
			s: STRING
			sc1, sc2: INTEGER
			r, g, b: INTEGER
			rescued: BOOLEAN
		do
			if not rescued then
				e ?= elem.item_for_iteration
				if e /= Void and then e.name.is_equal (a_name) then
					s := e.text
				end
				if s /= Void and then not s.is_empty then
					check
						two_semicolons: s.occurrences (';') = 2
					end
					sc1 := s.index_of (';', 1)
					r := s.substring (1, sc1 - 1).to_integer
					sc2 := s.index_of (';', sc1 + 1)
					g := s.substring (sc1 + 1, sc2 - 1).to_integer
					b := s.substring (sc2 + 1, s.count).to_integer
					create Result.make_with_8_bit_rgb (r, g, b)
					valid_tags_read
				else
					display_warning_message ("Value of element " + a_name + " is not valid.")
					create Result.make_with_8_bit_rgb (255, 255, 0)				
				end
			else
				display_warning_message ("Retrieve default color.")
					-- Default color
				create Result.make_with_8_bit_rgb (255, 255, 0)
			end
			elem.forth
		ensure
			non_void_color: Result /= Void
		rescue
			rescued := True
			retry
		end

	element_by_name (e: XM_ELEMENT; n: STRING): XM_ELEMENT is
			-- Find in sub-elemement of `e' an element with tag `n'.
		require
			e_not_void: e /= Void
		do
			Result := e.element_by_name (n)
		end

	xml_string_node (a_parent: XM_ELEMENT; s: STRING): XM_CHARACTER_DATA is
			-- New node with `s' as content.
		do
			create Result.make (a_parent, s)
		end

	xml_node (a_parent: XM_ELEMENT; tag_name, content: STRING): XM_ELEMENT is
			-- New node with `s' as content and named `tag_name'.
		local
			l_namespace: XM_NAMESPACE
		do
			create l_namespace.make_default
			create Result.make (a_parent, tag_name, l_namespace)
			Result.put_last (xml_string_node (Result, content))
		end

feature -- Saving

	save_xml_document (a_file_name: STRING; a_doc: XM_DOCUMENT) is
			-- Save `a_doc' in `ptf'
		require
			file_not_void: a_file_name /= Void
			file_exists: not a_file_name.is_empty
		local
			retried: BOOLEAN
			l_formatter: XM_FORMATTER
			l_output_file: KL_TEXT_OUTPUT_FILE
		do
			if not retried then
					-- Write document
				create l_output_file.make (a_file_name)
				l_output_file.open_write
				if l_output_file.is_open_write then
					create l_formatter.make
					l_formatter.set_output (l_output_file)
					l_formatter.process_document (a_doc)
					l_output_file.flush
					l_output_file.close
				else
					display_error_message ("Unable to write file: " + a_file_name)
				end
			end
		rescue
			retried := True
			display_error_message ("Unable to write file: " + a_file_name)
			retry
		end

feature -- Deserialization

	deserialize_document (a_file_path: STRING): XM_DOCUMENT is
			-- Retrieve xml document associated to file
			-- serialized in `a_file_path'.
			-- If deserialization fails, return Void.
		require
			valid_file_path: a_file_path /= Void and then not a_file_path.is_empty
		local
			l_parser: XM_EIFFEL_PARSER
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_file: KL_BINARY_INPUT_FILE
			l_xm_concatenator: XM_CONTENT_CONCATENATOR
		do
			create l_file.make (a_file_path)
			l_file.open_read
			if l_file.is_open_read then
				create l_parser.make
				create l_tree_pipe.make
				create l_xm_concatenator.make_null
				l_parser.set_callbacks (standard_callbacks_pipe (<<l_xm_concatenator, l_tree_pipe.start>>))
				l_parser.parse_from_stream (l_file)
				l_file.close
				if l_parser.is_correct then
					Result := l_tree_pipe.document
				else
					display_error_message ("File " + a_file_path + " is corrupted")
					Result := Void
				end
			else
				display_error_message ("File " + a_file_path + " cannot not be open")
			end
		end

feature {SHARED_XML_ROUTINES} -- Error management

	display_warning_message (a_warning_msg: STRING) is
			-- Display `a_warning_msg' in a warning popup window.
		require
			valid_error_message: a_warning_msg /= Void and then not a_warning_msg.is_empty
		local
			l_warning_window: EV_WARNING_DIALOG
		do
			create l_warning_window.make_with_text (a_warning_msg)
			l_warning_window.show
			--l_warning_window.show_modal_to_window (relative_window)
		end

	display_error_message (an_error_msg: STRING) is
			-- Display `an_error_msg' in an error popup window.
		require
			valid_error_message: an_error_msg /= Void and then not an_error_msg.is_empty
		local
			l_error_window: EV_ERROR_DIALOG
		do
			create l_error_window.make_with_text (an_error_msg)
			l_error_window.show
			--l_warning_window.show_modal_to_window (relative_window)
		end

	display_warning_message_relative (a_warning_msg: STRING; a_parent_window: EV_WINDOW) is
			-- Display `a_warning_msg' in a warning popup window.
		require
			valid_error_message: a_warning_msg /= Void and then not a_warning_msg.is_empty
			non_void_parent_window: a_parent_window /= Void
		local
			l_warning_window: EV_WARNING_DIALOG
		do
			create l_warning_window.make_with_text (a_warning_msg)
			l_warning_window.show_modal_to_window (a_parent_window)
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




end -- class XML_ROUTINESOUTINES

