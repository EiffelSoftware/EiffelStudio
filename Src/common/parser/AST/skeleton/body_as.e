-- Abstract description of an Eiffel feature

class BODY_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node,
			find_breakable,
			format
		end

feature -- Attributes

	arguments: EIFFEL_LIST [TYPE_DEC_AS];
			-- List (of list) of arguments

	type: TYPE;
			-- Type if any

	content: CONTENT_AS;
			-- Content of the body: constant or regular body

feature -- Initialization
	
	set is
			-- Yacc initialization
		do
			arguments ?= yacc_arg (0);
			type ?= yacc_arg (1);
			content ?= yacc_arg (2);
				-- Constant value or standard feature body
		ensure then
			(content /= Void) or else (type /= Void);
		end; -- set

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on content of a feature
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.type_check;
			end;
		end;

	check_local_names is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.check_local_names;
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
			constant: CONSTANT_AS;
			routine: ROUTINE_AS;
			dyn_proc: DYN_PROC_I;
			def_func: DEF_FUNC_I;
			once_func: ONCE_FUNC_I;
			dyn_func: DYN_FUNC_I;
			proc, func: PROCEDURE_I;
			extern_proc: EXTERNAL_I;
			extern_func: EXTERNAL_FUNC_I;
			external_body: EXTERNAL_AS;
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
					!!const;
						-- Constant value is processed here.
					const.set_value (constant.value_i);
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
					extern_proc.set_alias_name (external_body.external_name);

-- Assertions and Rescue compound are not supported in
-- externals.
--					extern_proc.set_encapsulated
--						(content.has_assertion or else content.has_rescue);

					extern_proc.set_c_type (external_body.type_string);
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
					extern_func.set_alias_name (external_body.external_name);

-- Assertions and Rescue compound are not supported in
-- externals.
--					extern_func.set_encapsulated
--						(content.has_assertion or else content.has_rescue);

					extern_func.set_type (type);
					extern_func.set_c_type (external_body.type_string);
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

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		do
			Result := 	deep_equal (arguments, other.arguments) and then
						deep_equal (type, other.type);
			if Result and then content /= Void then
				Result := content.is_body_equiv (other.content);
			else
				Result := Result and then True;
			end;
		end;
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		do
			if content /= Void then
				if other.content = Void then -- It is an attribute
					Result := False
				else
					Result := content.is_assertion_equiv (other.content);
				end;
			else
				Result := True
			end;
		end;
				
feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
		do
			record_break_node;  -- We want a breakpoint on routine entrance
			if content /= Void then
				content.find_breakable;
			end;
		end
 
feature -- formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if arguments /= void and then not arguments.empty then
				ctxt.put_special (" (");
				ctxt.set_separator (";");
				ctxt.no_new_line_between_tokens;
				arguments.format (ctxt);
				ctxt.put_special (")");
			end;
			if type /= void then
				ctxt.put_special (": ");
				type.format (ctxt);
		 	end;
			if content /= void then
				content.format (ctxt)
			end;
			if not ctxt.no_internals then
				ctxt.put_special(";");
			end;
			ctxt.commit;
		end;
		
		
end
