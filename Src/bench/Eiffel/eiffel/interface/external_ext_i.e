indexing

	description:
        "Encapsulation of an external extension.";
    date: "$Date$";
    revision: "$Revision$"
 
class EXTERNAL_EXT_I

inherit
	SHARED_INCLUDE
		redefine
			is_equal
		end
	SHARED_DECLARATIONS
		redefine
			is_equal
		end

feature

	is_cpp: BOOLEAN is
		do
		end

	is_macro: BOOLEAN is
		do
		end

	has_signature: BOOLEAN is
		do
			Result := has_arg_list or has_return_type
		end

	has_arg_list: BOOLEAN is
		do
			Result := argument_types /= void
		end

	has_return_type: BOOLEAN is
		do
			Result := return_type /= Void
		end

	has_include_list: BOOLEAN is
		do
			Result := header_files /= Void
		end

feature -- Properties

	argument_types: ARRAY [STRING]

	return_type: STRING

	header_files: ARRAY [STRING]

feature -- Initialization

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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				equal (return_type, other.return_type) and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files)
		end

feature {NONE} -- Comparison

	array_is_equal (a, o_a: ARRAY [STRING]): BOOLEAN is
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
			header_file: STRING
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
					header_file := header_files @ i
					if not queue.has (header_file) then
						queue.extend (header_file)
					end
					i := i + 1
				end
			end
		end

	generate_external_name (gen_file: INDENT_FILE; external_name: STRING;
				entry: POLY_TABLE [ENTRY]; type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			gen_file.putstring (external_name)
			if has_standard_prototype then
				Extern_declarations.add_routine (ret_type, external_name);
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
		do
			Result := has_arg_list
		end

end -- class EXTERNAL_EXT_I
