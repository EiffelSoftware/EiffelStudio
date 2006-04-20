indexing
	description: "Collection of stateless visitors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_STATELESS_VISITOR

feature -- Access

	clickable_info: AST_CLICKABLE_INFO_VISITOR is
			-- Visitor to get CLASS_I and feature names for CLICKABLE_AST nodes
		once
			create Result
		ensure
			clickable_info_not_void: Result /= Void
		end

	clickable_generator: AST_CLICKABLE_VISITOR is
			-- Visitor to generate a CLICK_LIST
		once
			create Result
		ensure
			clickable_generator_not_void: Result /= Void
		end

	export_status_generator: AST_EXPORT_STATUS_GENERATOR is
			-- Visitor to generate EXPORT_I instance from CLIENT_AS
		once
			create Result
		ensure
			export_status_generator_not_void: Result /= Void
		end

	feature_i_generator: AST_FEATURE_I_GENERATOR is
			-- Visitor to create FEATURE_I instance from FEATURE_AS
		once
			create Result
		ensure
			feature_i_generator_not_void: Result /= Void
		end

	feature_checker: AST_FEATURE_CHECKER_GENERATOR is
			-- Visitor to check code of a routine
		once
			create Result
		ensure
			feature_checker_not_void: Result /= Void
		end

	locals_builder: AST_LOCALS_INFO is
			-- Visitor to build table of locals
		once
			create Result
		ensure
			locals_builder_not_void: Result /= Void
		end

	type_a_checker: TYPE_A_CHECKER is
			-- Visitor to check TYPE_A types.
		once
			create Result
		ensure
			type_a_checker_not_void: Result /= Void
		end

	type_a_generator: AST_TYPE_A_GENERATOR is
			-- Visitor to generate potentially unevaluated types.
		once
			create Result
		ensure
			type_a_generator_not_void: Result /= Void
		end

	value_i_generator: AST_VALUE_I_GENERATOR is
			-- Visitor to check types.
		once
			create Result
		ensure
			value_i_generator_not_void: Result /= Void
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

end
