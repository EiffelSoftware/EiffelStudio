deferred class SPECIAL_PARSER 

inherit
	SHARED_ERROR_HANDLER;
	EIFFEL_YACC_CONST;
	MEMORY

feature -- context
	
	new_adapter: FEAT_ADAPTATION is
			-- copy of a FEAT_ADAPTATION corresponding to context
		deferred
		end;

	processed_features: LINKED_LIST [INTEGER] is
			-- features already processed
		deferred
		end;

	--assert_server: ASSERT_SERVER is
	--		-- management of chained pre and post conditions
	--	deferred
	--	end;

feature {FLAT_CONTEXT} -- parser

	parse: CLASS_AS is
		local
			file: RAW_FILE;
			class_file_name: STRING;
--			vd21: VD21;
		do
--			class_file_name := current_class.file_name;
			!!class_file_name.make (0)
			!!file.make (class_file_name);
			if not (file.exists and then file.is_readable and then
					file.is_plain)
			then
--				!!vd21;
--				vd21.set_cluster (current_class.cluster);
--				vd21.set_file_name (current_class.file_name);
--				Error_handler.insert_error (vd21);
				Error_handler.raise_error;
			end;
			!!comments_server.make (file);
			file.open_read;
			collection_off;
			Result := c_parse (file.file_pointer, $class_file_name);
			collection_on;
			file.close;
--		rescue
--			if Rescue_status.is_error_exception then
--					-- Error happened 
--				collection_on;
--				if not (file = Void or else file.is_closed) then
--					file.close;
--				end;
--			end;
		end;		
				
--		current_class: CLASS_C;

		comments_server: EIFFEL_FILE;

    reset_ast_classes is
        local
            as76: TAGGED_AS;
            as82: ROUTINE_AS;
            as83: EXTERNAL_AS;
            as86: FEATURE_AS;
            as88: INVARIANT_AS;
            as94: REQUIRE_AS;
            as95: REQUIRE_ELSE_AS;
            as96: ENSURE_AS;
            as97: ENSURE_THEN_AS;
            as98: FEATURE_CLAUSE_AS;
        do
            !!as76;
            as76.pass_address (tagged_as);
            !!as82;
            as82.pass_address (routine_as);
            !!as83;
            as83.pass_address (external_as);
            !!as86;
            as86.pass_address (feature_as);
            !!as88;
            as88.pass_address (invariant_as);
            !!as94;
            as94.pass_address (require_as);
            !!as95;
            as95.pass_address (require_else_as);
            !!as96;
            as96.pass_address (ensure_as);
            !!as97;
            as97.pass_address (ensure_then_as);
            !!as98;
            as98.pass_address (feature_clause_as);
        end;

feature {NONE}   -- external

    c_parse (f: POINTER; s: POINTER): CLASS_AS is
        external
            "C"
        end;

						
end
