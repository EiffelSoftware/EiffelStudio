indexing
	description: "Factory for compiler which generates descendans of certain AST classes."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_COMPILER_FACTORY

inherit
	AST_FACTORY
		redefine
			new_bits_as,
			new_class_as,
			new_class_type_as,
			new_debug_as,
			new_expr_address_as,
			new_feature_as,
			new_integer_as,
			new_integer_hexa_as
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

feature -- Access

	new_bits_as (v: INTEGER_AS): BITS_AS is
			-- New BITS AST node
		local
			l_vtbt: VTBT_SIMPLE
		do
			if v /= Void then
				create Result.initialize (v)
				if (v.integer_32_value <= 0) then
					create l_vtbt
					l_vtbt.set_class (system.current_class)
					l_vtbt.set_value (v.integer_32_value)
					l_vtbt.set_location (v.start_location)
					Error_handler.insert_error (l_vtbt)
						-- Cannot go on here
					Error_handler.raise_error
				end
			end
		end	
		
	new_class_as (n: ID_AS; ext_name: STRING;
			is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			p: EIFFEL_LIST [PARENT_AS];
			c: EIFFEL_LIST [CREATE_AS];
			co: EIFFEL_LIST [CONVERT_FEAT_AS];
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			he: BOOLEAN; ed: LOCATION_AS): CLASS_AS
		is
			-- New CLASS AST node
		do
			if n /= Void and s /= Void and (co = Void or else not co.is_empty) and ed /= Void then
				create Result.initialize (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, top_ind,
				bottom_ind, g, p, c, co, f, inv, s, o, he, ed)

					-- Check for Concurrent Eiffel which is not yet supported
				if Result.is_separate then
					error_handler.insert_error (create {SEPARATE_SYNTAX_ERROR}.init)
					error_handler.raise_error
				end
			end
		end

	new_class_type_as (n: ID_AS; g: EIFFEL_LIST [TYPE_AS]; is_exp: BOOLEAN; is_sep: BOOLEAN): CLASS_TYPE_AS is
		do
			if n /= Void then
				create Result.initialize (n, g, is_exp, is_sep)
				if is_exp then
					system.set_has_expanded
					check
						system_initialized: system.current_class /= Void
					end
					system.current_class.set_has_expanded
				end
			end
		end
		
	new_debug_as (k: EIFFEL_LIST [STRING_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; e: LOCATION_AS): DEBUG_AS is
		local
			l_str: STRING
		do
			if e /= Void then
				create Result.initialize (k, c, e)
				if k /= Void then
					from
							-- Debug keys are not case sensitive
						k.start
					until
						k.after
					loop
						l_str := k.item.value
						l_str.to_lower
						system.add_new_debug_clause (l_str)
						k.forth
					end
				end
			end
		end
		
	new_expr_address_as (e: EXPR_AS): EXPR_ADDRESS_AS is
		do
			if not system.address_expression_allowed then
				error_handler.insert_error (create {SYNTAX_ERROR}.init)
				error_handler.raise_error
			elseif e /= Void then
				create Result.initialize (e)
			end
		end

	new_feature_as (f: EIFFEL_LIST [FEATURE_NAME]; b: BODY_AS; i: INDEXING_CLAUSE_AS): FEATURE_AS is
			-- New FEATURE AST node
		do
			if
				(f /= Void and then not f.is_empty) and b /= Void and
				(i = Void or else f.count = 1)
			then
				create Result.initialize (f, b, i, system.feature_as_counter.next_id)
				if b.is_unique then
					check
						system_initialized: system.current_class /= Void
					end
					system.current_class.set_has_unique
				end
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
			end
		end

end
