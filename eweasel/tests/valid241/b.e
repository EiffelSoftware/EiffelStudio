class B [G, H]

feature
	c    alias "@":                  like Current
	g    alias "@@":                 G
	h    alias "@@@":                H
	ic   alias "@@@@":               A [like Current]
	ig   alias "@@@@@":              A [G]
	ih   alias "@@@@@@":             A [H]
	lc   alias "@@@@@@@":            like c
	lg   alias "@@@@@@@@":           like g
	lh   alias "@@@@@@@@@":          like h
	lic  alias "@@@@@@@@@@":         like ic
	lig  alias "@@@@@@@@@@@":        like ig
	lih  alias "@@@@@@@@@@@@":       like ih
	ilc  alias "@@@@@@@@@@@@@":      A [like c]
	ilg  alias "@@@@@@@@@@@@@@":     A [like g]
	ilh  alias "@@@@@@@@@@@@@@@":    A [like h]
	ilic alias "@@@@@@@@@@@@@@@@":   A [like ic]
	ilig alias "@@@@@@@@@@@@@@@@@":  A [like ig]
	ilih alias "@@@@@@@@@@@@@@@@@@": A [like ih]

	fc    alias "@"                  (a: like Current):     like Current     do end
	fg    alias "@@"                 (a: G):                G                do end
	fh    alias "@@@"                (a: H):                H                do end
	fic   alias "@@@@"               (a: A [like Current]): A [like Current] do end
	fig   alias "@@@@@"              (a: A [G]):            A [G]            do end
	fih   alias "@@@@@@"             (a: A [H]):            A [H]            do end
	flc   alias "@@@@@@@"            (a: like c):           like c           do end
	flg   alias "@@@@@@@@"           (a: like g):           like g           do end
	flh   alias "@@@@@@@@@"          (a: like h):           like h           do end
	flic  alias "@@@@@@@@@@"         (a: like ic):          like ic          do end
	flig  alias "@@@@@@@@@@@"        (a: like ig):          like ig          do end
	flih  alias "@@@@@@@@@@@@"       (a: like ih):          like ih          do end
	filc  alias "@@@@@@@@@@@@@"      (a: A [like c]):       A [like c]       do end
	filg  alias "@@@@@@@@@@@@@@"     (a: A [like g]):       A [like g]       do end
	filh  alias "@@@@@@@@@@@@@@@"    (a: A [like h]):       A [like h]       do end
	filic alias "@@@@@@@@@@@@@@@@"   (a: A [like ic]):      A [like ic]      do end
	filig alias "@@@@@@@@@@@@@@@@@"  (a: A [like ig]):      A [like ig]      do end
	filih alias "@@@@@@@@@@@@@@@@@@" (a: A [like ih]):      A [like ih]      do end

end