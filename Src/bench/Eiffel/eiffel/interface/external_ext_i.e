indexing

	description: "Encapsulation of an external extension.";
	date: "$Date$";
	revision: "$Revision$"
 
class EXTERNAL_EXT_I

inherit
	SHARED_INCLUDE
		export
			{NONE} Shared_include_queue
		redefine
			is_equal
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		redefine
			is_equal
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		redefine
			is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		redefine
			is_equal
		end

feature -- Status report

	is_il: BOOLEAN is
			-- Is current external an IL one?
		do
		end
		
	is_cpp: BOOLEAN is
		do
		end

	is_macro: BOOLEAN is
		do
		end

	is_dll: BOOLEAN is
		do
		end

	is_struct: BOOLEAN is
		do
		end

	has_signature: BOOLEAN is
		do
			Result := has_arg_list or has_return_type
		end

	has_arg_list: BOOLEAN is
		do
			Result := argument_types /= Void
		end

	has_return_type: BOOLEAN is
		do
			Result := return_type > 0
		end

	has_include_list: BOOLEAN is
		do
			Result := header_files /= Void
		end

feature -- Properties

	argument_types: ARRAY [INTEGER]
			-- Argument types. Values are indexes in NAMES_HEAP.

	return_type: INTEGER
			-- Return type index in NAMES_HEAP

	header_files: ARRAY [INTEGER]
			-- Header files. Values are indexes in NAMES_HEAP.

	alias_name_id: INTEGER
			-- Real name index in NAMES_HEAP of external feature

feature -- Convenience

	alias_name: STRING is
			-- Associated name to `alias_name_id'.
		do
			Result := Names_heap.item (alias_name_id)
		end

feature -- Settings

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a
		end

	set_header_files (h: like header_files) is
			-- Assign `h' to `header_files'.
		do
			header_files := h
		end

	set_return_type (r: like return_type) is
			-- Assign `r' to `return_type'.
		do
			return_type := r
		end

	set_alias_name_id (name_id: like alias_name_id) is
			-- Set `alias_name_id' with `name_id'.
		require
			valid_name_id: name_id > 0
		do
			alias_name_id := name_id
		ensure
			alias_name_id_set: alias_name_id = name_id
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files)
		end

feature {NONE} -- Comparison

	array_is_equal (a, o_a: ARRAY [INTEGER]): BOOLEAN is
		local
			i, nb: INTEGER
		do
			if a = Void then
				Result := o_a = Void
			elseif o_a /= Void then
				nb := a.count
				if o_a.count = nb then
					from
						Result := True
						i := 1
					until
						not Result or else i > nb
					loop
						Result := a.item (i).is_equal (o_a.item (i))
						i := i + 1
					end
				end
			end
		end

feature -- Code generation

	generate_header_files is
			-- Generate header files for the extension.
		local
			i, nb: INTEGER
			queue: like shared_include_queue
		do
			if has_include_list then
				from
					i := header_files.lower
					nb := header_files.upper
					queue := shared_include_queue
				until
					i > nb
				loop
					queue.put (header_files @ i)
					i := i + 1
				end
			end
		end

	generate_external_name (buffer: GENERATION_BUFFER; external_name: STRING;
				type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			buffer.putstring (external_name)
			if has_standard_prototype then
				Extern_declarations.add_routine_with_signature (ret_type,
								external_name, Names_heap.convert_to_string_array (argument_types))
			end
		end

	has_standard_prototype: BOOLEAN is
			-- Does the extension need the standard prototype?
		do
				-- If an include list is provided, the prototype is assumed to
				-- be declared there
			Result := has_signature and not has_include_list
		end

	generate_parameter_cast: BOOLEAN is
			-- Should cast be generated for arguments?
		do
			Result := has_arg_list
		end

	generate_parameter_signature_list is
			-- Generate parameter signature for C polymorphic calls.
		require
			has_signature: has_arg_list
		local
			i, count: INTEGER;
			arg_types: like argument_types
			buffer: GENERATION_BUFFER
			l_names_heap: like Names_heap
			sep: STRING
		do
			buffer := Context.buffer
			from
				arg_types := argument_types
				i := arg_types.lower
				count := arg_types.upper
				l_names_heap := Names_heap
				sep := ", "
			until
				i > count	
			loop
				buffer.putstring (l_names_heap.item (arg_types.item (i)));
				if i /= count then
					buffer.putstring (sep);
				end;
				i := i + 1;
			end;
		end

	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate parameters for C extension
		local
			expr: EXPR_B;
			i: INTEGER;
			generate_cast: BOOLEAN
			arg_types: like argument_types
			buffer: GENERATION_BUFFER
			sep: STRING
			l_names_heap: like Names_heap
		do
			if parameters /= Void then
				buffer := Context.buffer
				sep := ", "

				generate_cast := generate_parameter_cast
 
				if generate_cast then
					arg_types := argument_types
					l_names_heap := Names_heap
					i := arg_types.lower
				end
 
				from
					parameters.start;
				until
					parameters.after
				loop
					expr := parameters.item;
						-- add cast before parameter
					if generate_cast then
						buffer.putchar ('(');
						buffer.putstring (l_names_heap.item (arg_types.item (i)))
						buffer.putchar (')')
						buffer.putchar (' ')
					end;
					expr.print_register;
					if not parameters.islast then
						buffer.putstring (sep)
					end;
					parameters.forth;
					i := i + 1;
				end;
			end;
		end

end -- class EXTERNAL_EXT_I
