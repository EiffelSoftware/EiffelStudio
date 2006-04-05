indexing

	description:
		"Abstarct notion of a user of resources."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class RESOURCE_USER

feature -- Dispatch

	dispatch_modified_resource (old_res, new_res: RESOURCE) is
			-- Dispatch modified resource based on
			-- the actual type of `old_res'.
		local
			old_b, new_b: BOOLEAN_RESOURCE;
			old_i, new_i: INTEGER_RESOURCE;
			old_s, new_s: STRING_RESOURCE;
			old_a, new_a: ARRAY_RESOURCE
		do
			old_b ?= old_res;
			if old_b /= Void then
				new_b ?= new_res;
				update_boolean_resource (old_b, new_b)
			else
				old_i ?= old_res;
				if old_i /= Void then
					new_i ?= new_res;
					update_integer_resource (old_i, new_i)
				else
					old_a ?= old_res;
					if old_a /= Void then
						new_a ?= new_res;
						update_array_resource (old_a, new_a)
					else
						old_s ?= old_res;
						if old_s /= Void then
							new_s ?= new_res;
							update_string_resource (old_s, new_s)
						end
					end
				end
			end
		end

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	update_string_resource (old_res, new_res: STRING_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	update_array_resource (old_res, new_res: ARRAY_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	finish_update is
			-- Finish the update of resources.
		do
		end;

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

end -- class RESOURCE_USER
