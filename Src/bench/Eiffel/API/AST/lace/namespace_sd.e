indexing
	description: "AST structure in Lace file for use of namespace for eiffel classes."
	date: "$Date$"
	revision: "$Revision$"

class NAMESPACE_SD

inherit
	OPTION_SD
		redefine
			is_namespace
		end

	SHARED_OPTION_LEVEL

	EIFFEL_ENV

feature -- Properties

	option_name: STRING is "namespace"

	is_namespace: BOOLEAN is True
			-- Is Current a namespace option?

feature {COMPILER_EXPORTER} -- Update

	adapt (value: OPT_VAL_SD
			classes:HASH_TABLE [CLASS_I, STRING]
			list: LACE_LIST [ID_SD]) is
		local
			error_raised: BOOLEAN
			l_namespace: STRING
		do
			if value /= Void and then value.is_name then
				l_namespace := value.value
			else
				error (value)
			end

			if not error_raised then
				if list = Void then
					from
						classes.start
					until
						classes.after
					loop
						classes.item_for_iteration.set_namespace (l_namespace)
						classes.forth
					end
				else
					from
						list.start
					until
						list.after
					loop
						classes.item (list.item.as_lower).set_namespace (l_namespace)
						list.forth
					end
				end
			end
		end

end -- class NAMESPACE_SD 
