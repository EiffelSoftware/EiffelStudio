indexing
	description: "Objects that contains an external signature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIGNATURE_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (args: like arguments; ret: EXTERNAL_TYPE_AS) is
			-- Create SIGNATURE_AS node
		do
			arguments := args
			return_type := ret
		ensure
			arguments_set: arguments = args
			return_type_set: return_type = ret
		end

feature -- Access

	arguments: ARRAYED_LIST [EXTERNAL_TYPE_AS]
			-- Arguments of external.

	return_type: EXTERNAL_TYPE_AS
			-- Return type of external if any.

feature -- Transformation

	arguments_id_array: ARRAY [INTEGER] is
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
					Result.put (list.item.value_id, i)
					i := i + 1
					list.forth
				end
			end
		end

	return_type_id: INTEGER is
		do
			if return_type /= Void then
				Result := return_type.value_id
			end
		end

end -- class SIGNATURE_AS
