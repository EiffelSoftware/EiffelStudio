indexing
	description: "AST representation of a external C routine."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			byte_node, type_check, is_external
		end

	EXTERNAL_CONSTANTS

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (l: like language_name; a: STRING_AS) is
			-- Create a new EXTERNAL AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			if a /= Void then
				Names_heap.put (a.value)
				alias_name_id := Names_heap.found_item
			end
		ensure
			language_name_set: language_name = l
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_external_as (Current)
		end

feature -- Attributes

	language_name: EXTERNAL_LANG_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name_id: INTEGER
			-- Alias name ID in NAMES_HEAP.

feature -- Properties

	is_external: BOOLEAN is True
			-- Is the current routine body an external one ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := alias_name_id = other.alias_name_id and then
				equivalent (language_name, other.language_name)
		end

feature -- Conveniences

	type_check is
			-- Type checking
		do
			Error_handler.set_error_position (language_name.start_position)
			language_name.extension.type_check (Current)
		end

feature -- Byte code

	byte_node: BYTE_CODE is
			-- Byte code for external feature
		local
			extern: EXTERNAL_I
			extension: EXTERNAL_EXTENSION_AS
			ext_byte_code: EXT_BYTE_CODE
		do
			extern ?= context.current_feature
			if extern = Void then
				create {DEF_BYTE_CODE} Result
			else
				check
					extern_exists: context.current_feature /= Void
					is_extern: context.current_feature.is_external
				end

				extension := language_name.extension
				ext_byte_code := extension.byte_node
				extension.init_byte_node (ext_byte_code)

				ext_byte_code.set_external_name_id (extern.external_name_id)
				ext_byte_code.set_encapsulated (extern.encapsulated)

				check
					external_name_not_void: ext_byte_code.external_name /= Void
				end
				Result := ext_byte_code
			end
		end

feature {AST_EIFFEL, FEATURE_I} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_text_item (ti_External_keyword)
			ctxt.indent
			ctxt.new_line
			ctxt.format_ast (language_name.language_name)
			ctxt.exdent
			ctxt.new_line
			if alias_name_id > 0 then
				ctxt.put_text_item (ti_Alias_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.put_quoted_string_item (Names_heap.item (alias_name_id))
				ctxt.new_line
				ctxt.exdent
			end
		end

end -- class EXTERNAL_AS
