indexing
	description: "Generate Eiffel arguments from .NET arguments"
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_SOLVER

inherit
	NAME_FORMATTER

	SHARED_ASSEMBLY_MAPPING

feature -- Access

	arguments (info: METHOD_BASE): ARRAY [CONSUMED_ARGUMENT] is
			-- Argument of `info'
		require
			non_void_method: info /= Void
		local
			i, count: INTEGER
			en, dn: STRING
			params: NATIVE_ARRAY [PARAMETER_INFO]
			p: PARAMETER_INFO
		do
			create Result.make (1, info.get_parameters.get_length)
			params := info.get_parameters
			from
				i := 0
				count := params.get_length
			until
				i >= count
			loop
				p := params.item (i)
				create dn.make_from_cil (p.get_name)
				en := formatted_variable_name (dn)				
				Result.put (create {CONSUMED_ARGUMENT}.make (dn, en, referenced_type_from_type (p.get_parameter_type), p.get_is_out), i + 1)
				i := i + 1
			end
		ensure
			non_void_arguments: Result /= Void
		end
		
end -- class ARGUMENT_SOLVER
