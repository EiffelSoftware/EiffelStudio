-- Internal representation of an external

class EXTERNAL_I 

inherit

	PROCEDURE_I
		rename
			transfer_to as procedure_transfer_to
		redefine
			melt, execution_unit, generate,
			access, is_external, new_rout_unit, valid_body_id
		end;

	PROCEDURE_I
		redefine
			transfer_to,
			melt, execution_unit, generate,
			access, is_external, new_rout_unit, valid_body_id
		select
			transfer_to
		end;
	
feature -- external characteristics

	is_special: BOOLEAN is
			-- Does the external declaration include a macro
		do
			Result := (special_file_name /= Void);
		end;

	has_signature: BOOLEAN is
			-- Does the external declaration include a signature ?
		do
			Result := (has_arg_list or else has_return_type);
		end;

	has_arg_list: BOOLEAN is
			-- Does the signature include arguments ?
		do
			Result := (arg_list /= Void) and then (arg_list.count > 0);
		end;

	has_return_type: BOOLEAN is
			-- Does the signature include a result type ?
		do
			Result := (return_type /= Void);
		end;

	has_include_list: BOOLEAN is
			-- Does the external declaration include a list of include files ?
		do
			Result := (include_list /= Void) and then (include_list.count > 0);
		end;

	special_type: STRING;
			-- special type of external if it is

	special_file_name: STRING;
			-- File name including the macro definition
 
	arg_list: ARRAY[STRING];
			-- List of arguments for the signature

	return_type: STRING;
			-- Result type of signature

	include_list: ARRAY[STRING];
			-- List of include files

	set_special_type (s: STRING) is
			-- Assign `s' to `special_type'
	do
		special_type := s;
	end;

	set_special_file_name (s: STRING) is
			-- Assign `s' to `special_file_name'
	do
		special_file_name := s;
	end;

	set_arg_list (a: ARRAY[STRING]) is
			-- Assign `a' to `arg_list'
	do
		arg_list := a;
	end;

	set_return_type (s: STRING) is
			-- Assign `s' to `return_type'
	do
		return_type := s;
	end;

	set_include_list (a: ARRAY[STRING]) is
			-- Assign `a' to `include_list'
	do
		include_list := a;
	end;

feature 

	alias_name: STRING;
			-- Alias for the external

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	set_alias_name (s: STRING) is
			-- Assign `s' to `alias_name'.
		do
			alias_name := s;
		end;

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'.
		do
			encapsulated := b;
				-- for a macro or a signature in an external declaration
				-- the external is not handled as a `standard' external
				-- and the system does not freeze by itself. We have to
				-- tell it. In fact, this doesn't take the incrementality 
				-- into account: if the macro definition is removed, there is no
				-- need to freeze the system but no way to tell the 
				-- system unless we use the same scheme as for the `standard'
				-- externals.
			if b then 
				System.set_freeze (True);
			end;
		end;

	is_external: BOOLEAN is
			-- Is the feature an external one ?
		do
			Result := True;
		end;

	external_name: STRING is
			-- External name
		do
			if alias_name = Void then
				Result := feature_name;
			else
				Result := alias_name;
			end;
		end;

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			external_b: EXTERNAL_B;
		do
			!!external_b;
			external_b.init (Current);
			external_b.set_type (access_type);
			external_b.set_external_name (external_name);
			external_b.set_encapsulated (encapsulated);
			external_b.set_special_type (special_type);
			external_b.set_special_file_name (special_file_name);
			external_b.set_include_list (include_list);
			external_b.set_arg_list (arg_list);
			external_b.set_return_type (return_type);
			
			Result := external_b;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			procedure_transfer_to (other);
			other.set_alias_name (alias_name);
			other.set_encapsulated (encapsulated);
			other.set_special_type (special_type);
			other.set_arg_list (arg_list);
			other.set_return_type (return_type);
		end;

	new_rout_unit: EXTERNAL_UNIT is
			-- New external unit
		do
			!!Result;
			Result.set_body_index (body_index);
			Result.set_type (type.actual_type);
			Result.set_written_in (written_in);
			Result.set_pattern_id (pattern_id);
			Result.set_external_name (external_name);
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_EXTERNAL_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_EXTERNAL_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	generate (class__type: CLASS_TYPE; file: INDENT_FILE) is
				-- Generate feature written in `class__type' in `file'.
		require else
			valid_file: file /= Void;
			file_open_for_writing: file.is_open_write or file.is_open_append;
			written_in_type: class__type.associated_class.id = generation_class_id;
			not_deferred: not is_deferred;
		local
			byte_code: BYTE_CODE;
		do
				-- if the external declaration has a macro or a signature
				-- then encapsulated is True; otherwise do nothing
			if encapsulated then
				generate_header (file);
				byte_code := Byte_server.disk_item (body_id);
					-- Generation of C code for an Eiffel feature written in
					-- the associated class of the current type.
				byte_context.set_byte_code (byte_code);
					-- Generation of the C routine
				byte_code.analyze;
				byte_code.set_real_body_id (real_body_id);
				byte_code.generate;
				byte_context.clear_all;
			end;
		end;

	valid_body_id: BOOLEAN is
				-- if the external is encapsulated then an EXECUTION_UNIT
				-- has been defined instead of an EXT_EXECUTION_UNIT
				-- and real_body_id can be called
		do
			Result := encapsulated;
		end;

	execution_unit (cl_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Execution unit
		do
			if is_special or has_signature then
				!!Result.make (cl_type, Current);
			else
				!EXT_EXECUTION_UNIT!Result.make (cl_type, Current);
			end;
		end; 

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
		do
				-- No byte code for externals
			Dispatch_table.mark_melted (dispatch);
				-- An external cannot be melted: no insertion of `exec' in
				-- `Execution_table'.
		end;

end
