indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_FEATURE_CREATOR

inherit

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			succeed := False
		end

feature -- Access

	midl_feature: EI_MIDL_FEATURE

feature -- Status report

	succeed: BOOLEAN
			-- Last operation succeed?

feature -- Basic operations

	create_from_eiffel_feature (l_feature: EI_FEATURE) is
			-- Create MIDL feature from Eiffel feature 'l_feature'.
			-- Set 'succeed' to true if succeeded.
		require
			non_void_feature: l_feature /= Void
		local
			type_mapper: EI_TYPE_MAPPER
			l_succeed: BOOLEAN
			midl_parameter: EI_MIDL_PARAMETER
			com_type: STRING
		do
			l_succeed := True

			create midl_feature.make (l_feature.name)

			create type_mapper.make
			midl_feature.set_comment (l_feature.comment)

			if not l_feature.result_type.empty then
				if type_mapper.support_eiffel_type (l_feature.result_type) then
					midl_feature.set_result_type (type_mapper.com_type (l_feature.result_type))
				else
					l_succeed := False
				end
			end

			if not l_feature.parameters.empty then
				from
					l_feature.parameters.start
				until
					l_feature.parameters.after
				loop
					if type_mapper.support_eiffel_type (l_feature.parameters.item.type) then
						com_type := type_mapper.com_type (l_feature.parameters.item.type)

						if com_type /= Void then
							create midl_parameter.make (l_feature.parameters.item.name, com_type )
							if type_mapper.inout_type then
								midl_parameter.set_flag (Paramflag_fout)
							else
								midl_parameter.set_flag (Paramflag_fin)
							end
							midl_feature.add_parameter (midl_parameter)
						end
					else
						l_succeed := False
					end
					l_feature.parameters.forth
				end
			end

			succeed := l_succeed
		end

end -- class EI_MIDL_FEATURE_CREATOR
