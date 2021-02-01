class TEST

inherit {NONE}
	A

create
	make

feature

	make
		local
			b: B
			d: D
		do
				-- Non-conforming inheritance only.
			create b
			b.fan
			b.faa
			$ERROR b.fas
			$ERROR b.fsn
			b.fsa
			$ERROR b.fss
				-- Conforming and non-conforming inheritance.
			create d
			d.fann
			d.fana
			d.fans
			d.faan
			d.faaa
			d.faas
			d.fasn
			d.fasa
			d.fass
			$ERROR d.fsnn
			d.fsna
			$ERROR d.fsns
			d.fsan
			d.fsaa
			d.fsas
			$ERROR d.fssn
			d.fssa
			$ERROR d.fsss
		end

end
