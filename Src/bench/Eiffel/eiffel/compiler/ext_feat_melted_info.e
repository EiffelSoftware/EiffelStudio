indexing
	description: "Information about external feature recently added to system"
	date: "$Date$"
	revision: "$Revision$"

class
	EXT_FEAT_MELTED_INFO

inherit
	FEAT_MELTED_INFO
		redefine
			internal_execution_unit, make
		end

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; associated_class: CLASS_C) is
			-- Initialization
		local
			extension: EXTERNAL_EXT_I
			ext_i: EXTERNAL_I
		do
			Precursor {FEAT_MELTED_INFO} (f, associated_class)
			ext_i ?= f

			external_name := ext_i.external_name
			include_list := ext_i.include_list
			is_encapsulated := ext_i.is_cpp or ext_i.is_special or ext_i.encapsulated

			extension := ext_i.extension
			if not is_encapsulated and then include_list = Void and then extension /= Void then
				argument_types := extension.argument_types
				if not (argument_types /= Void and then argument_types.count > 0) then
					argument_types := Void
				end
				return_c_type := extension.return_type
			end
		end

feature -- Access

	external_name: STRING
			-- Real name of external feature.

	return_c_type: STRING
			-- Type name of external return type.
	
	argument_types: ARRAY [STRING]
			-- Type name of arguments

	include_list: ARRAY [STRING]
			-- List of header file used by external feature.

	is_encapsulated: BOOLEAN
			-- Is current external an encapsulated one?

feature {NONE} -- Implementation

	internal_execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Create new EXECUTION_UNIT corresponding to Current type.
		local
			incl: EXT_INCL_EXEC_UNIT
			ext: EXT_EXECUTION_UNIT
			res: TYPE_I
			gen_type: GEN_TYPE_I
		do
			if include_list /= Void then
				create incl.make (class_type)
				incl.set_include_list (include_list)
				incl.set_external_name (external_name)
				Result := incl
			else
				create ext.make (class_type)
				ext.set_external_name (external_name)
				ext.set_return_type (return_c_type)
				ext.set_argument_types (argument_types)
				Result := ext
			end

			Result.set_body_index (body_index)
			Result.set_pattern_id (pattern_id)
			Result.set_written_in (written_in)

			res := result_type
			if res.has_formal then
				gen_type ?= class_type.type
				res := res.instantiation_in (gen_type) 
			end

			Result.set_type (res.c_type)
		end

end -- class EXT_FEAT_MELTED_INFO
