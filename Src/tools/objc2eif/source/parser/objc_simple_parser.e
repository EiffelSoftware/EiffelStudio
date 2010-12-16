note
	description: "Simple Objective-C parser."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_SIMPLE_PARSER

inherit
	SHARED_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current
		do
			create classes.make (0)
			create protocols.make (0)
			create current_line.make_empty
			create types.make (0)
			create errors.make (0)
		ensure
			system_not_parsed: not system_parsed
		end

feature -- Parsing

	parse_objc_header (a_file: RAW_FILE)
			-- Parse an Objective-C header.
			-- This method should be called only once per object due to internal constraints.
			-- See `system_parsed' boolean attribute in the contracts of `make' and `parse_objc_header'.
		require
			a_file_exists: a_file.exists
			system_not_parsed: not system_parsed
		local
			class_name: STRING
			path_components: LIST [STRING]
			file_name: STRING
			executor: EXECUTION_ENVIRONMENT
			parse_errors: BOOLEAN
		do
			if not parse_errors then
				create executor
				print("Parsing header (" + a_file.name + ")...%N")
					-- Preprocess the file
				file_name := a_file.name
				path_components := file_name.split ('/')
				class_name := path_components.i_th (path_components.count).split ('.').i_th (1)
				executor.system ("gcc -E -F" + configuration.frameworks_path + " " + file_name + " -o " + class_name + ".h")
					-- Parse preprocessed header
				create file.make_open_read (class_name + ".h")
				state := parsing_declarations_state
				from
					file.start
					current_line_number := 0
					parse_errors := False
				until
					parse_errors or else file.end_of_file
				loop
					file.read_line
					current_line := file.last_string
					current_line_number := current_line_number + 1
					current_position_in_line := 1
					inspect state
					when parsing_declarations_state then
							-- High level declarations parsing
						parse_declaration
					when parsing_class_body_state then
							-- Class body parsing
						check current_objective_c_class_not_void: current_objc_class_decl /= Void end
						parse_class
					when parsing_optional_protocol_methods, parsing_required_protocol_methods then
							-- Protocol parsing
						check current_objective_c_protocol_not_void: current_objc_protocol_decl /= Void end
						parse_protocol
					end
					parse_errors :=  not errors.is_empty
				end
					-- Perform clean up
				file.close
				file.delete
			end
				-- Check whether there were parsing errors.
			if not parse_errors then
					-- Some categories or protocols might be empty because deprecated. Remove them.
				cleanup_system
					-- Now that we parsed the full system, update the types.
				type_system
				system_parsed := True
			end
		ensure
			system_parsed_iff_no_errors: (errors.is_empty implies system_parsed) and
										 (system_parsed implies errors.is_empty)
		rescue
				-- Clear all parsed entities.
			create classes.make (0)
			create protocols.make (0)
			create current_line.make_empty
			create types.make (0)
			parse_errors := True
			retry
		end

feature -- Access

	system_parsed: BOOLEAN
			-- Indicate whether the system of classes has been parsed already.

	classes: HASH_TABLE [OBJC_CLASS_DECL, STRING]
			-- A representation of classes indexed by their names.

	protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			-- A representation of protocols indexed by their names.

	errors: ARRAYED_LIST [PARSING_ERROR]
			-- A list containing the parsing errors, if any.

feature {NONE} -- Parsing Implementation

	file: detachable RAW_FILE note option: stable attribute end
			-- The file that we are currently parsing.

	types: HASH_TABLE [STRING, STRING]
			-- Used as a temporary storage for the Objective-C types that need to be resolved.
			-- Key: Objective-C type name. Example: "NSString *"
			-- Value: Objective-C type encoding. Example: "@"

	parse_declaration
			-- Tries to parse an Objective-C declaration out of the current line.
		require
			valid_state: is_parsing_declarations
		local
			token: STRING
			temp_objc_class_decl: OBJC_CLASS_DECL
			temp_objc_category_decl: detachable OBJC_CATEGORY_DECL
			parent_protocols_list: ARRAYED_LIST [OBJC_PROTOCOL_DECL]
		do
			token := next_token
			if token.is_equal ({OBJC_TOKEN}.hash_symbol) then
					-- If we find an inclusion declaration by the preprocessor.
				if current_line.substring_index (configuration.frameworks_path, 1) > 0 then
					parse_header_inclusion
				end
			elseif token.is_equal ({OBJC_TOKEN}.at_symbol) then
					-- If we find a possible declaration.
				token := next_token
				if token.is_equal ({OBJC_TOKEN}.interface_keyword) then
						-- If it is a class declaration,
						-- Parse class name.
					token := next_token
						-- Create a temporary symbol to hold the parsed information.
					check valid_framework: attached current_framework as attached_current_framework not attached_current_framework.is_empty end
					check valid_header: attached current_header as attached_current_header not attached_current_header.is_empty end
					create temp_objc_class_decl.make (token, current_framework, current_header)
					debug ("OBJC_SIMPLE_PARSER_DEBUG")
						print ("%TParsing class " + token + " (" + current_framework + " framework)%N")
					end
					token := next_token
					if token.is_equal ({OBJC_TOKEN}.colon_symbol) then
							-- Parse parent class name.
						token := next_token
				   		if attached classes.item (token) as parent_class then
				   			temp_objc_class_decl.set_parent_class (parent_class)
				   		else
				   			add_error_with_message ("Unknown superclass. Make sure the superclass is declared before it is used.")
				   		end
				   		token := next_token
					elseif token.is_equal ({OBJC_TOKEN}.open_parenthesis_symbol) then
							-- Parse category name.
						create temp_objc_category_decl.make (next_token, temp_objc_class_decl, current_framework, current_header)
						temp_objc_class_decl.categories.put (temp_objc_category_decl, temp_objc_category_decl.name)
						token := next_token
						if not token.is_equal ({OBJC_TOKEN}.closed_parenthesis_symbol) then
							add_error_with_token (token)
						end
				   		token := next_token
					end
					if token.is_equal ({OBJC_TOKEN}.less_than_symbol) then
							-- Parse adopting protocols.
						from
							token := next_token
						until
							token.is_equal ({OBJC_TOKEN}.greater_than_symbol) or else not errors.is_empty
						loop
							if attached protocols.item (token) as protocol then
									-- If we are parsing a category, add the protocols to it.
									-- Otherwise add them to the current class.
								if temp_objc_class_decl.categories.count > 0 then
									check temp_objc_category_decl_not_void: temp_objc_category_decl /= Void end
									temp_objc_category_decl.protocols.put (protocol, protocol.name)
								else
									temp_objc_class_decl.protocols.put (protocol, protocol.name)
								end
							else
								add_error_with_message ("Unknown protocol. Make sure the protocol is declared before it is used.")
							end
							token := next_token
							if token.is_equal ({OBJC_TOKEN}.comma_symbol) then
								token := next_token
							elseif not token.is_equal ({OBJC_TOKEN}.greater_than_symbol) then
								add_error_with_token (token)
							end
						end
					end
					if attached classes.item (temp_objc_class_decl.name) as existing_class then
							-- Distinguish two cases:
						if temp_objc_class_decl.categories.count = 0 then
								-- This is not a category declaration.
								-- Moreover, we already parsed this class, therefore we don't have to do
								-- anything else.
							state := parsing_declarations_state
						else
								-- count > 0.
								-- This is a category declaration.
							check temp_objc_category_decl_not_void: temp_objc_category_decl /= Void end
							if attached existing_class.categories.item (temp_objc_category_decl.name) then
									-- We already parsed this category declaration. We don't have to do
									-- anything else.
								state := parsing_declarations_state
							else
									-- We never encountered this category declaration before. Add it to the
									-- existing class and set the state such that we will parse its methods.
								existing_class.categories.put (temp_objc_category_decl, temp_objc_category_decl.name)
								current_objc_category_decl := temp_objc_category_decl
								state := parsing_class_body_state
							end
						end
					else
							-- We never encountered this class before, therefore set
							-- `current_objc_class_decl' to it and set the state such that we will
							-- parse its methods.
						current_objc_class_decl := temp_objc_class_decl
						current_objc_category_decl := Void
						state := parsing_class_body_state
					end
				elseif token.is_equal ({OBJC_TOKEN}.protocol_keyword) then
						-- If it is a protocol declaration,
						-- Parse protocol name.
					token := next_token
					debug ("OBJC_SIMPLE_PARSER_DEBUG")
						check current_framework_not_void: current_framework /= Void end
						check current_header_not_void: current_header /= Void end
						print ("%TParsing protocol " + token + " (" + current_framework + " framework)%N")
					end
						-- Check if the protocol already exists.
					if attached protocols.item (token) as attached_current_objc_protocol_decl then
							-- Check if the protocol is declared as a forward reference.
						if current_line.item (current_line.count).is_equal ({OBJC_TOKEN}.semi_colon_symbol.item (1)) then
								-- We already parsed this forward reference, do nothing.
							state := parsing_declarations_state
						else
							if attached_current_objc_protocol_decl.is_forward_reference then
									-- We already parsed a forward reference of this protocol but
									-- we still need to parse it.
								current_objc_protocol_decl := attached_current_objc_protocol_decl
								current_objc_protocol_decl.set_forward_reference (False)
								check valid_framework: attached current_framework as attached_current_framework not attached_current_framework.is_empty end
								current_objc_protocol_decl.framework := current_framework
								parent_protocols_list := parse_parent_protocols_list
								from
									parent_protocols_list.start
								until
									parent_protocols_list.after
								loop
									current_objc_protocol_decl.parent_protocols.put (parent_protocols_list.item, parent_protocols_list.item.name)
									parent_protocols_list.forth
								end
								state := parsing_required_protocol_methods
							else
									-- We already parsed this protocol, do nothing.
								state := parsing_declarations_state
							end
						end
					else
							-- Check if the protocol is declared as a forward reference.
						if current_line.item (current_line.count).is_equal ({OBJC_TOKEN}.semi_colon_symbol.item (1)) then
								-- Parse this protocol forward reference.
							from until
								token.is_equal ({OBJC_TOKEN}.semi_colon_symbol) or else not errors.is_empty
							loop
								create current_objc_protocol_decl.make (token)
								current_objc_protocol_decl.set_forward_reference (True)
								protocols.put (current_objc_protocol_decl, current_objc_protocol_decl.name)
								token := next_token
								if token.is_equal ({OBJC_TOKEN}.comma_symbol) then
									token := next_token
								end
								if token.is_empty then
									add_error_with_token (token)
								end
							end
							state := parsing_declarations_state
						else
								-- We never encountered this protocol declaration. Parse it.
							create current_objc_protocol_decl.make (token)
							check valid_framework: attached current_framework as attached_current_framework not attached_current_framework.is_empty end
							current_objc_protocol_decl.framework := current_framework
							current_objc_protocol_decl.set_forward_reference (False)
							parent_protocols_list := parse_parent_protocols_list
							from
								parent_protocols_list.start
							until
								parent_protocols_list.after
							loop
								current_objc_protocol_decl.parent_protocols.put (parent_protocols_list.item, parent_protocols_list.item.name)
								parent_protocols_list.forth
							end
							state := parsing_required_protocol_methods
						end
					end
				end
			end
		ensure
			valid_state: is_parsing_declarations or
						 is_parsing_class_body or
						 is_parsing_required_protocol_methods
		end

	parse_header_inclusion
			-- GCC annotates the precompiled header file with comments about the
			-- origin of the declarations. This procedure parses this information.
		require
			valid_state: is_parsing_declarations
		local
			token: STRING
			header_path: STRING
			splitted_string: LIST [STRING]
			current_item: STRING
		do
			from
				token := next_token
			until
				token.is_equal ({OBJC_TOKEN}.quotation_mark_symbol) or else not errors.is_empty
			loop
				token := next_token
				if token.is_empty then
					add_error_with_token (token)
				end
			end
				-- Parse header path.
			from
				create header_path.make_empty
				current_position_in_line := current_position_in_line + 1
			until
				current_character.is_equal ({OBJC_TOKEN}.quotation_mark_symbol.item (1)) or else not errors.is_empty
			loop
				header_path.extend (current_character)
				current_position_in_line := current_position_in_line + 1
				if current_position_in_line > current_line.count then
					add_error_with_message ("Unable to parse header path.")
				end
			end
				-- Extract framework and header name.
			splitted_string := header_path.split ('/')
			from
				splitted_string.start
			until
				splitted_string.after
			loop
				current_item := splitted_string.item
				if current_item.substring_index (".framework", 1) > 0 then
					current_framework := current_item.split ('.').i_th (1)
				elseif current_item.substring_index (".h", 1) > 0 then
					current_header := current_item
				end
				splitted_string.forth
			end
		ensure
			valid_state: is_parsing_declarations
		end

	parse_class
			-- Parse the body of an Objective-C class declaration.
		require
			current_objective_c_class_not_void: current_objc_class_decl /= Void
			valid_state: is_parsing_class_body
		local
			current_token: STRING
			is_class_method, is_instance_method: BOOLEAN
			return_type: OBJC_TYPE_DECL
			arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			method: OBJC_METHOD_DECL
		do
			if not (current_line.substring_index ("__attribute__((", 1) > 0) then
				current_token := next_token
				is_class_method := current_token.is_equal ("+")
				is_instance_method := current_token.is_equal ("-")
				if is_class_method or is_instance_method then
						-- Parse the return type.
					return_type := parse_type
						-- Parse the argument labels, argument types, argument names.
					arguments := parse_arguments
						-- Create the parsed method.
					create method.make (is_class_method, return_type, arguments)
						-- Distinguish two cases.
					if attached current_objc_category_decl as attached_current_objc_category_decl then
							-- We are parsing the methods of a category declaration.
						attached_current_objc_category_decl.methods.put (method, method.selector_name)
					else
							-- We are parsing the methods of a class declaration.
						current_objc_class_decl.methods.put (method, method.selector_name)
					end
				elseif current_token.is_equal ({OBJC_TOKEN}.at_symbol) then
					current_token := next_token
					if current_token.is_equal ({OBJC_TOKEN}.end_keyword) then
						if current_objc_category_decl = Void then
								-- Finished parsing this class declaration.
								-- Add the class in the system if it is not there already.
							if classes.has (current_objc_class_decl.name) then
								add_error_with_message ("Duplicate class declaration.")
							end
							classes.put (current_objc_class_decl, current_objc_class_decl.name)
						end
						state := parsing_declarations_state
					elseif current_token.is_equal ({OBJC_TOKEN}.property_keyword) then
							-- Distinguish two cases.
						if attached parse_property as property then
							if attached current_objc_category_decl as attached_current_objc_category_decl then
									-- We are parsing the methods of a category declaration.
								attached_current_objc_category_decl.properties.put (property, property.name)
							else
									-- We are parsing the methods of a class declaration.
								current_objc_class_decl.properties.put (property, property.name)
							end
						end
					end
				end
			end
		ensure
			valid_state: is_parsing_declarations or
						 is_parsing_class_body
		end

	parse_protocol
			-- Parse the body of an Objective-C protocol declaration.
		require
			current_objective_c_protocol_not_void: current_objc_protocol_decl /= Void
			valid_state: is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		local
			token: STRING
			is_class_method, is_instance_method: BOOLEAN
			method: OBJC_PROTOCOL_METHOD_DECL
			return_type: OBJC_TYPE_DECL
			arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
		do
			token := next_token
			if token.is_empty then
					-- Do not parse anything.
			elseif token.is_equal ({OBJC_TOKEN}.at_symbol) then
					-- We are not parsing a method.
				token := next_token
				if token.is_equal ({OBJC_TOKEN}.optional_keyword) then
					state := parsing_optional_protocol_methods
				elseif token.is_equal ({OBJC_TOKEN}.required_keyword) then
					state := parsing_required_protocol_methods
				elseif token.is_equal ({OBJC_TOKEN}.end_keyword) then
						-- Finished parsing this protocol declaration.
						-- Add the protocol in the system if it is not there already.
					protocols.put (current_objc_protocol_decl, current_objc_protocol_decl.name)
					state := parsing_declarations_state
				elseif token.is_equal ({OBJC_TOKEN}.property_keyword) then
					-- Not supported yet
				else
					add_error_with_token (token)
				end
			else
				if not (current_line.substring_index ("__attribute__((", 1) > 0) then
					is_class_method := token.is_equal ({OBJC_TOKEN}.plus_symbol)
					is_instance_method := token.is_equal ({OBJC_TOKEN}.minus_symbol)
					if is_class_method or is_instance_method then
							-- Parse the return type.
						return_type := parse_type
							-- Parse the argument labels, argument types, argument names.
						arguments := parse_arguments
							-- Create the parsed method.
						create method.make (is_class_method, return_type, arguments)
						method.set_required (state = parsing_required_protocol_methods)
						current_objc_protocol_decl.methods.put (method, method.selector_name)
					end
				end
			end
		ensure
			valid_state: is_parsing_declarations or
						 is_parsing_required_protocol_methods or
						 is_parsing_optional_protocol_methods
		end

	parse_parent_protocols_list: ARRAYED_LIST [OBJC_PROTOCOL_DECL]
			-- Parse a list of parent protocols in an Objective-C class or protocol declaration.
		require
			valid_state: is_parsing_declarations
			current_objc_protocol_decl_not_void: current_objc_protocol_decl /= Void
		local
			token: STRING
		do
			create Result.make (0)
			token := next_token
			if token.is_equal ({OBJC_TOKEN}.less_than_symbol) then
					-- Parse parent protocols.
				from
					token := next_token
				until
					token.is_equal ({OBJC_TOKEN}.greater_than_symbol) or else not errors.is_empty
				loop
					if attached protocols.item (token) as protocol then
						current_objc_protocol_decl.parent_protocols.put (protocol, protocol.name)
					else
						add_error_with_message ("Unkown parent protocol. Make sure to declare it before using it.")
					end
					token := next_token
					if token.is_equal ({OBJC_TOKEN}.comma_symbol) then
						token := next_token
					elseif not token.is_equal ({OBJC_TOKEN}.greater_than_symbol) then
						add_error_with_token (token)
					end
				end
			end
		ensure
			valid_state: is_parsing_declarations
		end

	parse_type: OBJC_TYPE_DECL
			-- Parse the type at the current position in the current line.
		require
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		local
			current_token: STRING
			open_parenthesis: NATURAL
			result_string: STRING
			old_position_in_line: INTEGER
		do
			old_position_in_line := current_position_in_line
			current_token := next_token
			if not current_token.is_equal ({OBJC_TOKEN}.open_parenthesis_symbol) then
				-- Method definitions can omit the type.
				-- Example: - initWithString:(NSString *)aString;
				-- When this happens the implicit type is "id".
				result_string := "id"
				current_position_in_line := old_position_in_line
			else
				from
					create result_string.make_empty
					current_token := next_token
				until
					open_parenthesis = 0 and current_token.is_equal ({OBJC_TOKEN}.closed_parenthesis_symbol) or else not errors.is_empty
				loop
					if
						not (current_token.is_equal ({OBJC_TOKEN}.in_keyword) or
						current_token.is_equal ({OBJC_TOKEN}.inout_keyword) or
						current_token.is_equal ({OBJC_TOKEN}.out_keyword) or
						current_token.is_equal ({OBJC_TOKEN}.bycopy_keyword) or
						current_token.is_equal ({OBJC_TOKEN}.byref_keyword) or
						current_token.is_equal ({OBJC_TOKEN}.oneway_keyword))
					then
						result_string.append (current_token + " ")
							-- We have to deal with parenthesis in the case of function pointers.
						if current_token.is_equal ({OBJC_TOKEN}.open_parenthesis_symbol) then
							open_parenthesis := open_parenthesis + 1
						elseif current_token.is_equal ({OBJC_TOKEN}.closed_parenthesis_symbol) then
							open_parenthesis := open_parenthesis - 1
						end
					end
					current_token := next_token
					if current_token.is_empty then
						add_error_with_token ("")
					end
				end
				if result_string.is_empty then
					add_error_with_message ("No type specified.")
				end
				-- Make type prettier.
				result_string.remove_tail (1)
			end
				-- Put the parsed type in a hash table such that we can resolve
				-- its objective-c encoding later.
			types.put ("", result_string)
			create Result.make (result_string)
		ensure
			valid_result: not Result.name.is_empty
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		end

	parse_arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			-- Parse arguments of the current method declaration.
		require
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		local
			current_argument: OBJC_ARGUMENT_DECL
			current_token: STRING
			done: BOOLEAN
		do
			from
				create Result.make (0)
					-- Parse the argument label.
				create current_argument.make (next_token)
			until
				done or else not errors.is_empty
			loop
				current_token := next_token
				if current_token.is_equal ({OBJC_TOKEN}.semi_colon_symbol) then
					done := True
					if Result.is_empty then
						Result.extend (current_argument)
					end
				elseif current_token.is_equal ({OBJC_TOKEN}.colon_symbol) then
						-- Parse the argument type and name.
					current_argument.set_type_and_argument_name (parse_type, next_token)
					Result.extend (current_argument)
				elseif current_token.is_equal ({OBJC_TOKEN}.comma_symbol) then
					current_token := next_token
					if not current_token.is_equal ({OBJC_TOKEN}.dot_symbol) then
						add_error_with_token (current_token)
					end
					current_token := next_token
					if not current_token.is_equal ({OBJC_TOKEN}.dot_symbol) then
						add_error_with_token (current_token)
					end
					current_token := next_token
					if not current_token.is_equal ({OBJC_TOKEN}.dot_symbol) then
						add_error_with_token (current_token)
					end
					create current_argument.make ("...")
					current_argument.is_dotdotdot := True
					Result.extend (current_argument)
				else
					create current_argument.make (current_token)
					current_token := next_token
					if not current_token.is_equal ({OBJC_TOKEN}.colon_symbol) then
						add_error_with_token (current_token)
					end
						-- Parse the argument type and name.
					current_argument.set_type_and_argument_name (parse_type, next_token)
					Result.extend (current_argument)
				end
			end
		ensure
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		end

	parse_property: detachable OBJC_PROPERTY_DECL
			-- Parse property. Return a void result if the property type is a function
			-- pointer.
		require
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		local
			attributes: ARRAYED_LIST [STRING]
			temp_string: STRING
			temp_list: LIST [STRING]
			current_token: STRING
			name: STRING
			type_name: STRING
			getter: detachable STRING
			setter: detachable STRING
			readonly: BOOLEAN
		do
			current_token := next_token
			if current_token.is_equal ({OBJC_TOKEN}.open_parenthesis_symbol) then
					-- Parse property attributes.
				attributes := parse_property_attributes
				from
					attributes.start
				until
					attributes.after
				loop
					temp_string := attributes.item
					temp_list := temp_string.split ('=')
					if temp_string.is_equal ({OBJC_TOKEN}.readonly_keyword) then
						readonly := True
					elseif temp_list.i_th (1).is_equal ({OBJC_TOKEN}.getter_keyword) then
						getter := temp_list.i_th (2)
					elseif temp_list.i_th (1).is_equal ({OBJC_TOKEN}.setter_keyword) then
						setter := temp_list.i_th (2)
					end
					attributes.forth
				end
				current_token := next_token
			end
				-- Parse property type.
			from
				create {ARRAYED_LIST [STRING]} temp_list.make (0)
			until
				current_token.is_equal ({OBJC_TOKEN}.semi_colon_symbol) or else not errors.is_empty
			loop
				temp_list.extend (current_token)
				current_token := next_token
				if current_token.is_empty then
					add_error_with_token (current_token)
				end
			end
			if not temp_list.last.is_equal ({OBJC_TOKEN}.closed_parenthesis_symbol) then
					-- If we're not parsing a function pointer property.
				name := temp_list.last
				temp_list.finish
				temp_list.remove
				from
					temp_list.start
					create type_name.make_empty
				until
					temp_list.after
				loop
					type_name.append (temp_list.item + " ")
					temp_list.forth
				end
				type_name.remove_tail (1)
				types.put ("", type_name)
				create Result.make (name, create {OBJC_TYPE_DECL}.make (type_name))
				if attached getter then
					Result.getter := getter
				end
				if attached setter then
					Result.setter := setter
				end
				Result.readonly := readonly
			end
		ensure
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		end

	parse_property_attributes: ARRAYED_LIST [STRING]
			-- Parse the attributes of the current Objective-C property declaration.
		require
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		local
			current_token: STRING
			current_attribute: STRING
		do
			create Result.make (0)
			current_token := next_token
			from until
				current_token.is_equal ({OBJC_TOKEN}.closed_parenthesis_symbol) or else not errors.is_empty
			loop
				--current_token := next_token
				from
					create current_attribute.make_empty
				until
					current_token.is_equal ({OBJC_TOKEN}.comma_symbol) or current_token.is_equal ({OBJC_TOKEN}.closed_parenthesis_symbol) or else not errors.is_empty
				loop
					current_attribute.append (current_token)
					current_token := next_token
					if current_token.is_empty then
						add_error_with_token (current_token)
					end
				end
				Result.extend (current_attribute)
				if current_token.is_equal ({OBJC_TOKEN}.comma_symbol) then
					current_token := next_token
				end
			end
		ensure
			valid_state: is_parsing_class_body or is_parsing_required_protocol_methods or is_parsing_optional_protocol_methods
		end

	cleanup_system
			-- Some categories or protocols might be empty because deprecated.
			-- Remove them.
		require
			system_not_parsed: not system_parsed
		local
			current_categories: HASH_TABLE [OBJC_CATEGORY_DECL, STRING]
			categories_to_remove: ARRAYED_LIST [OBJC_CATEGORY_DECL]
		do
			from
				classes.start
			until
				classes.after
			loop
				create categories_to_remove.make (0)
				current_categories := classes.item_for_iteration.categories
					-- Find the useless categories.
				from
					current_categories.start
				until
					current_categories.after
				loop
					if current_categories.item_for_iteration.methods.count = 0 then
						categories_to_remove.extend (current_categories.item_for_iteration)
					end
					current_categories.forth
				end
					-- Remove the useless categories.
				from
					categories_to_remove.start
				until
					categories_to_remove.after
				loop
					current_categories.remove (categories_to_remove.item.name)
					categories_to_remove.forth
				end
				classes.forth
			end
		end

	type_system
			-- After parsing, the system has temporary OBJC_TYPE_DECL types. This procedure replaces them
			-- with the actual types (OBJC_BASIC_TYPE_DECL, OBJC_POINTER_TYPE_DECL and OBJC_STRUCT_TYPE_DECL).
		require
			system_not_parsed: not system_parsed
		local
			typing_visitor: OBJC_TYPING_VISITOR
		do
			get_type_encodings
			create typing_visitor.make (types)
				-- Type the classes.
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.accept (typing_visitor)
				classes.forth
			end
				-- Type the protocols.
			from
				protocols.start
			until
				protocols.after
			loop
				protocols.item_for_iteration.accept (typing_visitor)
				protocols.forth
			end
		end

feature {NONE} -- Implementation

	current_objc_class_decl: detachable OBJC_CLASS_DECL note option: stable attribute end
			-- The current Objective-C class declaration being parsed.

	current_objc_category_decl: detachable OBJC_CATEGORY_DECL
			-- The current Objective-C category declaration being parsed.

	current_objc_protocol_decl: detachable OBJC_PROTOCOL_DECL note option: stable attribute end
			-- The current Objective-C protocol declaration being parsed.

	current_framework: detachable STRING note option: stable attribute end
			-- The current Objective-C framework we are parsing the declarations from.

	current_header: detachable STRING note option: stable attribute end
			-- The current Objective-C header file we are parsing the declarations from.

	state: INTEGER
			-- The current parsing state.

	add_error_with_token (a_token: STRING)
			-- Add an error to `errors' with the specified token.
		do
			check file_not_void: file /= Void end
			errors.extend (create {PARSING_ERROR}.make_with_token (file, current_line, current_line_number, current_position_in_line, a_token))
		ensure
			errors_has_one_more_item: errors.count = old errors.count + 1
		end

	add_error_with_message (a_message: STRING)
			-- Add an error to `errors' with the specified message
		require
			a_valid_message: not a_message.is_empty
		do
			check file_not_void: file /= Void end
			errors.extend (create {PARSING_ERROR}.make_with_message (file, current_line, current_line_number, current_position_in_line, a_message))
		ensure
			errors_has_one_more_item: errors.count = old errors.count + 1
		end

	current_line: STRING
			-- The current line being parsed.

	current_line_number: INTEGER
			-- The number of the line being parsed.

	current_position_in_line: INTEGER
			-- The current position in the current line being parsed.

	current_character: CHARACTER
			-- The character at the current position in the current line being parsed.
		require
			valid_current_position: current_position_in_line >= 1 and
									current_position_in_line <= current_line.count
		do
			Result := current_line [current_position_in_line]
		end

	end_of_line: BOOLEAN
			-- Is `current_position_in_line' equal to `curent_line.count' + 1?
		do
			Result := current_position_in_line = current_line.count + 1
		end

	next_token: STRING
			-- Return the next Objective-C token in the current line starting at the current position.
			-- A token can either be an identifier (i.e. a word composed by letters, numbers and the "_"
			-- symbol with the only exception that the first character cannot be a number) or a symbol.
		require
			system_not_parsed: not system_parsed
		do
			create Result.make_empty
				-- Ignore whitespaces.
			from until
				end_of_line or else not (current_character.is_equal ({OBJC_TOKEN}.space_character) or current_character.is_equal ({OBJC_TOKEN}.tab_character))
			loop
				current_position_in_line := current_position_in_line + 1
			end
			if not end_of_line then
					-- If we're parsing an identifier.
				if current_character.is_alpha or current_character.is_equal ({OBJC_TOKEN}.underscore_symbol) then
					Result.append_character (current_character)
					current_position_in_line := current_position_in_line + 1

					from until
						end_of_line or else not (current_character.is_alpha or
												 current_character.is_digit or
												 current_character.is_equal ({OBJC_TOKEN}.underscore_symbol))
					loop
						Result.append_character (current_character)
						current_position_in_line := current_position_in_line + 1
					end
				else
						-- If we're parsing a symbol.
					Result.append_character (current_character)
					current_position_in_line := current_position_in_line + 1
				end
			end
		end

feature {NONE} -- Parsing State Constants

	parsing_declarations_state: INTEGER = 0
			-- Parsing declarations state.

	parsing_class_body_state: INTEGER = 1
			-- Parsing class body state.

	parsing_required_protocol_methods: INTEGER = 2
			-- Parsing required protocol methods state.

	parsing_optional_protocol_methods: INTEGER = 3
			-- Parsing optional protocol methods state.

feature {NONE} -- Status Report

	is_parsing_declarations: BOOLEAN
			-- Is the parser parsing declarations?
		do
			Result := state = parsing_declarations_state
		end

	is_parsing_class_body: BOOLEAN
			-- Is the parser parsing a class body?
		do
			Result := state = parsing_class_body_state
		end

	is_parsing_required_protocol_methods: BOOLEAN
			-- Is the parser parsing required protocol methods?
		do
			Result := state = parsing_required_protocol_methods
		end

	is_parsing_optional_protocol_methods: BOOLEAN
			-- Is the parser parsing optional protocol methods?
		do
			Result := state = parsing_optional_protocol_methods
		end

feature {NONE} -- Objective C Support

	get_type_encodings
			-- Update the `types' hash table with the type encodings.
		require
			system_not_parsed: not system_parsed
		local
			lib_source_file_name: STRING
			framework_name: STRING
			a_file: RAW_FILE
			executor: EXECUTION_ENVIRONMENT
			managed_pointer: MANAGED_POINTER
			c_string: C_STRING
			i: INTEGER
		do
			lib_source_file_name := "get_type_encodings.m"
			create a_file.make (lib_source_file_name)
			if a_file.exists then
				a_file.delete
			end
			create a_file.make_create_read_write (lib_source_file_name)
			framework_name := configuration.framework_name
			a_file.put_string ("#import <" + framework_name + "/" + framework_name + ".h>%N")
			a_file.put_string ("char *encodings[] = {%N");
			from
				types.start
			until
				types.after
			loop
				a_file.put_string ("%T@encode(" + types.key_for_iteration + ")")
				types.forth
				if not types.after then
					a_file.put_string (",")
				end
				a_file.put_string ("%N")
			end
			a_file.put_string ("};%N")
			a_file.put_string ("char** get_type_encodings() {%N")
			a_file.put_string ("%Treturn encodings;%N")
			a_file.put_string ("}")
			a_file.close
				-- Compile the library.
			create executor
			executor.system ("gcc -dynamiclib -std=gnu99 get_type_encodings.m -o get_type_encodings.dylib")
			--a_file.delete
				-- Get the encodings.
			create managed_pointer.share_from_pointer (c_get_type_encodings, types.count * {PLATFORM}.pointer_bytes)
			from
				i := 0
				types.start
			until
				i = types.count and types.after
			loop
				create c_string.make_shared_from_pointer (managed_pointer.read_pointer (i * {PLATFORM}.pointer_bytes))
				types.force (c_string.string, types.key_for_iteration)
				i := i + 1
				types.forth
			end
		end

feature {NONE} -- Externals

	c_get_type_encodings: POINTER
			-- Load the shared dynamic library and return a pointer to an array of the
			-- Objective-C type encodings.
		external
			"C inline use <objc/runtime.h>,<dlfcn.h>"
		alias
			"[
				void *lib_handle = dlopen("get_type_encodings.dylib", RTLD_NOW);
				char** (*get_type_encodings)(void) = dlsym(lib_handle, "get_type_encodings");
				return get_type_encodings();
			 ]"
		end

end
