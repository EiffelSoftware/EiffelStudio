class D

inherit
	C
		export
			{ANY} -- Available
				faan, faaa, faas, fsan, fsaa, fsas
			{NONE} -- Secret
				fasn, fasa, fass, fssn, fssa, fsss
		end

inherit {NONE}
	C
		export
			{ANY} -- Available
				fana, faaa, fasa, fsna, fsaa, fssa
			{NONE} -- Secret
				fans, faas, fass, fsns, fsas, fsss
		end

end