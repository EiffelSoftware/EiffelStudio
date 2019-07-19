class B

inherit
	A
		redefine
			none_none,
			none_unexported,
			none_exported,
			none_any,
			exported_none,
			exported_unexported,
			exported_exported,
			exported_any,
			unexported_none,
			unexported_unexported,
			unexported_exported,
			unexported_any,
			any_none,
			any_unexported,
			any_exported,
			any_any
		end

feature {NONE}

	none_none
		do
		end

	unexported_none
		do
		end

	exported_none
		do
		end

	any_none
		do
		end

feature {A}

	none_unexported
		do
		end

	unexported_unexported
		do
		end

	exported_unexported
		do
		end

	any_unexported
		do
		end

feature {TEST}

	none_exported
		do
		end

	unexported_exported
		do
		end

	exported_exported
		do
		end

	any_exported
		do
		end

feature

	none_any
		do
		end

	unexported_any
		do
		end

	exported_any
		do
		end

	any_any
		do
		end

end