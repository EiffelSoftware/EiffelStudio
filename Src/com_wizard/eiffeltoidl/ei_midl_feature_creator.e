indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_FEATURE_CREATOR

inherit
	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_FORBIDDEN_NAMES
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
			tmp_name, tmp_string: STRING
		do
			l_succeed := True

			tmp_name := clone (l_feature.name)
			if c_keywords.has (tmp_name) then
				tmp_string := clone (tmp_name)
				tmp_string.append (message_output.name_is_C_keyword)
				message_output.add_warning (Current, tmp_string)
			end
			create midl_feature.make (tmp_name)

			create type_mapper.make
			midl_feature.set_comment (l_feature.comment)

			if not l_feature.result_type.is_empty then
				if type_mapper.supported_eiffel_type (l_feature.result_type) then
					midl_feature.set_result_type (type_mapper.com_type (l_feature.result_type))
				else
					l_succeed := False
				end
			end

			if not l_feature.parameters.is_empty then
				from
					l_feature.parameters.start
				until
					l_feature.parameters.after
				loop
					if type_mapper.supported_eiffel_type (l_feature.parameters.item.type) then
						com_type := type_mapper.com_type (l_feature.parameters.item.type)
						if com_type /= Void then
							tmp_name := clone (l_feature.parameters.item.name)
							if c_keywords.has (tmp_name) then
								tmp_name.prepend ("a_")
							end

							create midl_parameter.make (tmp_name, com_type )
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
