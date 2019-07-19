class A

feature {NONE}

	none_none
		do
		ensure
			class
		end

	none_unexported
		do
		ensure
			class
		end

	none_exported
		do
		ensure
			class
		end

	none_any
		do
		ensure
			class
		end

feature {A}

	unexported_none
		do
		ensure
			class
		end

	unexported_unexported
		do
		ensure
			class
		end

	unexported_exported
		do
		ensure
			class
		end

	unexported_any
		do
		ensure
			class
		end

feature {TEST}

	exported_none
		do
		ensure
			class
		end

	exported_unexported
		do
		ensure
			class
		end

	exported_exported
		do
		ensure
			class
		end

	exported_any
		do
		ensure
			class
		end

feature

	any_none
		do
		ensure
			class
		end

	any_unexported
		do
		ensure
			class
		end

	any_exported
		do
		ensure
			class
		end

	any_any
		do
		ensure
			class
		end

end