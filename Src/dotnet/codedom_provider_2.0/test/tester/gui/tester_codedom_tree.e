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
			l_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
		do
			l_attributes := a_compile_unit.assembly_custom_attributes
			l_namespaces := a_compile_unit.namespaces
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_namespaces.count + l_attributes.count)
			from
				l_count := l_attributes.count
			until
				i = l_count
			loop
				Result.extend (custom_attribute_node (a_path, l_attributes.item (i)))
				i := i + 1
			end
			from
				i := 0
				l_count := l_namespaces.count
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
			l_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
		do
			l_attributes := a_type.custom_attributes
			l_members := a_type.members
			quick_sort (l_members)
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_members.count + l_attributes.count)
			from
				l_count := l_attributes.count
			until
				i = l_count
			loop
				Result.extend (custom_attribute_node (a_path, l_attributes.item (i)))
				i := i + 1
			end
			from
				l_count := l_members.count
				i := 0
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

	custom_attribute_node (a_path: STRING; a_attribute: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION): EV_DYNAMIC_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_attribute: a_attribute /= Void
		do
			create Result.make_with_text (a_attribute.name)
			Result.set_subtree_function (agent custom_attribute_arguments_nodes (a_path, a_attribute.arguments))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_custom_attribute)
			Result.set_tooltip (a_path)
			Result.set_data (a_attribute)
		end

	line_pragma_node (a_path: STRING; a_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA): EV_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_attribute: a_pragma /= Void
		do
			create Result.make_with_text (a_pragma.file_name + " @ " + a_pragma.line_number.out)
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_pragma)
			Result.set_tooltip (a_path)
			Result.set_data (a_pragma)
		end

	method_node (a_path: STRING; a_member: SYSTEM_DLL_CODE_MEMBER_METHOD): EV_DYNAMIC_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_member: a_member /= Void
		do
			create Result.make_with_text (a_member.name)
			Result.set_subtree_function (agent method_nodes (a_path, a_member))
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

	member_node (a_path: STRING; a_member: SYSTEM_DLL_CODE_TYPE_MEMBER): EV_DYNAMIC_TREE_ITEM is
			-- Type node for type `a_type'.
		require
			non_void_path: a_path /= Void
			non_void_member: a_member /= Void
		do
			create Result.make_with_text (a_member.name)
			Result.set_pixmap (create {TESTER_TREE_ICON}.make (a_member))
			Result.set_subtree_function (agent member_nodes (a_path, a_member))
			Result.set_tooltip (a_path)
			Result.set_data (a_member)
		end

	custom_attribute_argument_node (a_path: STRING; a_argument: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT): EV_DYNAMIC_TREE_ITEM is
			-- Custom attribute argument node
		require
			non_void_argument: a_argument /= Void
			non_void_path: a_path /= Void
		do
			create Result.make_with_text (a_argument.name)
			Result.set_subtree_function (agent expression_nodes (a_path, a_argument.value))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_custom_attribute)
			Result.set_tooltip (a_path)
			Result.set_data (a_argument)
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

	expression_node (a_path: STRING; a_expression: SYSTEM_DLL_CODE_EXPRESSION): EV_DYNAMIC_TREE_ITEM is
			-- Expression node
		require
			non_void_expression: a_expression /= Void
			non_void_path: a_path /= Void
		local
			l_text: SYSTEM_STRING
		do
			l_text := a_expression.to_string
			create Result.make_with_text (l_text.substring (l_text.last_index_of ('.') + 1))
			Result.set_subtree_function (agent expression_nodes (a_path, a_expression))
			Result.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			Result.set_tooltip (a_path)
			Result.set_data (a_expression)
		end

	custom_attribute_arguments_nodes (a_path: STRING;  a_arguments: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT_COLLECTION): LIST [EV_TREE_NODE] is
			-- Arguments nodes for custom attribute.
		require
			non_void_argumentss: a_arguments /= Void
		local
			i, l_count: INTEGER
		do
			l_count := a_arguments.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			from
			until
				i = l_count
			loop
				Result.extend (custom_attribute_argument_node (a_path, a_arguments.item (i)))
				i := i + 1
			end
		end

	method_nodes (a_path: STRING; a_member: SYSTEM_DLL_CODE_MEMBER_METHOD): LIST [EV_TREE_NODE] is
			-- Nodes for method `a_member'
		local
			l_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
			l_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			i, l_count: INTEGER
		do
			l_attributes := a_member.custom_attributes
			l_statements := a_member.statements
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_attributes.count + l_statements.count)
			from
				l_count := l_attributes.count
			until
				i = l_count
			loop
				Result.extend (custom_attribute_node (a_path, l_attributes.item (i)))
				i := i + 1
			end
			Result.append (statements_nodes (a_path, l_statements))
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

	expressions_nodes (a_path: STRING; a_expressions: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION): LIST [EV_TREE_NODE] is
			-- Statements nodes for method `a_method'.
		require
			non_void_expressions: a_expressions /= Void
		local
			i, l_count: INTEGER
		do
			l_count := a_expressions.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count)
			from
			until
				i = l_count
			loop
				Result.extend (expression_node (a_path, a_expressions.item (i)))
				i := i + 1
			end
		end

	property_statements_nodes (a_path: STRING; a_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY): LIST [EV_TREE_NODE] is
			-- Statements nodes for method `a_method'.
		require
			non_void_property: a_property /= Void
		local
			l_node: EV_TREE_ITEM
			l_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
			i, l_count: INTEGER
		do
			l_attributes := a_property.custom_attributes
			l_count := l_attributes.count
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (l_count + 2)
			from
			until
				i = l_count
			loop
				Result.extend (custom_attribute_node (a_path, l_attributes.item (i)))
				i := i + 1
			end
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

	member_nodes (a_path: STRING; a_member: SYSTEM_DLL_CODE_TYPE_MEMBER): LIST [EV_TREE_NODE] is
			-- Statements nodes for member `a_member'.
		require
			non_void_member: a_member /= Void
		do
			if a_member.line_pragma /= Void then
				create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
				Result.extend (line_pragma_node (a_path, a_member.line_pragma))
			else
				create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (0)
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
			if Result /= Void and a_statement.line_pragma /= Void then
				Result.extend (line_pragma_node (a_path, a_statement.line_pragma))
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
				l_node.extend (expression_node (a_path, a_assign_statement.left))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			create l_node.make_with_text ("Right Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_assign_statement)
			if a_assign_statement.right /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
			create l_node.make_with_text ("Listener Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_attach_event_statement)
			if a_attach_event_statement.listener /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
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
				Result.extend (expression_node (a_path, a_method_return_statement.expression))
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
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
				if l_text.count > 20 then
					l_text.keep_head (20)
					l_text.append ("...")
				end
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_variable)
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
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
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_variable)
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

	expression_nodes (a_path: STRING; a_expression: SYSTEM_DLL_CODE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Statement title
		require
			non_void_expression: a_expression /= Void
		local
			l_argument_expression: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION
			l_array_create_expression: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION
			l_array_indexer_expression: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION
			l_base_expression: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION
			l_binary_operator_expression: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION
			l_cast_expression: SYSTEM_DLL_CODE_CAST_EXPRESSION
			l_delegate_create_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
			l_delegate_invoke_expression: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION
			l_direction_expression: SYSTEM_DLL_CODE_DIRECTION_EXPRESSION
			l_event_expression: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION
			l_field_expression: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
			l_indexer_expression: SYSTEM_DLL_CODE_INDEXER_EXPRESSION
			l_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
			l_method_reference_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			l_object_create_expression: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION
			l_parameter_declaration_expression: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
			l_primitive_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
			l_property_reference_expression: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
			l_property_set_value_reference_expression: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
			l_this_expression: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION
			l_type_of_expression: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION
			l_type_reference_expression: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION
			l_variable_reference_expression: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
		do
			l_argument_expression ?= a_expression
			if l_argument_expression /= Void then
				Result := argument_expression_nodes (a_path, l_argument_expression)
			else
				l_array_create_expression ?= a_expression
				if l_array_create_expression /= Void then
					Result := array_create_expression_nodes (a_path, l_array_create_expression)
				else
					l_array_indexer_expression ?= a_expression
					if l_array_indexer_expression /= Void then
						Result := array_indexer_expression_nodes (a_path, l_array_indexer_expression)
					else
						l_base_expression ?= a_expression
						if l_base_expression /= Void then
							Result := base_expression_nodes (a_path, l_base_expression)
						else
							l_binary_operator_expression ?= a_expression
							if l_binary_operator_expression /= Void then
								Result := binary_operator_expression_nodes (a_path, l_binary_operator_expression)
							else
								l_cast_expression ?= a_expression
								if l_cast_expression /= Void then
									Result := cast_expression_nodes (a_path, l_cast_expression)
								else
									l_delegate_create_expression ?= a_expression
									if l_delegate_create_expression /= Void then
										Result := delegate_create_expression_nodes (a_path, l_delegate_create_expression)
									else
										l_delegate_invoke_expression ?= a_expression
										if l_delegate_invoke_expression /= Void then
											Result := delegate_invoke_expression_nodes (a_path, l_delegate_invoke_expression)
										else
											l_direction_expression ?= a_expression
											if l_direction_expression /= Void then
												Result := direction_expression_nodes (a_path, l_direction_expression)
											else
												l_event_expression ?= a_expression
												if l_event_expression /= Void then
													Result := event_expression_nodes (a_path, l_event_expression)
												else
													l_field_expression ?= a_expression
													if l_field_expression /= Void then
														Result := field_expression_nodes (a_path, l_field_expression)
													else
														l_indexer_expression ?= a_expression
														if l_indexer_expression /= Void then
															Result := indexer_expression_nodes (a_path, l_indexer_expression)
														else
															l_method_invoke_expression ?= a_expression
															if l_method_invoke_expression /= Void then
																Result := method_invoke_expression_nodes (a_path, l_method_invoke_expression)
															else
																l_method_reference_expression ?= a_expression
																if l_method_reference_expression /= Void then
																	Result := method_reference_expression_nodes (a_path, l_method_reference_expression)
																else
																	l_object_create_expression ?= a_expression
																	if l_object_create_expression /= Void then
																		Result := object_create_expression_nodes (a_path, l_object_create_expression)
																	else
																		l_parameter_declaration_expression ?= a_expression
																		if l_parameter_declaration_expression /= Void then
																			Result := parameter_declaration_expression_nodes (a_path, l_parameter_declaration_expression)
																		else
																			l_primitive_expression ?= a_expression
																			if l_primitive_expression /= Void then
																				Result := primitive_expression_nodes (a_path, l_primitive_expression)
																			else
																				l_property_reference_expression ?= a_expression
																				if l_property_reference_expression /= Void then
																					Result := property_reference_expression (a_path, l_property_reference_expression)
																				else
																					l_property_set_value_reference_expression ?= a_expression
																					if l_property_set_value_reference_expression /= Void then
																						Result := property_set_value_reference_expression_nodes (a_path, l_property_set_value_reference_expression)
																					else
																						l_snippet_expression ?= a_expression
																						if l_snippet_expression /= Void then
																							Result := snippet_expression_nodes (a_path, l_snippet_expression)
																						else
																							l_this_expression ?= a_expression
																							if l_this_expression /= Void then
																								Result := this_expression_nodes (a_path, l_this_expression)
																							else
																								l_type_of_expression ?= a_expression
																								if l_type_of_expression /= Void then
																									Result := type_of_expression_nodes (a_path, l_type_of_expression)
																								else
																									l_type_reference_expression ?= a_expression
																									if l_type_reference_expression /= Void then
																										Result := type_reference_expression_nodes (a_path, l_type_reference_expression)
																									else
																										l_variable_reference_expression ?= a_expression
																										if l_variable_reference_expression /= Void then
																											Result := variable_reference_expression_nodes (a_path, l_variable_reference_expression)
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

	argument_expression_nodes (a_path: STRING; a_argument_expression: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_argument_expression'
		require
			non_void_argument_expression: a_argument_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			if a_argument_expression.parameter_name /= Void then
				create l_node.make_with_text (a_argument_expression.parameter_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_argument)
			else
				create l_node.make_with_text ("Missing parameter name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			l_node.set_tooltip (a_path)
			l_node.set_data (a_argument_expression)
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	array_create_expression_nodes (a_path: STRING; a_array_create_expression: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_array_create_expression'
		require
			non_void_array_create_expression: a_array_create_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
			l_type: STRING
			l_pixmap: EV_PIXMAP
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (4)

			if a_array_create_expression.create_type /= Void and then a_array_create_expression.create_type.array_element_type /= Void and then a_array_create_expression.create_type.array_element_type.base_type /= Void then
				l_type := "Array Type: "
				l_type.append (a_array_create_expression.create_type.array_element_type.base_type)
				create {TESTER_TREE_ICON} l_pixmap.make_type
			else
				l_type := "Missing Array Type"
				create {TESTER_TREE_ICON} l_pixmap.make_error
			end
			create l_node.make_with_text (l_type)
			l_node.set_tooltip (a_path)
			l_node.set_data (a_array_create_expression)
			l_node.set_pixmap (l_pixmap)
			Result.extend (l_node)

			if a_array_create_expression.initializers /= Void then
				create l_node.make_with_text ("Initializers")
				l_node.set_tooltip (a_path)
				l_node.append (expressions_nodes (a_path, a_array_create_expression.initializers))
				l_node.set_data (a_array_create_expression)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
				Result.extend (l_node)
			end

			create l_node.make_with_text ("Size: " + a_array_create_expression.size.out)
			l_node.set_tooltip (a_path)
			l_node.set_data (a_array_create_expression)
			l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			Result.extend (l_node)

			if a_array_create_expression.size_expression /= Void then
				create l_node.make_with_text ("Size Expression")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_array_create_expression)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
				l_node.extend (expression_node (a_path, a_array_create_expression.size_expression))
				Result.extend (l_node)
			end
		ensure
			non_void_nodes: Result /= Void
		end

	array_indexer_expression_nodes (a_path: STRING; a_array_indexer_expression: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_array_indexer_expression'
		require
			non_void_array_indexer_expression: a_array_indexer_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("Indices")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_array_indexer_expression)
			if a_array_indexer_expression.indices /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
				l_node.append (expressions_nodes (a_path, a_array_indexer_expression.indices))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_array_indexer_expression)
			if a_array_indexer_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_array_indexer_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	base_expression_nodes (a_path: STRING; a_base_expression: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_base_expression'
		require
			non_void_base_expression: a_base_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			create l_node.make_with_text ("Base Reference Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_base_expression)
			l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	binary_operator_expression_nodes (a_path: STRING; a_binary_operator_expression: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_binary_operator_expression'
		require
			non_void_binary_operator_expression: a_binary_operator_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
			l_operator: STRING
			l_pixmap: EV_PIXMAP
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (3)

			create l_node.make_with_text ("Left Operand")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_binary_operator_expression)
			if a_binary_operator_expression.left /= Void then
				l_node.extend (expression_node (a_path, a_binary_operator_expression.left))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			if a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Add then
				l_operator := "+"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Assign_ then
				l_operator := ":="
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Bitwise_and then
				l_operator := "&"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Bitwise_or then
				l_operator := "|"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Boolean_and then
				l_operator := "and"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Boolean_or then
				l_operator := "or"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Divide then
				l_operator := "/"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Greater_than then
				l_operator := ">"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Greater_than_or_equal then
				l_operator := ">="
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Identity_equality then
				l_operator := "="
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Identity_inequality then
				l_operator := "/="
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Less_than then
				l_operator := "<"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Less_than_or_equal then
				l_operator := "<="
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Modulus then
				l_operator := "\\"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Multiply then
				l_operator := "*"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Subtract then
				l_operator := "-"
			elseif a_binary_operator_expression.operator = {SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.Value_equality then
				l_operator := "is_equal"
			else
				l_operator := "Unknown Operator"
				create {TESTER_TREE_ICON} l_pixmap.make_error
			end
			create l_node.make_with_text (l_operator)
			if l_pixmap = Void then
				create {TESTER_TREE_ICON} l_pixmap.make_primitive
			end
			l_node.set_tooltip (a_path)
			l_node.set_data (a_binary_operator_expression)
			l_node.set_pixmap (l_pixmap)
			Result.extend (l_node)

			create l_node.make_with_text ("Right Operand")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_binary_operator_expression)
			if a_binary_operator_expression.right /= Void then
				l_node.extend (expression_node (a_path, a_binary_operator_expression.right))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	cast_expression_nodes (a_path: STRING; a_cast_expression: SYSTEM_DLL_CODE_CAST_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_cast_expression'
		require
			non_void_cast_expression: a_cast_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_cast_expression)
			if a_cast_expression.expression /= Void then
				l_node.extend (expression_node (a_path, a_cast_expression.expression))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_cast_expression)
			if a_cast_expression.target_type /= Void and then a_cast_expression.target_type.base_type /= Void then
				l_node.set_text ("Target Type: " + a_cast_expression.target_type.base_type)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				l_node.set_text ("Missing Target Type")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	delegate_create_expression_nodes (a_path: STRING; a_delegate_create_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_delegate_create_expression'
		require
			non_void_delegate_create_expression: a_delegate_create_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (3)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_delegate_create_expression)
			if a_delegate_create_expression.delegate_type /= Void and then a_delegate_create_expression.delegate_type.base_type /= Void then
				l_node.set_text ("Delegate Type: " + a_delegate_create_expression.delegate_type.base_type)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				l_node.set_text ("Missing Target Type")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_delegate_create_expression)
			if a_delegate_create_expression.method_name /= Void then
				l_node.set_text ("Method Name: " + a_delegate_create_expression.method_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Method Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_delegate_create_expression)
			if a_delegate_create_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_delegate_create_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	delegate_invoke_expression_nodes (a_path: STRING; a_delegate_invoke_expression: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_delegate_invoke_expression'
		require
			non_void_delegate_invoke_expression: a_delegate_invoke_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("Parameters")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_delegate_invoke_expression)
			if a_delegate_invoke_expression.parameters /= Void then
				l_node.append (expressions_nodes (a_path, a_delegate_invoke_expression.parameters))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_delegate_invoke_expression)
			if a_delegate_invoke_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_delegate_invoke_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	direction_expression_nodes (a_path: STRING; a_direction_expression: SYSTEM_DLL_CODE_DIRECTION_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_direction_expression'
		require
			non_void_direction_expression: a_direction_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("Unknown Direction")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_direction_expression)
			if a_direction_expression.direction = {SYSTEM_DLL_FIELD_DIRECTION}.In then
				l_node.set_text ("Direction: In")
			elseif a_direction_expression.direction = {SYSTEM_DLL_FIELD_DIRECTION}.Out then
				l_node.set_text ("Direction: Out")
			elseif a_direction_expression.direction = {SYSTEM_DLL_FIELD_DIRECTION}.Ref then
				l_node.set_text ("Direction: Ref")
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			if l_node.pixmap = Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Expression")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_direction_expression)
			if a_direction_expression.expression /= Void then
				l_node.extend (expression_node (a_path, a_direction_expression.expression))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	event_expression_nodes (a_path: STRING; a_event_expression: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_event_expression'
		require
			non_void_event_expression: a_event_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_event_expression)
			if a_event_expression.event_name /= Void then
				l_node.set_text ("Event Name: " + a_event_expression.event_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Event Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_event_expression)
			if a_event_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_event_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	field_expression_nodes (a_path: STRING; a_field_expression: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_field_expression'
		require
			non_void_field_expression: a_field_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_field_expression)
			if a_field_expression.field_name /= Void then
				l_node.set_text ("Field Name: " + a_field_expression.field_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Event Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_field_expression)
			if a_field_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_field_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	indexer_expression_nodes (a_path: STRING; a_indexer_expression: SYSTEM_DLL_CODE_INDEXER_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_indexer_expression'
		require
			non_void_indexer_expression: a_indexer_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("Indices")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_indexer_expression)
			if a_indexer_expression.indices /= Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
				l_node.append (expressions_nodes (a_path, a_indexer_expression.indices))
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_indexer_expression)
			if a_indexer_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_indexer_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	method_invoke_expression_nodes (a_path: STRING; a_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_method_invoke_expression'
		require
			non_void_method_invoke_expression: a_method_invoke_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("Method")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_method_invoke_expression)
			if a_method_invoke_expression.method /= Void then
				l_node.extend (expression_node (a_path, a_method_invoke_expression.method))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Parameters")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_method_invoke_expression)
			if a_method_invoke_expression.parameters /= Void then
				l_node.append (expressions_nodes (a_path, a_method_invoke_expression.parameters))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	method_reference_expression_nodes (a_path: STRING; a_method_reference_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_method_reference_expression'
		require
			non_void_method_reference_expression: a_method_reference_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_method_reference_expression)
			if a_method_reference_expression.method_name /= Void then
				l_node.set_text ("Method Name: " + a_method_reference_expression.method_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Method Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_method_reference_expression)
			if a_method_reference_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_method_reference_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	object_create_expression_nodes (a_path: STRING; a_object_create_expression: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_object_create_expression'
		require
			non_void_object_create_expression: a_object_create_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_object_create_expression)
			if a_object_create_expression.create_type /= Void and then a_object_create_expression.create_type.base_type /= Void then
				l_node.set_text ("Create Type: " + a_object_create_expression.create_type.base_type)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				l_node.set_text ("Missing Create Type")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Parameters")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_object_create_expression)
			if a_object_create_expression.parameters /= Void then
				l_node.append (expressions_nodes (a_path, a_object_create_expression.parameters))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	parameter_declaration_expression_nodes (a_path: STRING; a_parameter_declaration_expression: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_parameter_declaration_expression'
		require
			non_void_parameter_declaration_expression: a_parameter_declaration_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (4)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_parameter_declaration_expression)
			if a_parameter_declaration_expression.name /= Void then
				l_node.set_text ("Parameter Name: " + a_parameter_declaration_expression.name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Parameter Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_parameter_declaration_expression)
			if a_parameter_declaration_expression.type /= Void and then a_parameter_declaration_expression.type.base_type /= Void then
				l_node.set_text ("Parameter Type: " + a_parameter_declaration_expression.type.base_type)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				l_node.set_text ("Missing Parameter Type")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Unknown Direction")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_parameter_declaration_expression)
			if a_parameter_declaration_expression.direction = {SYSTEM_DLL_FIELD_DIRECTION}.In then
				l_node.set_text ("Direction: In")
			elseif a_parameter_declaration_expression.direction = {SYSTEM_DLL_FIELD_DIRECTION}.Out then
				l_node.set_text ("Direction: Out")
			elseif a_parameter_declaration_expression.direction = {SYSTEM_DLL_FIELD_DIRECTION}.Ref then
				l_node.set_text ("Direction: Ref")
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			if l_node.pixmap = Void then
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			end
			Result.extend (l_node)

			if a_parameter_declaration_expression.custom_attributes /= Void then
				create l_node.make_with_text ("Custom Attributes")
				l_node.set_tooltip (a_path)
				l_node.set_data (a_parameter_declaration_expression)
--				l_node.append (custom_attributes_nodes (a_path, a_parameter_declaration_expression.custom_attributes))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
				Result.extend (l_node)
			end
		ensure
			non_void_nodes: Result /= Void
		end

	primitive_expression_nodes (a_path: STRING; a_primitive_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_primitive_expression'
		require
			non_void_primitive_expression: a_primitive_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_primitive_expression)
			if a_primitive_expression.value /= Void then
				l_node.set_text ("Primitive Value: " + a_primitive_expression.value.to_string)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Primitive Value")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	property_reference_expression (a_path: STRING; a_property_reference_expression: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_property_reference_expression'
		require
			non_void_property_reference_expression: a_property_reference_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (2)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_property_reference_expression)
			if a_property_reference_expression.property_name /= Void then
				l_node.set_text ("Property Name: " + a_property_reference_expression.property_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Property Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)

			create l_node.make_with_text ("Target Object")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_property_reference_expression)
			if a_property_reference_expression.target_object /= Void then
				l_node.extend (expression_node (a_path, a_property_reference_expression.target_object))
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_expression)
			else
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	property_set_value_reference_expression_nodes (a_path: STRING; a_property_set_value_reference_expression: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_property_set_value_reference_expression'
		require
			non_void_property_set_value_reference_expression: a_property_set_value_reference_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_property_set_value_reference_expression)
			l_node.set_text ("Property Setter Argument")
			l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	snippet_expression_nodes (a_path: STRING; a_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_snippet_expression'
		require
			non_void_snippet_expression: a_snippet_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_snippet_expression)
			if a_snippet_expression.value /= Void then
				l_node.set_text ("Snippet Expression: " + a_snippet_expression.value)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			else
				l_node.set_text ("Missing Snippet Expression")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	this_expression_nodes (a_path: STRING; a_this_expression: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_this_expression'
		require
			non_void_this_expression: a_this_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)

			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_this_expression)
			l_node.set_text ("This")
			l_node.set_pixmap (create {TESTER_TREE_ICON}.make_primitive)
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	type_of_expression_nodes (a_path: STRING; a_type_of_expression: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_type_of_expression'
		require
			non_void_type_of_expression: a_type_of_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_type_of_expression)
			if a_type_of_expression.type /= Void and then a_type_of_expression.type.base_type /= Void then
				l_node.set_text ("TypeOf Type: " + a_type_of_expression.type.base_type)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				l_node.set_text ("Missing TypeOf Type")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	type_reference_expression_nodes (a_path: STRING; a_type_reference_expression: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_type_reference_expression'
		require
			non_void_type_reference_expression: a_type_reference_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			create l_node.make_with_text ("")
			l_node.set_tooltip (a_path)
			l_node.set_data (a_type_reference_expression)
			if a_type_reference_expression.type /= Void and then a_type_reference_expression.type.base_type /= Void then
				l_node.set_text ("Type: " + a_type_reference_expression.type.base_type)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_type)
			else
				l_node.set_text ("Missing Type Reference")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
		end

	variable_reference_expression_nodes (a_path: STRING; a_variable_reference_expression: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION): LIST [EV_TREE_NODE] is
			-- Nodes for expression `a_variable_reference_expression'
		require
			non_void_variable_reference_expression: a_variable_reference_expression /= Void
			non_void_path: a_path /= Void
		local
			l_node: EV_TREE_ITEM
		do
			create {ARRAYED_LIST [EV_TREE_NODE]} Result.make (1)
			if a_variable_reference_expression.variable_name /= Void then
				create l_node.make_with_text (a_variable_reference_expression.variable_name)
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_variable)
			else
				create l_node.make_with_text ("Missing Variable Name")
				l_node.set_pixmap (create {TESTER_TREE_ICON}.make_error)
			end
			l_node.set_tooltip (a_path)
			l_node.set_data (a_variable_reference_expression)
			Result.extend (l_node)
		ensure
			non_void_nodes: Result /= Void
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
						if {SYSTEM_STRING}.compare (uv.name, lv.name) < 0 then
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
								l >= u or else {SYSTEM_STRING}.compare (a_collection.item (l).name, pivot.name) >= 0
							loop
								l := l + 1
							end
							from
								u := u - 1
							until
								u <= l or else {SYSTEM_STRING}.compare (pivot.name, a_collection.item (u).name) >= 0
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
