indexing
	description: "[
		Check whether product is correctly activated,
		decrement remaining executions counter otherwise.
		When counter reaches 0, product must be activated.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVATION_CHECKER_I
	
inherit
	PRODUCT_INFO
		rename
			name as product_name,
			version as product_version
		export
			{NONE} product_name, product_version, activation_site, logo_180x320, logo_64x64, Short_name
		end

feature -- Access

	can_run: BOOLEAN
			-- Are we authorized to run this product?
			
	is_licensed: BOOLEAN
			-- Is product fully licensed?
			
	is_evaluating: BOOLEAN
			-- Is product in evaluation mode?

	username: STRING is
			-- Name of registered user.
		require
			is_licensed: is_licensed
		once
			Result := engine.username
		end

feature -- Basic Operations

	check_activation is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
		deferred
		end

	check_activation_while_running (a_next_action: PROCEDURE [ANY, TUPLE]) is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
		require
			a_next_action_not_void: a_next_action /= Void
		deferred
		end

	check_license is
			-- Check license information and set `can_run', `is_licensed' and `is_evaluating'
			-- to their proper value?
		do
			if engine.is_initialized then
				is_licensed := engine.is_activated
				is_evaluating := not is_licensed
			else
				can_run := False
				is_licensed := False
				is_evaluating := False
				report_engine_not_initialized
			end
		end

feature {NONE} -- Implementation

	report_engine_not_initialized is
			-- Action to be performed when engine is not initialized.
		deferred
		end

	not_initialized_error_message: STRING is
			-- Standard message when product has not been installed correctly with license information.
"[
The installation of this product has been corrupted.
Please run the installation program again.

If this problem still persists, please send a problem
report to Eiffel Software support through
http://support.eiffel.com.
]"

	launch_gc_cycle is
			-- Launch a GC cycle to move objects around that way it
			-- is harder to hack the value of `is_licensed'.
		local
			mem: MEMORY
		do
			create mem
			mem.collect
			mem.full_collect
			mem.full_coalesce
		end

	set_can_run is
			-- Set `can_run' with `l_can_run'.
		do
			can_run := True
			is_licensed := engine.is_activated
			is_evaluating := not is_licensed
		ensure
			can_run_set: can_run
		end

	engine: KG_ENGINE is
			-- Engine used for license checking.
			-- Once per object, so that we can license more parts within our product.
		do
			if internal_engine = Void then
				create Result.make (Product_name, Product_version)
				internal_engine := Result
			end
			Result := internal_engine
		end

	internal_engine: KG_ENGINE;
			-- Engined used for license checking.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ACTIVATION_CHECKER_I
