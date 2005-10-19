indexing
	description: "[
			Factory to create a custom attribute to a specific
			.NET feature or class given provided information.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_ATTRIBUTE_FACTORY

inherit
	ANY

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end
		
	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

feature -- Settings

	set_feature_custom_attributes (a_feature: FEATURE_I; a_feature_token: INTEGER) is
			-- Extract all defined custom attribute of `a_feature' if any
			-- and applied them to `a_feature_token'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_token_valid: a_feature_token /= 0
		local
			feature_as: FEATURE_AS
			attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			l_attributes: BYTE_LIST [BYTE_NODE]
			l_class_c: CLASS_C
		do
			if not a_feature.is_attribute and not a_feature.is_type_feature then
				l_attributes := a_feature.custom_attributes
			else
				feature_as := a_feature.body
				if feature_as /= Void then
					attributes := feature_as.custom_attributes
					if attributes /= Void then
							-- Initialize data structures needed to perform a `type_check'
							-- and to create a `byte_node' for every creation expression
							-- that represent the custom attribute
						l_class_c := cil_generator.current_class_type.associated_class
						Inst_context.set_cluster (l_class_c.cluster)
						context.initialize (l_class_c, l_class_c.actual_type, l_class_c.feature_table)
						feature_checker.init (context)
						feature_checker.custom_attributes_type_check_and_code (a_feature, attributes)
						l_attributes ?= feature_checker.last_byte_node
					end
				end
			end
			if l_attributes /= Void then
				generate_custom_attributes (a_feature_token, l_attributes)
			end
		end

feature {CIL_CODE_GENERATOR} -- Generation

	generate_custom_attributes (a_owner_token: INTEGER; ca: BYTE_LIST [BYTE_NODE]) is
			-- Generate custom attributes represented by `ca'
			-- using `a_owner_token' as target.
		require
			a_owner_token_valid: a_owner_token /= 0
			has_custom_attributes: ca /= Void
		local
			ca_b: CUSTOM_ATTRIBUTE_B
			l_gen: CUSTOM_ATTRIBUTE_GENERATOR
		do
			from
				l_gen := custom_attribute_generator
				ca.start
			until
				ca.after
			loop
				ca_b ?= ca.item
				check ca_b_not_void: ca_b /= Void end
				l_gen.generate (ca_b, a_owner_token, cil_generator)
				ca.forth
			end
		end
	
feature {NONE} -- Implementation

	custom_attribute_generator: CUSTOM_ATTRIBUTE_GENERATOR is
			-- Visitor to generate a custom attribute blob.
		once
			create Result
		ensure
			custom_attribute_generator_not_void: Result /= Void
		end
		
end -- class CUSTOM_ATTRIBUTE_FACTORY
