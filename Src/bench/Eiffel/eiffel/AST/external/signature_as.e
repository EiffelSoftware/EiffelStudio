indexing
	description: "Objects that contains an external signature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIGNATURE_AS

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (args: EIFFEL_LIST [EXTERNAL_TYPE_AS]; ret: EXTERNAL_TYPE_AS) is
			-- Create SIGNATURE_AS node
		do
			arguments := args
			return_type := ret
		ensure
			arguments_set: arguments = args
			return_type_set: return_type = ret
		end

feature -- Access

	arguments: EIFFEL_LIST [EXTERNAL_TYPE_AS]
			-- Arguments of external.

	return_type: EXTERNAL_TYPE_AS
			-- Return type of external if any.

feature -- Transformation

	arguments_array: ARRAY [STRING] is
			-- Array representation of `arguments'
		local
			list: like arguments
			i: INTEGER
		do
			if arguments /= Void then
				from
					list := arguments
					create Result.make (1, list.count)
					i := 1
					list.start
				until
					list.after
				loop
					Result.put (list.item.value, i)
					i := i + 1
					list.forth
				end
			end
		end

	return_type_string: STRING is
		do
			if return_type /= Void then
				Result := return_type.value
			else
				Result := "void"
			end
		end

end -- class SIGNATURE_AS
