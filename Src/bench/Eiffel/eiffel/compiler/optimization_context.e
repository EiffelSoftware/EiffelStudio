-- keep track of the optimization context for the current loop

class OPTIMIZATION_CONTEXT

create
	make

feature

	make (a, s: like array_desc) is
		do
			array_desc := a;
			safe_array_desc := s
		end

	array_desc: TWO_WAY_SORTED_SET [INTEGER]

	safe_array_desc: like array_desc

	generated_array_desc: like array_desc

	generated_offsets: like array_desc

	set_generated_array_desc (g: like array_desc) is
		do
			generated_array_desc := g
		end;

	set_generated_offsets (g: like array_desc) is
		do
			generated_offsets := g
		end;

end
