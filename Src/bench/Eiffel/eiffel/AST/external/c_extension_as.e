indexing
	description: "Encapsulation of a C external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part
		end

create
	default_create,
	initialize

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (sig: SIGNATURE_AS; use_list: USE_LIST_AS) is
			-- Create a new C_EXTENSION_AS node
		do
			if sig /= Void then
				argument_types := sig.arguments_id_array
				if sig.return_type /= Void then
					return_type := sig.return_type.value_id
				end
			end
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		end

feature -- Get the C extension

	extension_i: C_EXTENSION_I is
			-- C_EXTENSION_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the special part
			--| By default, it is empty
		local
			s: like special_part
		do
			s := special_part
			if s /= Void and then s.count /= 0 then
				raise_error ("Invalid sub-language routine clause")
			end
		end

end -- class C_EXTENSION_AS
