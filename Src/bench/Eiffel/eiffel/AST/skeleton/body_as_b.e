-- Abstract description of an Eiffel feature

class BODY_AS_B

inherit

	BODY_AS
		redefine
			arguments, type, content
		end;

	AST_EIFFEL_B
		redefine
			type_check, byte_node,
			find_breakable,
			fill_calls_list, replicate
		end

feature -- Attributes

	arguments: EIFFEL_LIST_B [TYPE_DEC_AS_B];
			-- List (of list) of arguments

	type: TYPE_B;
			-- Type if any

	content: CONTENT_AS_B;
			-- Content of the body: constant or regular body

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on content of a feature
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.type_check;
			end;
		end;

	local_table (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
				Result := content.local_table (f);
			end;
		end;

	local_table_for_format (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
				Result := content.local_table_for_format (f);
			end;
		end;

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
			Result := content.byte_node;
		end;

feature -- New feature description
	
	new_feature: FEATURE_I is
			-- Conversion into an EIFFEL_FEAT
		local
			attr: ATTRIBUTE_I;
			const: CONSTANT_I;
			constant: CONSTANT_AS_B;
			routine: ROUTINE_AS_B;
			dyn_proc: DYN_PROC_I;
			def_func: DEF_FUNC_I;
			once_func: ONCE_FUNC_I;
			dyn_func: DYN_FUNC_I;
			proc, func: PROCEDURE_I;
			extern_proc: EXTERNAL_I;
			extern_func: EXTERNAL_FUNC_I;
			external_body: EXTERNAL_AS_B;
				-- Hack Hack Hack
				-- A litteral numeric value is interpreted as 
				-- a DOUBLE. In the case of a constant REAL
				-- declaration that wont do!
			ras: REAL_TYPE_AS_B;
			rvi: REAL_VALUE_I;
			fvi: FLOAT_VALUE_I;
			cvi: VALUE_I;
			ext_lang: EXTERNAL_LANG_AS_B;
		do
			if content = Void then
					-- It is an attribute
				!!attr;
				check
					type_exists: type /= Void;
				end;
				attr.set_type (type);
				Result := attr;
			elseif content.is_constant then
					-- It is a constant feature
				constant ?= content;
				if content.is_unique then
						-- No constant value is processed for a unique
						-- feature, since the second pass does it.
					!UNIQUE_I!const;
				else
					ras ?= type;
					!!const;
						-- Constant value is processed here.
					if (ras = Void) then
						const.set_value (constant.value_i);
					else
						cvi := constant.value_i;
						if cvi.is_double then
							rvi ?= cvi;
							!!fvi; fvi.set_real_val (rvi.real_val);
							const.set_value (fvi);
						else
							const.set_value (cvi);
						end;
					end
				end;
				check
					constant_exists: constant /= Void;
					type_exists: type /= Void;
				end;
				const.set_type (type);
				Result := const;
			elseif type = Void then
				routine ?= content;
				check
					routine_exists: routine /= Void;
				end;
				if routine.is_deferred then
						-- Deferred procedure
					!DEF_PROC_I!proc;
				elseif routine.is_once then
						-- Once procedure
					!ONCE_PROC_I!proc;
				elseif routine.is_external then
						-- External procedure
					!!extern_proc;
					external_body ?= routine.routine_body;
					ext_lang := external_body.language_name;
					if external_body.alias_name /= Void then
						extern_proc.set_alias_name (external_body.alias_name.value);
					end;
					extern_proc.set_extension (ext_lang.extension_i (external_body));

-- Assertions and Rescue compound are not supported in
-- externals.
--					extern_proc.set_encapsulated
--						(content.has_assertion or else content.has_rescue);

						-- if there's a macro or a signature then encapsulate
					extern_proc.set_encapsulated (ext_lang.need_encapsulation);
					proc := extern_proc;
				else
					!DYN_PROC_I!proc;
				end;
				if arguments /= Void then
						-- Arguments initialization
					proc.init_arg (arguments);
				end;
				proc.init_assertion_flags (routine);
				if routine.obsolete_message /= Void then
					proc.set_obsolete_message (routine.obsolete_message.value);
				end;
				Result := proc;
			else
				routine ?= content;
				check
					routine_exists: routine /= Void;
				end;
				if routine.is_deferred then
						-- Deferred function
					!!def_func;
					def_func.set_type (type);
					func := def_func;
				elseif routine.is_once then
						-- Once function
					!!once_func;
					once_func.set_type (type);
					func := once_func;
				elseif routine.is_external then
						-- External function
					!!extern_func;
					external_body ?= routine.routine_body;
					ext_lang := external_body.language_name;
					if external_body.alias_name /= Void then
						extern_func.set_alias_name (external_body.alias_name.value);
					end;
					extern_func.set_extension (ext_lang.extension_i (external_body));

-- Assertions and Rescue compound are not supported in
-- externals.
--					extern_func.set_encapsulated
--						(content.has_assertion or else content.has_rescue);

						-- if there's a macro or a signature then encapsulate
					extern_func.set_encapsulated (ext_lang.need_encapsulation);
					extern_func.set_type (type);
					func := extern_func;
				else
					!!dyn_func;
					dyn_func.set_type (type);
					func := dyn_func;
				end;
				if arguments /= Void then
						-- Arguments initialization
					func.init_arg (arguments);
				end;
				func.init_assertion_flags (routine);
				if routine.obsolete_message /= Void then
					func.set_obsolete_message (routine.obsolete_message.value);
				end;
				Result := func;
			end;
		end;
				
feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		do
			if content /= Void then
				content.find_breakable
			end;
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			if content /= void then
				content.fill_calls_list (l);
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			if arguments /= void then
				Result.set_arguments (
				arguments.replicate (ctxt))
			end;
			if type /= void then
				Result.set_type (
					type.replicate (ctxt))
			end;
			if content /= void then
				Result.set_content (
					content.replicate (ctxt))
			end
		end;
		
end -- class BODY_AS_B
