deferred class TYPE_C

inherit

	HASHABLE
		rename
			same_type as general_same_type
		end

feature

	level: INTEGER is
			-- Internal code for generation
		deferred
		end;

	same_type (other: TYPE_C): BOOLEAN is
			-- Is `other' the same C type as Current ?
		require
			valid_argument: other /= Void;
		do
			Result := other.level = level;
		end;

	is_pointer: BOOLEAN is
			-- Is C type a reference type
		do
			-- Do nothing
		end;

	is_bit: BOOLEAN is
			-- Is C type a a bit type (Conveniencee)
		do
			-- Do nothing
		end;

	is_boolean: BOOLEAN is
			-- Is C type a boolean type ?
		deferred
		end;

	is_void: BOOLEAN is
			-- Is C type a void type
		do
			-- Do nothing
		end;

	trace is
			-- Debug purpose
		deferred
		end;

	description: ATTR_DESC is
		deferred
		end;

	generate (file: INDENT_FILE) is
			-- Generate C type in file `file'.
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end;

	generate_cast (file: INDENT_FILE) is
			-- Generate C cast in file `file'.
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end;

	generate_access_cast (file: INDENT_FILE) is
			-- Generate access C cast in file `file'.
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end;

	generate_function_cast (file: INDENT_FILE) is
			-- Generate C function cast in file `file'.
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end;

	generate_size (file: INDENT_FILE) is
			-- Generate size of C type
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end;

	generate_union (file: INDENT_FILE) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `file'.
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end; -- generate_union

	generate_sk_value (file: INDENT_FILE) is
			-- Generate SK value associated to current C type in `file'.
		require
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		deferred
		end;

end
