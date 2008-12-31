note
	description: "Indexing clause tags handled in a special way by the codedom generator"

class
	CODE_SPECIAL_TAGS

inherit
	CODE_SHARED_CONTEXT
		export
			{NONE} all
		end
	

feature -- Access

	precompiled_tag: STRING = "precompile_definition_file"
			-- Tag defining path to precompiled library
		
	namespace_tag: STRING = "namespace"
			-- Tag defining namespace in which type should be generated

feature -- Basic Operations

	process_tag (a_tag, a_value: STRING)
			-- Process tag `a_tag'
		do
			special_tag_handlers.search (a_tag)
			if special_tag_handlers.found then
				special_tag_handlers.found_item.call ([a_value])
			end
		end

feature {NONE} -- Implementation

	special_tag_handlers: HASH_TABLE [PROCEDURE [ANY, TUPLE [STRING]], STRING]
			-- Tag handlers
		once
			create Result.make (2)
			
			Result.extend (agent process_precompiled_tag, precompiled_tag)
			Result.extend (agent process_namespace_tag, namespace_tag)
		end

	process_precompiled_tag (a_value: STRING)
			-- Process precompiled library tag
		do
			Compilation_context.set_precompile_file (a_value)
		end

	process_namespace_tag (a_value: STRING)
			-- Process precompiled library tag
		do
			Compilation_context.set_namespace (a_value)
		end

end