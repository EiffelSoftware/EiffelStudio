indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_INTERFACE_CREATOR

inherit
	EI_MIDL_COMPONENT_CREATOR

create
	make

feature -- Access

	midl_interface: EI_MIDL_INTERFACE
			-- MIDL interface

feature -- Basic operations

	create_from_eiffel_class (eiffel_class: EI_CLASS) is
			-- Generate MIDL interface from 'eiffel_class'.
		local
			str_buffer: STRING
		do
			create midl_interface.make (eiffel_class.name)
			str_buffer := "Interface for "
			str_buffer.append (eiffel_class.description)

			midl_interface.set_description (str_buffer)

			if not eiffel_class.features.is_empty then
				produce_interface_feature (eiffel_class.features)
			end

			succeed := True
		end

feature {NONE} -- Implementation

	produce_interface_feature (l_features: HASH_TABLE[EI_FEATURE, STRING]) is
			-- Produce features for interface from 'l_features'.
		require
			non_void_input: l_features /= Void
			valid_input: not l_features.is_empty
			non_void_midl_interface: midl_interface /= Void
		local
			feature_creator: EI_MIDL_FEATURE_CREATOR
		do
			from
				l_features.start
			until
				l_features.after
			loop
				create feature_creator.make
				feature_creator.create_from_eiffel_feature (l_features.item_for_iteration)

				if feature_creator.succeed then
					midl_interface.add_feature (feature_creator.midl_feature)
					succeed := True
				end

				l_features.forth
			end
		end

end -- class EI_MIDL_INTERFACE_CREATOR
