indexing
	description: "Processor of code files for TOC inclusion"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_TOC_PROCESSOR

inherit
	TEMPLATE_CONSTANTS
	
	TABLE_OF_CONTENTS_CONSTANTS

	UTILITY_FUNCTIONS
	
create
	make
	
feature -- Creation

	make (a_parent: TABLE_OF_CONTENTS_NODE; a_file: PLAIN_TEXT_FILE) is
			-- Process `a_file' and include in `a_parent' when done
		require
			parent_not_void: a_parent /= Void
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do
			parent := a_parent
			code_file := a_file
			process
		ensure
			has_parent: parent /= Void
			has_file: code_file /= Void
		end		

feature {NONE} -- Implementation

	parent: TABLE_OF_CONTENTS_NODE
			-- Parent node
			
	code_file: PLAIN_TEXT_FILE
			-- Code file

	chart_node: like parent
			-- Chart node

feature -- Process

	process is
			-- Process
		do
			if class_name /= Void then
				process_chart			
			end
		end	
		
	process_chart is
			-- Process chart
		require
			class_name_not_void: class_name /= Void
		local
			l_chart_file: like code_file
			l_anchors: like generated_anchors
			l_name,
			l_anchor_title,
			l_filename_string,
			l_anchor_href: STRING
			l_filename: FILE_NAME
			l_node: like chart_node
			l_consts: SHARED_OBJECTS
		do
			create l_consts
			l_filename_string := code_file.name			
			create chart_node.make (next_id, parent, l_filename_string, class_name)
			l_filename_string := clone (l_filename_string.substring (1, l_filename_string.count - 10) + Contract_suffix + ".xml")			
			parent.add_node (chart_node)
			
			l_name := directory_no_file_name (code_file.name.string)
			create l_filename.make_from_string (l_name)
			l_filename.extend (class_name + Chart_suffix)
			l_filename.add_extension (xml_extension)
			create l_chart_file.make (l_filename.string)
			if l_chart_file.exists then
					-- Read the individual features				
				if l_consts.shared_project.preferences.generate_feature_nodes then	
					l_anchors := generated_anchors (l_chart_file)					
					if l_anchors /= Void and then not l_anchors.is_empty then
						from
							l_anchors.start
						until
							l_anchors.after
						loop
							l_anchor_title := l_anchors.item_for_iteration
							l_anchor_href := l_filename_string + l_anchors.key_for_iteration					
							create l_node.make (next_id, chart_node, l_anchor_href, l_anchor_title)
							chart_node.add_node (l_node)						
							l_anchors.forth
						end
						chart_node.sort
					end				
				end				
			end
		end

feature -- File

	class_name: STRING is
			-- Class name about which `code_file' contains information
		local
			l_name: STRING	
		do		
			if is_chart then
				l_name := file_no_extension (short_name (code_file.name))
				Result := l_name.substring (1, l_name.count - 6)
				Result.to_upper
			end
		end		
		
	is_chart: BOOLEAN is
			-- Is file a chart view file?
		local
			l_name,
			l_suffix: STRING	
		do
			l_name := file_no_extension (short_name (code_file.name.string))
			l_suffix := l_name.substring (l_name.count - 5, l_name.count)
			if l_suffix /= Void then
				Result := l_suffix.is_equal (Chart_suffix) 
			end
		end		
	
feature {NONE} -- Implementation

	generated_anchors (a_file: PLAIN_TEXT_FILE): HASH_TABLE [STRING, STRING] is
			-- Parse `a_file' and return hash of anchor names and links
		require
			file_not_void: a_file /= Void			
			file_exists: a_file.exists
		local
			retried: BOOLEAN
			l_string: STRING
			l_parser: XM_EIFFEL_PARSER
			l_xml_reader: CODE_CONTRACT_READER 
		do	
			if not retried then
				a_file.open_read
				a_file.readstream (a_file.count)
				l_string := a_file.laststring
				if not l_string.is_empty then					
					create l_xml_reader.make
					create l_parser.make
					l_parser.set_callbacks (l_xml_reader)
					l_parser.parse_from_string (l_string)
					check
						ok_parsing: l_parser.is_correct
					end
					Result := clone (l_xml_reader.anchors)
					l_xml_reader := Void
				end
				a_file.close
			end
		rescue
			retried := True
			retry		
		end
	
invariant
	has_parent: parent /= Void
	has_file : code_file /= Void

end -- class CLASS_TOC_PROCESSOR
