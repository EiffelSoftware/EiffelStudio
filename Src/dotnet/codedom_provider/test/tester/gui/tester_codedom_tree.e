indexing
	description: "Graphical codedom tree"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_CODEDOM_TREE

inherit
	EV_TREE

	TESTER_CONSTANTS
		export
			{NONE} all
		undefine
			copy,
			is_equal,
			default_create
		end

	TESTER_SHARED_TREE_STORE
		export
			{NONE} all
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make

feature {NON} -- Initialization

	make is
			-- Initialize tree from `Store'.
		do
			default_create
			update	
		end

feature -- Access

	Compile_units_node: EV_TREE_NODE is
			-- Compile units root tree node
		once
			create {EV_TREE_ITEM} Result.make_with_text ("Compile units")
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_compile_unit)
		end

	Namespaces_node: EV_TREE_NODE is
			-- Namespaces root tree node
		once
			create {EV_TREE_ITEM} Result.make_with_text ("Namespaces")
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_namespace)
		end

	Types_node: EV_TREE_NODE is
			-- Types root tree node
		once
			create {EV_TREE_ITEM} Result.make_with_text ("Types")
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_type)
		end

	Expressions_node: EV_TREE_NODE is
			-- Expressions root tree node
		once
			create {EV_TREE_ITEM} Result.make_with_text ("Expressions")
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
		end

	Statements_node: EV_TREE_NODE is
			-- Statements root tree node
		once
			create {EV_TREE_ITEM} Result.make_with_text ("Statements")
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
		end

	compile_unit_node (a_path: STRING; a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT; a_index: INTEGER): EV_DYNAMIC_TREE_ITEM is
			-- Namespace node for compile unit `a_compile_unit'.
		require
			non_void_path: a_path /= Void
			non_void_compile_unit: a_compile_unit /= Void
		do
			create Result.make_with_text ("Compile unit " + a_index.out)
			Result.set_subtree_function (agent compile_unit_namespaces_nodes (a_path, a_compile_unit))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_compile_unit)
			Result.set_tooltip (a_path)
			Result.set_data (a_compile_unit)
		end

	compile_unit_namespaces_nodes (a_path: STRING; a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT): LIST [EV_TREE_NODE] is
			-- Namespace node for compile unit `a_compile_unit'.
		require
			non_void_compile_unit: a_compile_unit /= Void
		local
			l_namespaces: SYSTEM_DLL_CODE_NAMESPACE_COLLECTION
			i, l_count: INTEGER
		do
			l_namespaces := a_compile_unit.namespaces
			l_count := l_namespaces.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			from
			until
				i = l_count
			loop
				Result.extend (namespace_node (a_path, l_namespaces.item (i)))
				i := i + 1
			end
		end

	namespace_node (a_path: STRING; a_namespace: SYSTEM_DLL_CODE_NAMESPACE): EV_DYNAMIC_TREE_ITEM is
			-- Namespace node for namespace `a_namespace'.
		require
			non_void_path: a_path /= Void
			non_void_namespace: a_namespace /= Void
		do
			create Result.make_with_text (a_namespace.name)
			Result.set_subtree_function (agent namespace_types_nodes (a_path, a_namespace))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_namespace)
			Result.set_tooltip (a_path)
			Result.set_data (a_namespace)
		end
	
	namespace_types_nodes (a_path: STRING; a_namespace: SYSTEM_DLL_CODE_NAMESPACE): LIST [EV_TREE_NODE] is
			-- Types node for namespace `a_namespace'.
		require
			non_void_namespace: a_namespace /= Void
		local
			l_types: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION
			i, l_count: INTEGER
		do
			l_types := a_namespace.types
			l_count := l_types.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			from
			until
				i = l_count
			loop
				Result.extend (type_node (a_path, l_types.item (i)))
				i := i + 1
			end
		end
	
	type_node (a_path: STRING; a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION): EV_DYNAMIC_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_type: a_type /= Void
		do
			create Result.make_with_text (a_type.name)
			Result.set_subtree_function (agent type_members_nodes (a_path, a_type))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			Result.set_tooltip (a_path)
			Result.set_data (a_type)
		end

	type_members_nodes (a_path: STRING; a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION): LIST [EV_TREE_NODE] is
			-- Types node for type `a_type'.
		require
			non_void_type: a_type /= Void
		local
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
			i, l_count: INTEGER
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
		do
			l_members := a_type.members
			quick_sort (l_members)
			l_count := l_members.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			from
			until
				i = l_count
			loop
				l_method ?= l_members.item (i)
				if l_method /= Void then
					Result.extend (method_node (a_path, l_method))
				else
					l_property ?= l_members.item (i)
					if l_property /= Void then
						Result.extend (property_node (a_path, l_property))
					else
						Result.extend (member_node (a_path, l_members.item (i)))
					end
				end
				i := i + 1
			end
		end

	method_node (a_path: STRING; a_member: SYSTEM_DLL_CODE_MEMBER_METHOD): EV_DYNAMIC_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_member: a_member /= Void
		do
			create Result.make_with_text (a_member.name)
			Result.set_subtree_function (agent statements_nodes (a_path, a_member.statements))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make (a_member))
			Result.set_tooltip (a_path)
			Result.set_data (a_member)
		end

	property_node (a_path: STRING; a_member: SYSTEM_DLL_CODE_MEMBER_PROPERTY): EV_DYNAMIC_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_member: a_member /= Void
		do
			create Result.make_with_text (a_member.name)
			Result.set_subtree_function (agent property_statements_nodes (a_path, a_member))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make (a_member))
			Result.set_tooltip (a_path)
			Result.set_data (a_member)
		end

	member_node (a_path: STRING; a_member: SYSTEM_DLL_CODE_TYPE_MEMBER): EV_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_member: a_member /= Void
		do
			create Result.make_with_text (a_member.name)
			Result.set_pixmap (create {TESTER_TREE_ICON}.make (a_member))
			Result.set_tooltip (a_path)
			Result.set_data (a_member)
		end

	statement_node (a_path: STRING; a_statement: SYSTEM_DLL_CODE_STATEMENT): EV_DYNAMIC_TREE_ITEM is
			-- Statement node
		require
			non_void_statement: a_statement /= Void
			non_void_path: a_path /= Void
		local
			l_text: SYSTEM_STRING
		do
			l_text := a_statement.to_string
			create Result.make_with_text (l_text.substring (l_text.last_index_of ('.') + 1))
			Result.set_subtree_function (agent statement_expressions_node (a_path, a_statement))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			Result.set_tooltip (a_path)
			Result.set_data (a_statement)
		end

	expression_node (a_path: STRING; a_expression: SYSTEM_DLL_CODE_EXPRESSION): EV_TREE_ITEM is
			-- Expression node
		require
			non_void_expression: a_expression /= Void
			non_void_path: a_path /= Void
		local
			l_text: SYSTEM_STRING
		do
			l_text := a_expression.to_string
			create Result.make_with_text (l_text.substring (l_text.last_index_of ('.') + 1))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			Result.set_tooltip (a_path)
			Result.set_data (a_expression)
		end

	statements_nodes (a_path: STRING; a_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION): LIST [EV_TREE_NODE] is
			-- Statements nodes for method `a_method'.
		require
			non_void_statements: a_statements /= Void
		local
			i, l_count: INTEGER
		do
			l_count := a_statements.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			from
			until
				i = l_count
			loop
				Result.extend (statement_node (a_path, a_statements.item (i)))
				i := i + 1
			end
		end
	
	property_statements_nodes (a_path: STRING; a_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY): LIST [EV_TREE_NODE] is
			-- Statements nodes for method `a_method'.
		require
			non_void_property: a_property /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)
			if a_property.has_get then
				create l_node.make_with_text ("Property Getter Statements")
				l_node.set_tooltip (a_path)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make (a_property))
				l_node.set_data (a_property)
				l_node.append (statements_nodes (a_path, a_property.get_statements))
				Result.extend (l_node)
			end
			if a_property.has_set then
				create l_node.make_with_text ("Property Setter Statements")
				l_node.set_tooltip (a_path)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make (a_property))
				l_node.set_data (a_property)
				l_node.append (statements_nodes (a_path, a_property.set_statements))
				Result.extend (l_node)
			end
		end
	
	statement_expressions_node (a_path: STRING; a_statement: SYSTEM_DLL_CODE_STATEMENT): LIST [EV_TREE_NODE] is
			-- Statement title
		require
			non_void_statement: a_statement /= Void
		local
			l_assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT
			l_attach_event_statement: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT
			l_comment_statement: SYSTEM_DLL_CODE_COMMENT_STATEMENT
			l_condition_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT
			l_expression_statement: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT
			l_goto_statement: SYSTEM_DLL_CODE_GOTO_STATEMENT
			l_iteration_statement: SYSTEM_DLL_CODE_ITERATION_STATEMENT
			l_labeled_statement: SYSTEM_DLL_CODE_LABELED_STATEMENT
			l_method_return_statement: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT
			l_remove_event_statement: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT
			l_snippet_statement: SYSTEM_DLL_CODE_SNIPPET_STATEMENT
			l_throw_statement: SYSTEM_DLL_CODE_THROW_EXCEPTION_STATEMENT
			l_try_statement: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT
			l_variable_declaration_statement: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT
		do
			l_assign_statement ?= a_statement
			if l_assign_statement /= Void then
				Result := assign_statement_nodes (a_path, l_assign_statement)
			else
				l_attach_event_statement ?= a_statement
				if l_attach_event_statement /= Void then
					Result := attach_event_statement_nodes (a_path, l_attach_event_statement)
				else
					l_comment_statement ?= a_statement
					if l_comment_statement /= Void then
						Result := comment_statement_nodes (a_path, l_comment_statement)
					else
						l_condition_statement ?= a_statement
						if l_condition_statement /= Void then
							Result := condition_statement_nodes (a_path, l_condition_statement)
						else
							l_expression_statement ?= a_statement
							if l_expression_statement /= Void then
								Result := expression_statement_nodes (a_path, l_expression_statement)
							else
								l_goto_statement ?= a_statement
								if l_goto_statement /= Void then
									Result := goto_statement_nodes (a_path, l_goto_statement)
								else
									l_iteration_statement ?= a_statement
									if l_iteration_statement /= Void then
										Result := iteration_statement_nodes (a_path, l_iteration_statement)
									else
										l_labeled_statement ?= a_statement
										if l_labeled_statement /= Void then
											Result := labeled_statement_nodes (a_path, l_labeled_statement)
										else
											l_method_return_statement ?= a_statement
											if l_method_return_statement /= Void then
												Result := method_return_statement_nodes (a_path, l_method_return_statement)
											else
												l_remove_event_statement ?= a_statement
												if l_remove_event_statement /= Void then
													Result := remove_event_statement_nodes (a_path, l_remove_event_statement)
												else
													l_snippet_statement ?= a_statement
													if l_snippet_statement /= Void then
														Result := snippet_statement_nodes (a_path, l_snippet_statement)
													else
														l_throw_statement ?= a_statement
														if l_throw_statement /= Void then
															Result := throw_statement_nodes (a_path, l_throw_statement)
														else
															l_try_statement ?= a_statement
															if l_try_statement /= Void then
																Result := try_statement_nodes (a_path, l_try_statement)
															else
																l_variable_declaration_statement ?= a_statement
																if l_variable_declaration_statement /= Void then
																	Result := variable_declaration_statement_nodes (a_path, l_variable_declaration_statement)
																end
															end	
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

	assign_statement_nodes (a_path: STRING; a_assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for assign statement `a_assign_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_assign_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)
			create l_node.make_with_text ("Left Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_assign_statement)
			if a_assign_statement.left /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.extend (expression_node (a_path, a_assign_statement.left))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			create l_node.make_with_text ("Right Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_assign_statement)
			if a_assign_statement.right /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.extend (expression_node (a_path, a_assign_statement.right))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		end

	attach_event_statement_nodes (a_path: STRING; a_attach_event_statement: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `attach_event_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_attach_event_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)
			create l_node.make_with_text ("Event Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_attach_event_statement)
			if a_attach_event_statement.event /= Void then
				l_node.extend (expression_node (a_path, a_attach_event_statement.event))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			create l_node.make_with_text ("Listener Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_attach_event_statement)
			if a_attach_event_statement.listener /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.extend (expression_node (a_path, a_attach_event_statement.listener))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		end

	comment_statement_nodes (a_path: STRING; a_comment_statement: SYSTEM_DLL_CODE_COMMENT_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_comment_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_comment_statement /= Void
		local
			l_node: EV_TREE_ITEM
			l_text: STRING
			l_comment: SYSTEM_DLL_CODE_COMMENT
			l_pixmap: EV_PIXMAP
		do
			l_comment := a_comment_statement.comment
			if l_comment /= Void and then l_comment.text /= Void then
				if l_comment.doc_comment then
					l_text := "--"
				else
					l_text := "|--"
				end
				l_text.append (l_comment.text)
				l_pixmap := create {TESTER_TREE_ICON}.make_statement
			else
				l_text := "Missing Comment"
				l_pixmap := create {TESTER_TREE_ICON}.make_error
			end
			create l_node.make_with_text (l_text)
			l_node.set_tooltip (a_path)
			l_node.set_pixmap (l_pixmap)
			l_node.set_data (a_comment_statement)
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			Result.extend (l_node)
		end

	condition_statement_nodes (a_path: STRING; a_condition_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_condition_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_condition_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (3)
			create l_node.make_with_text ("Condition Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_condition_statement)
			if a_condition_statement.condition /= Void then
				l_node.extend (expression_node (a_path, a_condition_statement.condition))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			if a_condition_statement.true_statements /= Void then
				create l_node.make_with_text ("True Statements")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_condition_statement)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.append (statements_nodes (a_path, a_condition_statement.true_statements))
				Result.extend (l_node)
			end
			if a_condition_statement.false_statements /= Void then
				create l_node.make_with_text ("False Statements")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_condition_statement)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.append (statements_nodes (a_path, a_condition_statement.false_statements))
				Result.extend (l_node)
			end
		end

	expression_statement_nodes (a_path: STRING; a_expression_statement: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_expression_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_expression_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			if a_expression_statement.expression /= Void then
				Result := expression_node (a_path, a_expression_statement.expression)
			else
				create l_node.make_with_text ("Missing Expression")
				l_node.set_tooltip (a_path)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
				l_node.set_data (a_expression_statement)
				Result.extend (l_node)
			end
		end

	goto_statement_nodes (a_path: STRING; a_goto_statement: SYSTEM_DLL_CODE_GOTO_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_goto_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_goto_statement /= Void
		local
			l_node: EV_TREE_ITEM
			l_text, l_label: STRING
			l_pixmap: EV_PIXMAP
		do
			l_label := a_goto_statement.label
			if l_label /= Void then
				l_text := "Label: "
				l_text.append (l_label)
				l_pixmap := create {TESTER_TREE_ICON}.make_statement
			else
				l_text := "Missing Label"
				l_pixmap := create {TESTER_TREE_ICON}.make_error
			end
			create l_node.make_with_text (l_text)
			l_node.set_tooltip (a_path)
			l_node.set_pixmap (l_pixmap)
			l_node.set_data (a_goto_statement)
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			Result.extend (l_node)			
		end

	iteration_statement_nodes (a_path: STRING; a_iteration_statement: SYSTEM_DLL_CODE_ITERATION_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_iteration_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_iteration_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (4)
			if a_iteration_statement.init_statement /= Void then
				create l_node.make_with_text ("Initialization Statement")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_iteration_statement)
				l_node.extend (statement_node (a_path, a_iteration_statement.init_statement))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				Result.extend (l_node)
			end
			create l_node.make_with_text ("Test Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_iteration_statement)
			if a_iteration_statement.test_expression /= Void then
				l_node.extend (expression_node (a_path, a_iteration_statement.test_expression))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			if a_iteration_statement.statements /= Void then
				create l_node.make_with_text ("Loop Statements")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_iteration_statement)
				l_node.append (statements_nodes (a_path, a_iteration_statement.statements))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				Result.extend (l_node)
			end
			create l_node.make_with_text ("Increment Statement")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_iteration_statement)
			if a_iteration_statement.increment_statement /= Void then
				l_node.extend (statement_node (a_path, a_iteration_statement.increment_statement))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		end

	labeled_statement_nodes (a_path: STRING; a_labeled_statement: SYSTEM_DLL_CODE_LABELED_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_labeled_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_labeled_statement /= Void
		local
			l_node: EV_TREE_ITEM
			l_text, l_label: STRING
			l_pixmap: EV_PIXMAP
		do
			l_label := a_labeled_statement.label
			if l_label /= Void then
				l_text := "Label: "
				l_text.append (l_label)
				l_pixmap := create {TESTER_TREE_ICON}.make_statement
			else
				l_text := "Missing Label"
				l_pixmap := create {TESTER_TREE_ICON}.make_error
			end
			create l_node.make_with_text (l_text)
			l_node.set_tooltip (a_path)
			l_node.set_pixmap (l_pixmap)
			l_node.set_data (a_labeled_statement)
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			Result.extend (l_node)
			if a_labeled_statement.statement /= Void then
				create l_node.make_with_text ("Statement")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_labeled_statement)
				l_node.extend (statement_node (a_path, a_labeled_statement.statement))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				Result.extend (l_node)
			end
		end

	method_return_statement_nodes (a_path: STRING; a_method_return_statement: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_method_return_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_method_return_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			if a_method_return_statement.expression /= Void then
				Result := expression_node (a_path, a_method_return_statement.expression)
			else
				create l_node.make_with_text ("Missing Expression")
				l_node.set_tooltip (a_path)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
				l_node.set_data (a_method_return_statement)
				Result.extend (l_node)
			end
		end

	remove_event_statement_nodes (a_path: STRING; a_remove_event_statement: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_remove_event_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_remove_event_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)
			create l_node.make_with_text ("Event Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_remove_event_statement)
			if a_remove_event_statement.event /= Void then
				l_node.extend (expression_node (a_path, a_remove_event_statement.event))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			create l_node.make_with_text ("Listener Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_remove_event_statement)
			if a_remove_event_statement.listener /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.extend (expression_node (a_path, a_remove_event_statement.listener))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		end

	snippet_statement_nodes (a_path: STRING; a_snippet_statement: SYSTEM_DLL_CODE_SNIPPET_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_snippet_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_snippet_statement /= Void
		local
			l_node: EV_TREE_ITEM
			l_text: STRING
			l_pixmap: EV_PIXMAP
		do
			if a_snippet_statement.value /= Void then
				l_text := a_snippet_statement.value
			end
			if l_text /= Void then
				l_text.keep_head (20)
				l_text.append ("...")
				l_pixmap := create {TESTER_TREE_ICON}.make_statement
			else
				l_text := "Missing Snippet"
				l_pixmap := create {TESTER_TREE_ICON}.make_error
			end
			create l_node.make_with_text (l_text)
			l_node.set_tooltip (a_path)
			l_node.set_pixmap (l_pixmap)
			l_node.set_data (a_snippet_statement)
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			Result.extend (l_node)
		end

	throw_statement_nodes (a_path: STRING; a_throw_statement: SYSTEM_DLL_CODE_THROW_EXCEPTION_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_assign_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_throw_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			if a_throw_statement.to_throw /= Void then
				Result := expression_node (a_path, a_throw_statement.to_throw)
			else
				create l_node.make_with_text ("Missing Expression")
				l_node.set_tooltip (a_path)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
				l_node.set_data (a_throw_statement)
				Result.extend (l_node)
			end
		end

	try_statement_nodes (a_path: STRING; a_try_statement: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_try_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_try_statement /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (3)
			if a_try_statement.try_statements /= Void then
				create l_node.make_with_text ("Try Statements")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_try_statement)
				l_node.append (statements_nodes (a_path, a_try_statement.try_statements))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				Result.extend (l_node)
			end
			create l_node.make_with_text ("Catch Clauses")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_try_statement)
			if a_try_statement.catch_clauses /= Void then
				l_node.append (catch_clauses_nodes (a_path, a_try_statement.catch_clauses))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			if a_try_statement.finally_statements /= Void then
				create l_node.make_with_text ("Finally Statements")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_try_statement)
				l_node.append (statements_nodes (a_path, a_try_statement.finally_statements))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				Result.extend (l_node)
			end
		end

	variable_declaration_statement_nodes (a_path: STRING; a_variable_declaration_statement: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT): LIST [EV_TREE_NODE] is
			-- Nodes for statement `a_variable_declaration_statement'
		require
			non_void_path: a_path /= Void
			non_void_statement: a_variable_declaration_statement /= Void
		local
			l_text: STRING
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (3)
			l_text := "Name: "
			if a_variable_declaration_statement.name /= Void then
				create l_node.make_with_text (l_text + a_variable_declaration_statement.name)
				l_node.set_tooltip (a_path)
				l_node.set_data (a_variable_declaration_statement)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			else
				create l_node.make_with_text ("Missing Name")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_variable_declaration_statement)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			l_text := "Type: "
			if a_variable_declaration_statement.type /= Void and then a_variable_declaration_statement.type.base_type /= Void then
				create l_node.make_with_text (l_text + a_variable_declaration_statement.type.base_type)
				l_node.set_tooltip (a_path)
				l_node.set_data (a_variable_declaration_statement)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				create l_node.make_with_text ("Missing Type")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_variable_declaration_statement)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			if a_variable_declaration_statement.init_expression /= Void then
				create l_node.make_with_text ("Init Expression")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_variable_declaration_statement)
				l_node.append (expression_node (a_path, a_variable_declaration_statement.init_expression))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				Result.extend (l_node)
			end
		end

	catch_clauses_nodes (a_path: STRING; a_catch_clauses: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION): LIST [EV_TREE_NODE] is
			-- Catch clauses nodes
		require
			non_void_catch_clauses: a_catch_clauses /= Void
		local
			i, l_count: INTEGER
		do
			from
				l_count := a_catch_clauses.count
				create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			until
				i = l_count
			loop
				Result.extend (catch_clause_node (a_path, a_catch_clauses.item (i)))
				i := i + 1
			end
		end
	
	catch_clause_node (a_path: STRING; a_catch_clause: SYSTEM_DLL_CODE_CATCH_CLAUSE): EV_TREE_ITEM is
			-- Catch clause node
		local
			l_node: EV_TREE_ITEM
			l_text: STRING
		do
			create Result.make_with_text ("Catch Clause")
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
			Result.set_data (a_catch_clause)
			Result.set_tooltip (a_path)
			if a_catch_clause.catch_exception_type /= Void then
				if a_catch_clause.catch_exception_type.base_type /= Void then
					create l_node.make_with_text ("Type: " + a_catch_clause.catch_exception_type.base_type)
					l_node.set_data (a_catch_clause)
					l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
					l_node.set_tooltip (a_path)
				else
					create l_node.make_with_text ("Missing Type Name")
					l_node.set_data (a_catch_clause)
					l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
					l_node.set_tooltip (a_path)
				end
				Result.extend (l_node)
			end
			if a_catch_clause.local_name /= Void then
				create l_node.make_with_text ("Name: " + a_catch_clause.local_name)
				l_node.set_data (a_catch_clause)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.set_tooltip (a_path)
				Result.extend (l_node)
			end
			if a_catch_clause.statements /= Void then
				create l_node.make_with_text ("Statements")
				l_node.set_data (a_catch_clause)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_statement)
				l_node.set_tooltip (a_path)
				l_node.append (statements_nodes (a_path, a_catch_clause.statements))
				Result.extend (l_node)
			end
		end

feature -- Basic Operations

	update is
			-- Update codedoms tree.
		local
			l_node: EV_TREE_ITEM
			i: INTEGER
		do
			wipe_out
			Compile_units_node.wipe_out
			Namespaces_node.wipe_out
			Types_node.wipe_out
			Expressions_node.wipe_out
			Statements_node.wipe_out
			if store.compile_units /= Void then
				from
					i := 1
					store.compile_units.start
					store.compile_units_paths.start
				until
					store.compile_units.after
				loop
					Compile_units_node.extend (compile_unit_node (store.compile_units_paths.item, store.compile_units.item, i))
					store.compile_units.forth
					store.compile_units_paths.forth
					i := i + 1
				end
				extend (Compile_units_node)
				Compile_units_node.expand
			end
			if store.namespaces /= Void then
				from
					store.namespaces.start
					store.namespaces_paths.start
				until
					store.namespaces.after
				loop
					Namespaces_node.extend (namespace_node (store.namespaces_paths.item, store.namespaces.item))
					store.namespaces.forth
					store.namespaces_paths.forth
				end
				extend (Namespaces_node)
				Namespaces_node.expand
			end
			if store.types /= Void then
				from
					store.types.start
					store.types_paths.start
				until
					store.types.after
				loop
					Types_node.extend (type_node (store.types_paths.item, store.types.item))
					store.types.forth
					store.types_paths.forth
				end
				extend (Types_node)
				Types_node.expand
			end
			if store.expressions /= Void then
				from
					store.expressions.start
					store.expressions_paths.start
				until
					store.expressions.after
				loop
					create l_node.make_with_text ("Expression " + store.expressions.index.out)
					l_node.set_pixmap (Expression_png)
					l_node.set_tooltip (store.expressions_paths.item)
					l_node.set_data (store.expressions.item)
					Expressions_node.extend (l_node)
					store.expressions.forth
					store.expressions_paths.forth
				end
				extend (Expressions_node)
				Expressions_node.expand
			end
			if store.statements /= Void then
				from
					store.statements.start
					store.statements_paths.start
				until
					store.statements.after
				loop
					create l_node.make_with_text ("Statement " + store.expressions.index.out)
					l_node.set_pixmap (Statement_png)
					l_node.set_tooltip (store.statements_paths.item)
					l_node.set_data (store.statements.item)
					Statements_node.extend (l_node)
					store.statements.forth
					store.statements_paths.forth
				end
				extend (Statements_node)
				Statements_node.expand
			end
		end

feature {NONE} -- Implementation

	quick_sort (a_collection: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION) is
			-- Set `collection' with `a_collection'.
		require
			non_void_collection: a_collection /= Void
		local
			l, u, m, i, n: INTEGER
			pivot, lv, uv, temp: SYSTEM_DLL_CODE_TYPE_MEMBER
			a_lower, a_upper: INTEGER
			lowers, uppers: ARRAY [INTEGER]
		do
			from
				n := a_collection.count
			until
				n = 0
			loop
				n := n // 2
				i := i + 1
			end
			i := i + 10
			from
				create lowers.make (1, i)
				create uppers.make (1, i)
				lowers.put (0, 1)
				uppers.put (a_collection.count - 1, 1)
				i := 1
			until
				i = 0
			loop
				a_lower := lowers.item (i)
				a_upper := uppers.item (i)
				i := i - 1
				l := a_lower
				u := a_upper
				if l < u then
					if u = l + 1 then
						lv := a_collection.item (l)
						uv := a_collection.item (u)
						if feature {SYSTEM_STRING}.compare (uv.name, lv.name) < 0 then
							a_collection.set_item (u, lv)
							a_collection.set_item (l, uv)
						end
					else
						m := (l + u) // 2
						pivot := a_collection.item (m)
						a_collection.set_item (m, a_collection.item (a_upper))
						from until l >= u loop
							from
							until
								l >= u or else feature {SYSTEM_STRING}.compare (a_collection.item (l).name, pivot.name) >= 0
							loop
								l := l + 1
							end
							from
								u := u - 1
							until
								u <= l or else feature {SYSTEM_STRING}.compare (pivot.name, a_collection.item (u).name) >= 0
							loop
								u := u - 1
							end
							if l < u then
								temp := a_collection.item (l)
								a_collection.set_item (l, a_collection.item (u))
								a_collection.set_item (u, temp)
								l := l + 1
							end
						end
						a_collection.set_item (a_upper, a_collection.item (l))
						a_collection.set_item (l, pivot)
						if l - 1 > a_lower then
							i := i + 1
							lowers.force (a_lower, i)
							uppers.force (l - 1, i)
						end
						if l + 1 < a_upper then
							i := i + 1
							lowers.force (l + 1, i)
							uppers.force (a_upper, i)
						end
					end
				end
			end
		end

end -- class TESTER_CODEDOM_TREE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------