-- Node for string constants

class STRING_AS

inherit

	COMPARABLE;
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, format
		end

feature -- Attributes

	value: STRING;
			-- Integer value

feature -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		ensure then
			value_exists: not (value = Void or else value.empty);
		end;

feature -- Type check and byte code

	value_i: STRING_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_str_val (value);
		end;

	type_check is
			-- Type check a string constant
		do
				-- Update the type stack
			context.put (String_type);
		end;

	String_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := System.string_class.compiled_class.actual_type;
		end;

	byte_node: STRING_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

feature -- formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			tmp: STRING;
			i: INTEGER
		do
			!! tmp.make (0);
			from
				i := 1
			until
				i > value.count
			loop
				inspect value.item (i)
				when '%N' then
					tmp.append ("%%N");
				when '%U' then
					tmp.append ("%%U");
				when '%B' then
					tmp.append ("%%B");
				when '%F' then
					tmp.append ("%%F");
				when '%R' then
					tmp.append ("%%R");
				when '%%' then
					tmp.append ("%%%%");
				when '%'' then
					tmp.append ("%%%'");
				when '%"' then
					tmp.append ("%%%"");
				else
					tmp.extend (value.item (i))
				end;
				i := i + 1
			end;
			ctxt.put_special ("%"");
			ctxt.put_string (tmp);
			ctxt.put_special ("%"");
			ctxt.always_succeed;
		end;

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := value_i.str_val < other.value_i.str_val 
		end;

	set_value (s: STRING) is
		do
			value := s;
		end;



end
