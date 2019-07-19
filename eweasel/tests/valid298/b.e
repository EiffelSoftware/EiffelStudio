class B

inherit
	A
		export
			{NONE}
				none_none,
				unexported_none,
				exported_none,
				any_none
			{A}
				none_unexported,
				unexported_unexported,
				exported_unexported,
				any_unexported
			{TEST}
				none_exported,
				unexported_exported,
				exported_exported,
				any_exported
			{ANY}
				none_any,
				unexported_any,
				exported_any,
				any_any
		end

end