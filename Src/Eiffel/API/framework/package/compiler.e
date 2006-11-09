indexing
	description: "[
		Compiler framework common base class.

		This class is the root of all compiler packages. It must be descended and all deferred feature implemented according to
		their contracts.
		
		Upon activation and initialization the compiler will set itself on {SHARED_COMPILER} and from there will be register and
		"sited". The call site object {COMPILER} is sited with is the global service provider {SERVICE_PROVIDER}, implemented on {SERVICE_HEAP}.
		The site can be accessed from `service_provider' where any globablly registered (promoted) services can be queried from.
		
		From `service_provider' clients can query for any registered services. A number of services are automatically register on the heap
		when {COMPILER} is sited. Look to `add_services' to see those added. Also see {SHARED_SERVICE_PROVIDER} for more information.
		
		Note: In order to activate and initialize a compiler correctly {SHARED_COMPILER}.set_compiler (Current) needs to be called. Once
		called it sets of a chain of calls to ensure a compiler other defaults are initialized correctly. Failure to make this call will result
		in unpredicatable behavior and even failures. Descendent, be sure to call {COMPILER}.make before anything else.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	COMPILER

inherit
	SHARED_COMPILER
		export {NONE}
			all
		end

	SITE [SERVICE_PROVIDER]
		rename
			site as service_provider
		export {NONE}
			all
		redefine
			set_site
		end

	SERVICE_PROVIDER

	DISPOSABLE

feature {NONE} -- Initialization

	make is
			-- Initializes compiler
		do
				-- Site shared compiler and begin initialization
			set_compiler (Current)
		end

	set_site (a_site: like service_provider)
			-- Site compiler with a service provider.
			-- Note: This function should not be called explictly by your code.
		local
			retried: BOOLEAN
		do
			if not retried then
				Precursor {SITE} (a_site)
				add_services
				initialize
				is_initialized := True
			else
				dispose
				Precursor {SITE} (Void)
			end
		rescue
			retried := True
			retry
		end

	initialize is
			-- All other initialization require to be done.
			-- This routine is called once shared compiler has been sited. There is no need to call this
			-- routine explicitly.
		require
			not_is_initialized: not is_initialized
		deferred
		ensure
				-- `is_initialized' should not be set by this routine
			not_is_initialized: not is_initialized
		end

feature -- Clean up

	dispose
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			if not is_in_final_collect then
				if service_provider /= Void then
					remove_services
				end
			end
		end

feature -- Access

	project_factory: PROJECT_FACTORY is
			-- Factory used to create new Eiffel projects
		require
			is_initialized: is_initialized
		once
			create Result.make (project_loader)
		ensure
			result_attached: Result /= Void
		end

	output_visitor_factory: OUTPUT_VISITOR_FACTORY is
			-- Access to factory for creating visitor specifically for output
		require
			is_initialized: is_initialized
		deferred
		ensure
			result_attached: Result /= Void
		end

	degree_output: DEGREE_OUTPUT --[TEXT_STREAM] is
			-- Output formatter for degree output information
		require
			is_initialized: is_initialized
		deferred
		ensure
			result_attached: Result /= Void
		end

	text_stream_provider: TEXT_STREAM_PROVIDER is
			-- Access to a mean to retrieve a text stream for output
		require
			is_initialized: is_initialized
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Inidicate if compiler was initialized

feature -- Query

	query_service (a_type: TYPE [ANY]): ANY is
			-- Queries for service `a_type' and returns result if service was found on Current
		local
			l_provider: like service_provider
		do
			l_provider := service_provider
			if l_provider /= Void then
				Result := l_provider.query_service (a_type)
			end
		end

	proffers_service (a_type: TYPE [ANY]): BOOLEAN is
			-- Determines if service associate with type `a_type' is being proffered.
		require
			a_type_attached: a_type /= Void
		local
			l_container: SERVICE_CONTAINER
		do
			l_container ?= query_service ({SERVICE_CONTAINER})
			check l_container_attached: l_container /= Void end
			if l_container /= Void then
				Result := l_container.proffers_service (a_type, True)
			end
		end

feature {NONE} -- Service management

	add_services is
			-- Add all services require by compiler to `service_handler'.
		require
			service_provider_attached: service_provider /= Void
		local
			l_handler: like service_handler
		do
			l_handler := service_handler

				--|
				--| Add services required by compiler internals
				--|

				-- Add services with dealyed creation
			l_handler.add_service_with_activator ({DEGREE_OUTPUT}, agent degree_output, True)
			l_handler.add_service_with_activator ({TEXT_STREAM_PROVIDER}, agent text_stream_provider, True)
			l_handler.add_service_with_activator ({OUTPUT_VISITOR_FACTORY}, agent output_visitor_factory, True)
		ensure
			degree_output_proffered: proffers_service ({DEGREE_OUTPUT})
			dtext_stream_provider_proffered: proffers_service ({TEXT_STREAM_PROVIDER})
			output_visitor_factory_proffered: proffers_service ({OUTPUT_VISITOR_FACTORY})
		end

	remove_services is
			-- Removes all services added to `service_handler'.
		require
			service_provider_attached: service_provider /= Void
		do
			service_handler.revoke_all
		end

feature {NONE} -- Implementation

	project_loader: PROJECT_LOADER is
			-- Project loader used to perform loading of projects
		deferred
		ensure
			result_attached: Result /= Void
		end

	service_handler: SERVICE_HANDLER is
			-- Handler used to handle adding and removing of services for compiler.
		require
			service_provider_attached: service_provider /= Void
		local
			l_container: SERVICE_CONTAINER
		once
			l_container ?= query_service ({SERVICE_CONTAINER})
			check l_container_attached: l_container /= Void end
			create Result.make (l_container)
		end

invariant
	service_provider_attached: is_initialized implies service_provider /= Void

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

end -- class {COMPILER}
