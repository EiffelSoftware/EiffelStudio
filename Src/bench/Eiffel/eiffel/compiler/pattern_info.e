-- Information about pattern

class PATTERN_INFO 

inherit

	HASHABLE
		redefine
			is_equal
		end;
	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	COMPILER_EXPORTER
		redefine
			is_equal
		end

creation

	make

feature 

	pattern_id: INTEGER;
			-- Pattern unique identifier

	written_in: INTEGER;
			-- Id of the class where the pattern comes from

	pattern: PATTERN;
			-- Pattern

	make (i: INTEGER; p: PATTERN) is
			-- Initialization
		do
			written_in := i;
			pattern := p;
		end;

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i;
		end;

	set_pattern (p: PATTERN) is
			-- Assign `p' to `pattern'.
		do
			pattern := p;
		end;

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i;
		end;

	is_equal (other: PATTERN_INFO): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result :=
				written_in = other.written_in
				and then pattern.is_equal (other.pattern);
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := written_in + pattern.hash_code;
		end;

	associated_class: CLASS_C is
			-- Associated class to the current pattern information
		do
			Result := System.class_of_id (written_in);
		end;

	instantiation_in (type: CL_TYPE_I): PATTERN is
			-- Instantiation of `pattern' in the context of `type'.
		require
			good_argument: type /= Void;
			no_formals: not type.has_formal;
			consistency1: type.base_class.conform_to (associated_class);
			consistency2: 	pattern.has_formal
							implies
					(associated_class.meta_type (type).meta_generic /= Void);
		local
			ancestor_type: CL_TYPE_I;
			gen_type: GEN_TYPE_I;
		do
			Result := pattern;
			if Result.has_formal then
				ancestor_type := associated_class.meta_type (type);
				gen_type ?= ancestor_type;		-- Cannot fail.
				Result := Result.instantiation_in (gen_type);
			end;
		ensure
			no_formal: not Result.has_formal;
		end;

	trace is
			-- Debug purpose
		do
			pattern.trace;
			io.error.putstring (" --> written in ");
			io.error.putstring (associated_class.name);
			io.error.new_line;
		end;

end
