indexing

	description:
		"Abstarct notion of a user of resources.";
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
			old_a, new_a: ARRAY_RESOURCE;
			old_f, new_f: FONT_RESOURCE;
			old_c, new_c: COLOR_RESOURCE
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
						old_f ?= old_res;
						if old_f /= Void then
							new_f ?= new_res;
							update_font_resource (old_f, new_f)
						else
							old_c ?= old_res;
							if old_c /= Void then
								new_c ?= new_res
								update_color_resource (old_c, new_c)
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

	update_font_resource (old_res, new_res: FONT_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	update_color_resource (old_res, new_res: COLOR_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	finish_update is
			-- Finish the update of resources.
		do
		end;

end -- class RESOURCE_USER
