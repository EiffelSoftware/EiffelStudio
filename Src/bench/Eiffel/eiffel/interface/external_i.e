-- Internal representation of an external

class EXTERNAL_I 

inherit

	PROCEDURE_I
		rename
			transfer_to as procedure_transfer_to,
			equiv as procedure_equiv
		redefine
			melt, execution_unit, generate,
			access, is_external, new_rout_unit, valid_body_id,
			can_be_inlined
		end;

	PROCEDURE_I
		redefine
			transfer_to, equiv,
			melt, execution_unit, generate,
			access, is_external, new_rout_unit, valid_body_id,
			can_be_inlined
		select
			transfer_to, equiv
		end;
	
feature -- Attributes for externals

	dll_arg: STRING;
			-- Extra arg for dll (Windows)

	special_id: INTEGER;
			-- special id of external if it is

	special_file_name: STRING;
			-- File name including the macro definition
 
	arg_list: EXTERNALS_LIST;
			-- List of arguments for the signature

	return_type: STRING;
			-- Result type of signature

	include_list: EXTERNALS_LIST;
			-- List of include files

feature -- Routines for externals

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

	set_dll_arg (s: STRING) is
			-- set `dll_arg' to s
		do
			dll_arg := s;
		end;

	set_special_id (i: INTEGER) is
			-- Assign `i' to `special_id'
		do
			special_id := i;
		end;

	set_special_file_name (s: STRING) is
			-- Assign `s' to `special_file_name'
		do
			special_file_name := s;
		end;

	set_arg_list (a: like arg_list) is
			-- Assign `a' to `arg_list'
		do
			arg_list := a;
		end;

	set_return_type (s: STRING) is
			-- Assign `s' to `return_type'
		do
			return_type := s;
		end;

	set_include_list (a: like include_list) is
			-- Assign `a' to `include_list'
		do
			include_list := a;
		end;

feature -- Incrementality

	equiv (other: FEATURE_I): BOOLEAN is
		local
			other_ext: EXTERNAL_I
		do
			Result := procedure_equiv (other);
			if Result then
				other_ext ?= other; -- Cannot fail
				if include_list /= Void then
					Result := include_list.equiv (other_ext.include_list)
				else
					Result := other_ext.include_list = Void
				end;
				Result := Result and then
					equal (alias_name, other_ext.alias_name) and then
					encapsulated = other_ext.encapsulated
				if Result and then encapsulated then
					if arg_list /= Void then
						Result := arg_list.equiv (other_ext.arg_list)
					else
						Result := other_ext.arg_list = Void
					end
					Result := Result and then
						equal (dll_arg, other_ext.dll_arg) and then
						equal (return_type, other_ext.return_type) and then
						equal (special_file_name, other_ext.special_file_name) and then
						special_id = other_ext.special_id
				end
			end
		end

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
				-- FIXME
				-- FIXME
				-- FIXME
				-- FIXME
				-- FIXME
				-- The test for freezing is done in `equiv' from FEATURE_TABLE
				-- This is a TEMPORARY solution (3.3 beta bootstrap)!!!!!!


				-- for a macro or a signature in an external declaration
				-- the external is not handled as a `standard' external
				-- and the system does not freeze by itself. We have to
				-- tell it. In fact, this doesn't take the incrementality 
				-- into account: if the macro definition is removed, there is no
				-- need to freeze the system but no way to tell the 
				-- system unless we use the same scheme as for the `standard'
				-- externals.
			--if b then 
				--System.set_freeze (True);
			--end;
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
			external_b.set_special_id (special_id);
			external_b.set_special_file_name (special_file_name);
			external_b.set_include_list (include_list);
			external_b.set_arg_list (arg_list);
			external_b.set_return_type (return_type);
			external_b.set_dll_arg (dll_arg);
			
			Result := external_b;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			procedure_transfer_to (other);
			other.set_alias_name (alias_name);
			other.set_encapsulated (encapsulated);
			other.set_special_id (special_id);
			other.set_arg_list (arg_list);
			other.set_return_type (return_type);
			other.set_special_file_name (special_file_name);
			other.set_include_list (include_list);
			other.set_dll_arg (dll_arg);
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
			Result.set_encapsulated (encapsulated);
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
			elseif has_include_list then
				!EXT_INCL_EXEC_UNIT! Result.make (cl_type, Current)
			else
				!EXT_EXECUTION_UNIT! Result.make (cl_type, Current)
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

feature -- Inlining

	can_be_inlined: BOOLEAN is False

end
