indexing
	description: "Implementation of ICodeParser"

class
	ECD_PARSER

inherit
	SYSTEM_DLL_ICODE_PARSER
		undefine
			equals, get_hash_code, to_string
		end
	
	ANY

create
	default_create

feature -- Implementation

	parse (code_stream: TEXT_READER): SYSTEM_DLL_CODE_COMPILE_UNIT is
			-- implementation of parse feature.
		require else
			referenced_assemblies_initialized: (create {ECD_REFERENCED_ASSEMBLIES}).assemblies_initialized
		local
			l_eiffel_parser: EIFFEL_PARSER
			l_class_to_parse: STRING
			l_class_as: CLASS_AS
			l_visitor: ECD_CODEDOM_VISITOR
			l_support: ECD_SUPPORT
			l_retried: BOOLEAN
			l_code_stream: SYSTEM_STRING
		do
			if not l_retried then
				initialize_referenced_assemblies
				create l_eiffel_parser.make
				
					-- FIXME IEK We do not deal with dos files correctly yet so we convert to unix.
				l_code_stream := code_stream.read_to_end.replace_string_string ("%R%N", "%N")
				create l_class_to_parse.make_from_cil (l_code_stream)
				l_eiffel_parser.parse_from_string (l_class_to_parse)
				l_class_as := l_eiffel_parser.root_node
				initialize_attributes (l_class_as)
				create l_visitor.make
				l_class_as.process (l_visitor)
	
				create l_support
				Result ?= l_support.last_element_created;
				last_compile_unit_generated := Result
			end
		rescue
			(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_retried := True
			Result := last_compile_unit_generated
			retry
		end
		
	last_compile_unit_generated: SYSTEM_DLL_CODE_COMPILE_UNIT
		-- Result of the last valid compile unit generated.
		-- If parsing of Eiffel code fails we return the last compile unit.

	initialize_attributes (a_class_as: CLASS_AS) is
			-- Parse tree and initialize attributes.
		require
		--	non_void_a_class_as: a_class_as /= Void
		local
			l_init_attributes: ECD_INIT_ATTRIBUTES
		do
			create l_init_attributes.make
			a_class_as.process (l_init_attributes)
		end

	initialize_referenced_assemblies is
			-- | Initialize Referenced_assemblies
			-- FIXME Raphael: this should not be here it's VS specific
		local
--			l_assembly: ASSEMBLY
--			vs_project: VS_VSPROJECT
--			i: INTEGER
--			vs_references: VS_REFERENCES
--			vs_reference: VS_REFERENCE
--			l_referenced_assemblies: LINKED_LIST [ECD_REFERENCED_ASSEMBLY]
--			l_code_dom_path: ECD_CODE_DOM_PATH
		do
--			create l_code_dom_path
--			create l_referenced_assemblies.make
--			vs_project := l_code_dom_path.vs_project
--			
--			vs_references := vs_project.references
--			from
--				i := 1
--			until
--				i > vs_references.count
--			loop
--				vs_reference := vs_references.item (i)				
--				l_assembly := l_code_dom_path.load_assembly (vs_reference.path)
--				if l_assembly /= Void then
--					l_referenced_assemblies.extend (create {ECD_REFERENCED_ASSEMBLY}.make (l_assembly))
--				end
--				i := i + 1
--			end
--				-- Make sure all referenced assemblies are consumed in Eiffel GACs
--			(create {TYPE_CONVERTER}).initialize_emitter_from_referenced_assemblies (l_referenced_assemblies)
		end

end -- class ECD_PARSER
