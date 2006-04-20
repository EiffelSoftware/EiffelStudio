indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	WIZARD_SHARED_DATA
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

			tmp_name := l_feature.name.twin
			if c_keywords.has (tmp_name) then
				tmp_string := tmp_name.twin
				tmp_string.append (" is C/C++ keyword, please choose another feature name")
				message_output.add_warning (tmp_string)
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
							tmp_name := l_feature.parameters.item.name.twin
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class EI_MIDL_FEATURE_CREATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

