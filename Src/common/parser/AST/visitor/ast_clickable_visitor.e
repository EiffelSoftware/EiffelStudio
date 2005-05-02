indexing
	description: "Visitor to compute CLICK_LIST"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CLICKABLE_VISITOR

inherit
	AST_ITERATOR
		redefine
			process_address_as,
			process_feature_as,
			process_infix_prefix_as,
			process_feat_name_id_as,
			process_feature_name_alias_as,
			process_class_as,
			process_class_type_as,
			process_rename_as,
			process_client_as,
			process_convert_feat_as
		end
	
	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Clickable

	click_list (a_class: CLASS_AS): CLICK_LIST is
			-- Associated `click_list' of `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			create internal_click_list.make (100)
			process_class_as (a_class)
			Result := internal_click_list
		end

feature {NONE} -- Access

	internal_click_list: CLICK_LIST
			-- Storage while visiting nodes for new click_list element.

feature {NONE} -- Implementation

	process_address_as (l_as: ADDRESS_AS) is
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.feature_name, l_as.feature_name)
			internal_click_list.extend (l_click_ast)
		end

	process_feature_as (l_as: FEATURE_AS) is
		local
			l_fnames: EIFFEL_LIST [FEATURE_NAME]
			l_click_ast: CLICK_AST
			l_first: BOOLEAN
		do
			from
				l_fnames := l_as.feature_names
				l_fnames.start
				l_first := True
			until
				l_fnames.after
			loop
				if l_first then
					create l_click_ast.initialize (l_fnames.item, l_as)
					l_first := False
				else
					create l_click_ast.initialize (l_fnames.item, l_fnames.item)
				end
				internal_click_list.extend (l_click_ast)
				l_fnames.forth
			end
			l_as.body.process (Current)
			if l_as.indexes /= Void then
				l_as.indexes.process (Current)
			end
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as, l_as)
			internal_click_list.extend (l_click_ast)
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as, l_as)
			internal_click_list.extend (l_click_ast)
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as, l_as)
			internal_click_list.extend (l_click_ast)
		end

	process_class_as (l_as: CLASS_AS) is
		local
			l_click_ast: CLICK_AST
		do
			safe_process (l_as.top_indexes)

			create l_click_ast.initialize (l_as.class_name, l_as)
			internal_click_list.extend (l_click_ast)
			safe_process (l_as.generics)
			
			safe_process (l_as.parents)
			safe_process (l_as.creators)
			safe_process (l_as.convertors)
			safe_process (l_as.features)
			safe_process (l_as.invariant_part)
			safe_process (l_as.bottom_indexes)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.class_name, l_as)
			internal_click_list.extend (l_click_ast)
			safe_process (l_as.generics)
		end

	process_rename_as (l_as: RENAME_AS) is
		local
			l_click_ast: CLICK_AST
		do
				-- For `old_name' we use `new_name' as node to follow what
				-- we were doing before even though it does not make much sense
				-- to do that.
			create l_click_ast.initialize (l_as.old_name, l_as.new_name)
			internal_click_list.extend (l_click_ast)
			
			create l_click_ast.initialize (l_as.new_name, l_as.new_name)
			internal_click_list.extend (l_click_ast)
		end

	process_client_as (l_as: CLIENT_AS) is
		local
			l_clients: EIFFEL_LIST [ID_AS]
			l_click_ast: CLICK_AST
		do
			from
				l_clients := l_as.clients
				l_clients.start
			until
				l_clients.after
			loop
				create l_click_ast.initialize (l_clients.item,
					create {CLASS_TYPE_AS}.initialize (l_clients.item, Void, False, False))
				internal_click_list.extend (l_click_ast)
				l_clients.forth
			end
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.feature_name, l_as.feature_name)
			internal_click_list.extend (l_click_ast)
			l_as.conversion_types.process (Current)
		end
		
end
