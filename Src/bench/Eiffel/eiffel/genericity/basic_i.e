deferred class BASIC_I

inherit

	CL_TYPE_I
		rename
			is_void as cl_type_is_void
		redefine
			is_basic, is_reference, c_type, base_class, is_valid
		end;
	TYPE_C
		undefine
			is_bit
		end;
	SHARED_C_LEVEL;

feature

	c_type: TYPE_C is
			-- C type
		do
			Result := Current;
		end;

	is_reference: BOOLEAN is false;
			-- Type is not a reference.

	is_basic: BOOLEAN is
			-- Type is a basic type.
		do
			Result := True;
		end;

	is_valid: BOOLEAN is
		do
			Result := True;
		end;

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		deferred
		end;

	associated_dtype: INTEGER is
			-- Dynamic type of associated reference class
		do
			Result := associated_reference.type_id - 1;
		end;

	base_class: CLASS_C is
			-- Associated class
		do
			Result := associated_reference.associated_class
		end;

	metamorphose
	(reg, value: REGISTRABLE; file: UNIX_FILE; workbench_mode: BOOLEAN) is
			-- Generate the metamorphism from simple type to reference and
		   -- put result in register `reg'. The value of the basic type is
		   -- held in `value'.
		require
			valid_reg: reg /= Void;
			valid_value: value /= Void;
			valid_file: file /= Void
		do
			reg.print_register;
			file.putstring (" = ");
			file.putstring("RTLN(");
			if workbench_mode then
				file.putstring ("RTUD(");
				file.putint (associated_reference.id  - 1);
				file.putchar (')');
			else
				file.putint (associated_dtype);
			end;
			file.putchar (')');
			file.putchar (',');
			file.putchar (' ');
			file.putchar ('*');
			generate_access_cast (file);
			reg.print_register;
			file.putstring (" = ");
			value.print_register;
		end;

end
