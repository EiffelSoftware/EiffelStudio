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

feature -- Attributes

	language_name: EXTERNAL_LANG_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name_id: INTEGER
			-- Alias name ID in NAMES_HEAP.

feature -- Properties

	is_external: BOOLEAN is True
			-- Is the current routine body an external one ?

	external_name: STRING is
			-- Alias name: Void if none
		do
			if alias_name_id > 0 then
				Result := Names_heap.item (alias_name_id)
			end
		end; -- external_name

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
			if language_name.extension /= Void then
				Error_handler.set_error_position (language_name.start_position)
				language_name.extension.type_check (Current)
			end
		end

feature -- Byte code

	byte_node: BYTE_CODE is
			-- Byte code for external feature
		local
			extern: EXTERNAL_I
			arguments: FEAT_ARG
			i: INTEGER
			local_dec: ARRAY[TYPE_I]
			arg_c: INTEGER
			extension: EXTERNAL_EXTENSION_AS
			extension_bc: EXT_EXT_BYTE_CODE
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
	
				if extension /= Void then
					extension_bc := extension.byte_node
					extension.init_byte_node (extension_bc)

					ext_byte_code := extension_bc
				else
					create ext_byte_code
				end

				ext_byte_code.set_external_name (extern.external_name)
				ext_byte_code.set_encapsulated (extern.encapsulated)

				if
					extension /= Void and then
					(extension.is_macro or extension.is_struct or extension.has_signature)
				then
					ext_byte_code.set_result_type (extern.type.actual_type.type_i)
					arg_c := extern.argument_count
					if arg_c > 0 then
						from
							arguments := extern.arguments
							i := 1
							!!local_dec.make (1, arg_c)
						until
							i > arg_c
						loop
							local_dec.put 
								(arguments.i_th (i).actual_type.type_i, i)
							i := i + 1
						end
						ext_byte_code.set_arguments (local_dec)
					end
				end
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
			if external_name /= Void then
				ctxt.put_text_item (ti_Alias_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.put_quoted_string_item (Names_heap.item (alias_name_id))
				ctxt.new_line
				ctxt.exdent
			end
		end

end -- class EXTERNAL_AS
