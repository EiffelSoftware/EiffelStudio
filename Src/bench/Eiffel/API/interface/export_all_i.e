indexing
	description: "Representation of an export to any clients"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_ALL_I 

inherit
	EXPORT_I
		redefine
			is_all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end
	
feature -- Properties

	is_all: BOOLEAN is True
			-- Is the current object an instance of EXPORT_ALL_I?

feature -- Access

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current?
		do
			Result := other.is_all
		end

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		do
			Result := not other.is_all
		end

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
			-- Append a representation of `Current' to `st'.
		do
			
		end

feature {COMPILER_EXPORTER}

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status)]
		do
			Result := other.is_all
		end

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with
			-- `other' clients?
		do
			if other.is_all then
				Result := True
			elseif other.is_set then
				Result := other.valid_for (System.any_class.compiled_class)
			end
		end

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export  clause valid for client `client'?
		do
			Result := True
		end

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		do
			Result := Current
		end

	trace is
			-- Debug purpose
		do
			io.error.putstring ("ALL")
		end

	format (ctxt: FORMAT_CONTEXT) is
		do
		end

end
