note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_STRUCTURE_EDITOR_APPLICATION

inherit
	EV_APPLICATION

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create,
			copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	arg_filename: detachable READABLE_STRING_32
		local
			args: ARGUMENTS_32
			i,n, nb: INTEGER
			s: READABLE_STRING_32
		do
			args := execution_environment.arguments
			if attached args.separate_word_option_value ("filename") as fn then
				Result := fn
			else
				from
					i := 1
					n := args.argument_count
				until
					i > n
				loop
					s := args.argument (i)
					if not s.starts_with_general ("-") then
						if nb > 0 then
							Result := Void
						elseif Result = Void then
							Result := s
						else
						end
						nb := nb + 1
					end
				end
				check nb > 1 implies Result = Void end
			end
		end

	make_and_launch
		do
			default_create
			create main_window
			main_window.show
			if attached arg_filename as s and then not s.is_empty then
				main_window.set_filename_from_string (s)
			end
			launch
		end

feature {NONE} -- Implementation

	main_window: CLASS_STRUCTURE_EDITOR_WINDOW

end -- class CLASS_STRUCTURE_EDITOR_APPLICATION
