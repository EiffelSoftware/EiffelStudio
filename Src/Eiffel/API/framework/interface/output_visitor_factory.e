indexing
	description: "[
		Implementation of a factory class used to instatiate instances of output visitors used in documentation
		generation.
		
		Note: Descendents that require their own visitors for displaying output in some form should extend the base interface
		of {OUTPUT_VISITOR_FACTORY} and return their custom implementation through {COMPILER}.`visitor_factory'. The returned
		object instance is added to the service heap and is accessibile by query for the {OUTPUT_VISITOR_FACTORY} service.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	OUTPUT_VISITOR_FACTORY

inherit
	TEXT_STREAM_ACCESS
		export
			{NONE} all
		end

	SHARED_COMPILER
		export
			{NONE} all
		end

feature -- Factory

	create_error_visitor: OUTPUT_ERROR_VISITOR [TEXT_STREAM]
		deferred
		ensure
			result_attached: Result /= Void
		end

--	create_warning_visitor: WARNING_DOCUMENTATION_VISITOR [TEXT_STREAM]
--		deferred
--		ensure
--			result_attached: Result /= Void
--		end

--	create_output_visitor: OUTPUT_DOCUMENTATION_VISITOR [TEXT_STREAM]
--		deferred
--		ensure
--			result_attached: Result /= Void
--		end

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

end -- class {OUTPUT_VISITOR_FACTORY}
