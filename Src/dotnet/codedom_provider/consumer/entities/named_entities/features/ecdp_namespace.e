indexing 
	description: "Eiffel representation of a namespace"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_NAMESPACE

inherit
	ECDP_NAMESPACE_INTERFACE

create
	make

feature -- Access

	code: STRING is
			-- | Loop on `types': call `type' on each item.
			-- Eiffel code for a namespace
		local
			a_type: ECDP_GENERATED_TYPE
			a_text_writer: STREAM_WRITER
			l_file_name: STRING
		do
			Ace_file.set_namespace (name)
			Ace_file.set_root_class_name (types.first.name)

			from
				types.start
			until
				types.after
			loop
				a_type := types.item
				if a_type /= Void then
					Resolver.initialize_features (a_type)
					if types.isfirst and then not Ace_file.path_to_generated_src.is_empty then
						Result := a_type.code
					else
						create l_file_name.make_from_string (a_type.name)
						l_file_name.to_lower
						a_text_writer := creation_file (l_file_name)
						a_text_writer.write_string (a_type.code)
						a_text_writer.close
					end
				end
				types.forth
			end
		end

end -- class ECDP_NAMESPACE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
