-- Abstract description of an Eiffel feature

class BODY_AS

inherit
	AST_EIFFEL
		redefine
			number_of_stop_points, is_equivalent,
			type_check, byte_node, find_breakable,
			fill_calls_list, replicate
		end

feature {NONE} -- Initialization
	
	set is
			-- Yacc initialization
		do
			arguments ?= yacc_arg (0)
			type ?= yacc_arg (1)
			content ?= yacc_arg (2)
				-- Constant value or standard feature body
		end

feature -- Attributes

	arguments: EIFFEL_LIST [TYPE_DEC_AS]
			-- List (of list) of arguments

	type: TYPE
			-- Type if any

	content: CONTENT_AS
			-- Content of the body: constant or regular body

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (arguments, other.arguments) and
				equivalent (content, other.content) and
				equivalent (type, other.type)
		end

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			if content /= Void then
				Result := content.number_of_stop_points
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this body has instruction `i'?
		do
			if content /= Void then
				Result := content.has_instruction (i)
			else
				Result := False
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this body.
			-- Result is `0' not found.
		do
			if content /= Void then
				Result := content.index_of_instruction (i)
			else
				Result := 0
			end
		end

feature -- empty body

	empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (content = Void) or else (content.empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
				-- Create default rescue if necessary
		require
			valid_feature_name : def_resc_name /= Void
		do
			if content /= Void then
				content.create_default_rescue (def_resc_name)
			end
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on content of a feature
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.type_check
			end
		end

	is_unique: BOOLEAN is
		do
			Result := content /= Void and then content.is_unique
		end

	check_local_names is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.check_local_names
			end
		end

	local_table (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
				Result := content.local_table (f)
			end
		end

	local_table_for_format (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
				Result := content.local_table_for_format (f)
			end
		end

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
			Result := content.byte_node
		end

feature -- New feature description
	
	new_feature: FEATURE_I is
			-- Conversion into an EIFFEL_FEAT
		local
			attr: ATTRIBUTE_I
			const: CONSTANT_I
			constant: CONSTANT_AS
			routine: ROUTINE_AS
			dyn_proc: DYN_PROC_I
			def_func: DEF_FUNC_I
			once_func: ONCE_FUNC_I
			dyn_func: DYN_FUNC_I
			proc, func: PROCEDURE_I
			extern_proc: EXTERNAL_I
			extern_func: EXTERNAL_FUNC_I
			external_body: EXTERNAL_AS
				-- Hack Hack Hack
				-- A litteral numeric value is interpreted as 
				-- a DOUBLE. In the case of a constant REAL
				-- declaration that wont do!
			ras: REAL_TYPE_AS
			rvi: REAL_VALUE_I
			fvi: FLOAT_VALUE_I
			cvi: VALUE_I
			ext_lang: EXTERNAL_LANG_AS
		do
			if content = Void then
					-- It is an attribute
				!!attr
				check
					type_exists: type /= Void
				end
				attr.set_type (type)
				Result := attr
				Result.set_empty_body (True)

			elseif content.is_constant then
					-- It is a constant feature
				constant ?= content
				if content.is_unique then
						-- No constant value is processed for a unique
						-- feature, since the second pass does it.
					!UNIQUE_I!const
				else
					ras ?= type
					!!const
						-- Constant value is processed here.
					if (ras = Void) then
						const.set_value (constant.value_i)
					else
						cvi := constant.value_i
						if cvi.is_double then
							rvi ?= cvi
							!!fvi; fvi.set_real_val (rvi.real_val)
							const.set_value (fvi)
						else
							const.set_value (cvi)
						end
					end
				end
				check
					constant_exists: constant /= Void
					type_exists: type /= Void
				end
				const.set_type (type)
				Result := const
				Result.set_empty_body (True)

			elseif type = Void then
				routine ?= content
				check
					routine_exists: routine /= Void
				end
				if routine.is_deferred then
						-- Deferred procedure
					!DEF_PROC_I!proc
				elseif routine.is_once then
						-- Once procedure
					!ONCE_PROC_I!proc
				elseif routine.is_external then
						-- External procedure
					!!extern_proc
					external_body ?= routine.routine_body
					ext_lang := external_body.language_name
					if external_body.alias_name /= Void then
						extern_proc.set_alias_name (external_body.alias_name.value)
					end
					extern_proc.set_extension (ext_lang.extension_i (external_body))

-- Assertions and Rescue compound are not supported in
-- externals.
--					extern_proc.set_encapsulated
--						(content.has_assertion or else content.has_rescue)

						-- if there's a macro or a signature then encapsulate
					extern_proc.set_encapsulated (ext_lang.need_encapsulation)
					proc := extern_proc
				else
					!DYN_PROC_I!proc
				end
				if arguments /= Void then
						-- Arguments initialization
					proc.init_arg (arguments)
				end
				proc.init_assertion_flags (routine)
				if routine.obsolete_message /= Void then
					proc.set_obsolete_message (routine.obsolete_message.value)
				end
				Result := proc
				Result.set_empty_body (content.empty)
			else
				routine ?= content
				check
					routine_exists: routine /= Void
				end
				if routine.is_deferred then
						-- Deferred function
					!!def_func
					def_func.set_type (type)
					func := def_func
				elseif routine.is_once then
						-- Once function
					!!once_func
					once_func.set_type (type)
					func := once_func
				elseif routine.is_external then
						-- External function
					!!extern_func
					external_body ?= routine.routine_body
					ext_lang := external_body.language_name
					if external_body.alias_name /= Void then
						extern_func.set_alias_name (external_body.alias_name.value)
					end
					extern_func.set_extension (ext_lang.extension_i (external_body))

-- Assertions and Rescue compound are not supported in
-- externals.
--					extern_func.set_encapsulated
--						(content.has_assertion or else content.has_rescue)

						-- if there's a macro or a signature then encapsulate
					extern_func.set_encapsulated (ext_lang.need_encapsulation)
					extern_func.set_type (type)
					func := extern_func
				else
					!!dyn_func
					dyn_func.set_type (type)
					func := dyn_func
				end
				if arguments /= Void then
						-- Arguments initialization
					func.init_arg (arguments)
				end
				func.init_assertion_flags (routine)
				if routine.obsolete_message /= Void then
					func.set_obsolete_message (routine.obsolete_message.value)
				end
				Result := func
				Result.set_empty_body (content.empty)
			end
		end

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the body of current feature equivalent to 
			-- body of `other' ?
		do
			Result := equivalent (type, other.type) and then
					equivalent (arguments, other.arguments)
debug
	io.error.putstring ("BODY_AS.is_body_equiv%N")
	if not Result then
		io.error.putstring ("Different signatures%N")
	end
end
			if Result then
				if (content = Void) and (other.content = Void) then
				elseif (content = Void) or else (other.content = Void) then
					Result := False
				elseif (content.is_constant = other.content.is_constant) then
						-- The two objects are of the same type.
						-- There is no global typing problem.
					Result := content.is_body_equiv (other.content)
debug
	if not Result then
		io.error.putstring ("Different bodies%N")
	end
end
				else
					Result := False
				end
			end
		end
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the assertion of Current feature equivalent to 
			-- assertion of `other' ?
			--|Note: This test is valid since assertions are generated
			--|along with the body code. The assertions will be re-generated
			--|whenever the body has changed. Therefore it is not necessary to
			--|consider the cases in which one of the contents is a ROUTINE_AS 
			--|and the other a CONSTANT_AS (The True value is actually returned
			--|but we don't care.
			--|Non-constant attributes have a Void content. In any case 
			--|involving at least on attribute, the True value is retuned:
			--|   . If they are both attributes, the assertions are equivalent
			--|   . If only on is an attribute, we don't care since the bodies will
			--|	 not be equivalent anyway.
			--|The best way to understand all this, is to draw a two-dimensional
			--|table, for all possible combinations of the values (CONSTANT_AS,
			--|ROUTINE_AS, Void) of content and other.content)
		local
			r1, r2: ROUTINE_AS
		do
			r1 ?= content; 
			r2 ?= other.content
			if (r1 /= Void) and then (r2 /= Void) then
				Result := r1.is_assertion_equiv (r2)
			else
				Result := True
			end
		end
				
feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		do
			if content /= Void then
				content.find_breakable
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			if content /= Void then
				content.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			if arguments /= Void then
				Result.set_arguments (
				arguments.replicate (ctxt))
			end
			if type /= Void then
				Result.set_type (
					type.replicate (ctxt))
			end
			if content /= Void then
				Result.set_content (
					content.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			routine_as: ROUTINE_AS
		do
			if arguments /= Void and then not arguments.empty then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_L_parenthesis)
				ctxt.set_separator (ti_Semi_colon)
				ctxt.set_space_between_tokens
				ctxt.format_ast (arguments)
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end
			if type /= Void then
				ctxt.put_text_item_without_tabs (ti_Colon)
				ctxt.put_space
				if type.has_like then
					ctxt.new_expression
				end
				ctxt.format_ast (type)
			end
			ctxt.set_separator (ti_Empty)
			if content /= Void then
				ctxt.format_ast (content)
			end
		end
				
feature {BODY_AS, FEATURE_AS, BODY_MERGER, USER_CMD, CMD} -- Replication

	set_arguments (a: like arguments) is
		do
			arguments := a
		end

	set_type (t: like type) is
		do
			type := t
		end

	set_content (c: like content) is
		do
			content := c
		end
		
end -- class BODY_AS
